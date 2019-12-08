using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using System.Threading;
using System.Windows;
using System.Windows.Controls;
using System.Windows.Data;
using System.Windows.Documents;
using System.Windows.Input;
using System.Windows.Media;
using System.Windows.Media.Imaging;
using System.Windows.Navigation;
using System.Windows.Shapes;
using System.Data.Odbc;
using System.IO;
using System.Data.Common;
using System.Collections;
using System.ComponentModel;
using System.Data;
using Excel = Microsoft.Office.Interop.Excel;
using Microsoft.Office.Core;
using Microsoft.Office.Tools;
using System.Dynamic;
using System.Activities.Statements;
using System.Activities.Expressions;

namespace WpfApplication4
{
    class Class2
    {
        public Class2(Control tbInfo, TextBox tbStatus, Control prBar, string tempPath, Button btn_start, Button btn_ExcelLoad) 
        {
            this.c = tbInfo;
            this.prBar = prBar;
            this.tempPath = tempPath;
            this.btn_start = btn_start;
            this.tbStatus = tbStatus;
            this.btn_ExcelLoad = btn_ExcelLoad;
            delegateArray.Add("Combine_srok", DBFunctions.Combine_srok);
            delegateArray.Add("Combine_obraz", DBFunctions.Combine_obraz);
            delegateArray.Add("Combine_chasti", DBFunctions.Combine_chasti);
            delegateArray.Add("Combine_grazhd", DBFunctions.Combine_grazhd);
            delegateArray.Add("Combine_narush", DBFunctions.Combine_narush);
        }
             public static string queryString = "SET DELETED ON; SELECT card.itemperson,  Card.vfamily, Card.vname, Card.vlastname, Card.vdatar, Pc52.name FROM card LEFT OUTER JOIN pc52 ON Pc52.item = Card.vnomotr  WHERE ( Card.vpr_osv+Card.vpobeg+Card.vubylpost+Card.vumer ) == ( 0 )";
             public static string queryStringAdd = ""; // Если указаны номера отрядов, то добавляем ее к основному запросу
             Control c;
             Control prBar;
             Button btn_start;
             Button btn_ExcelLoad;
             TextBox tbStatus;
             public static Dictionary<string, Combiner> delegateArray = new Dictionary<string, Combiner>();  // Список делегатов для сбора инфы по отмеченным галкам           
             public delegate void Combiner(object zk, OdbcConnection conn);
             string tempPath; // Путь ко временной папке 
             public static Dictionary<int, Zk> resultList = new Dictionary<int,Zk>();
             public static List<Dictionary<string,string>> headerRow = new List<Dictionary<string,string>>(); // Строка заголовка при выгрузке в Excel
                       
            public void collectInfo(){
            headerRow.Add(new Dictionary<string, string>(){{"Фамилия","General"}});
            headerRow.Add(new Dictionary<string, string>() { { "Имя", "General" } });
            headerRow.Add(new Dictionary<string, string>() { { "Отчество", "General" } });
            headerRow.Add(new Dictionary<string, string>() { { "Дата рождения", "m/d/yyyy"} });
            headerRow.Add(new Dictionary<string, string>() { { "Отряд", "General" } });
            headerRow.Add(new Dictionary<string, string>() { { "Статья", "General" } });
            string connectionString = "Driver={Microsoft FoxPro VFP Driver (*.dbf)};SourceType=DBF;SourceDB=" + tempPath + ";Exclusive=No; NULL=NO;DELETED=NO;BACKGROUNDFETCH=NO;";
            OdbcConnection conn = new OdbcConnection(connectionString);
            conn.Open();                       
            OdbcCommand cmd = conn.CreateCommand();
            //Забираем общую инфу по каждому из зеков в наличии (фамилию, имя, отчество, дату рождения, номер отряда)
            cmd.CommandText = queryString + queryStringAdd;
            c.Dispatcher.Invoke(delegate() { ((TextBox)c).Text += "Соединение с базой установлено... \r\n"; });
            DataTable dt = new DataTable();
            dt.Load(cmd.ExecuteReader());          
            c.Dispatcher.Invoke(delegate() { tbStatus.Text += "Всего записей найдено: " + dt.Rows.Count.ToString() + "\r\n"; });
            prBar = (ProgressBar)prBar;
            prBar.Dispatcher.Invoke(() => { ((ProgressBar)prBar).Maximum = dt.Rows.Count; });
            c.Dispatcher.Invoke(delegate() { ((TextBox)c).Text += "Выбираем общую информацию...\r\n"; });
            for (int i = 0; i < dt.Rows.Count; i++) // Заталкиваем каждому зеку в поле forOutput инфу, готовую для выгрузки в Excel, и заполняем свойства каждого из элементов resultList (Там лежат объекты ZK)
            {
                resultList.Add(i, new Zk(dt.Rows[i][0].ToString(), dt.Rows[i][1].ToString(), dt.Rows[i][2].ToString(), dt.Rows[i][3].ToString(), dt.Rows[i][4].ToString(), dt.Rows[i][4].ToString()));
                resultList[i].forOutput.Add(dt.Rows[i][1].ToString().Trim());
                resultList[i].forOutput.Add(dt.Rows[i][2].ToString().Trim());
                resultList[i].forOutput.Add(dt.Rows[i][3].ToString().Trim());
                resultList[i].forOutput.Add(dt.Rows[i][4].ToString().Trim());
                resultList[i].forOutput.Add(dt.Rows[i][5].ToString().Trim());
                c.Dispatcher.Invoke(delegate() { tbStatus.Text += "Выбрана запись для: " + dt.Rows[i][1].ToString().Trim() + " " + dt.Rows[i][2].ToString().Trim() + " " + dt.Rows[i][3].ToString().Trim() + "\r\n"; });
                prBar.Dispatcher.Invoke(() => { ((ProgressBar)prBar).Value +=1; });
                MainWindow.lblStat.Dispatcher.Invoke(() => { MainWindow.lblStat.Content = dt.Rows[i][1].ToString().Trim() + " " + dt.Rows[i][2].ToString().Trim() + " " + dt.Rows[i][3].ToString().Trim(); });
            }
            
                c.Dispatcher.Invoke(delegate() { ((TextBox)c).Text += "Выбираем статьи...\r\n"; });
                prBar.Dispatcher.Invoke(() => { ((ProgressBar)prBar).Value = 0; });

            for (int i = 0; i < resultList.Count; i++) // Выбираем статьи, добавляем их в forOutput и каждому из объектов Zk в resultList
            {
                DBFunctions.Combine_stat(resultList[i], conn);
                c.Dispatcher.Invoke(delegate() { tbStatus.Text += "Выбрана статья для: " + dt.Rows[i][1].ToString().Trim() + " " + dt.Rows[i][2].ToString().Trim() + " " + dt.Rows[i][3].ToString().Trim() + "\r\n"; });
                prBar.Dispatcher.Invoke(() => { ((ProgressBar)prBar).Value += 1; });
                MainWindow.lblStat.Dispatcher.Invoke(() => { MainWindow.lblStat.Content = dt.Rows[i][1].ToString().Trim() + " " + dt.Rows[i][2].ToString().Trim() + " " + dt.Rows[i][3].ToString().Trim(); });
            }
            //Проходим по массиву delegateArray (там лежат делегаты для чекнутых галок) и забираем информацию
            foreach (var item in Class2.delegateArray) 
            {
                switch (item.Key)
                {
                    case "Combine_srok":
                        MainWindow.infoTb.Dispatcher.Invoke(()=>{MainWindow.infoTb.Text += "Выбираем информацию по срокам... \r\n";});
                        headerRow.Add(new Dictionary<string, string>() { { "Начало срока", "m/d/yyyy" } });
                        headerRow.Add(new Dictionary<string, string>() { { "Конец срока", "m/d/yyyy" } });
                        headerRow.Add(new Dictionary<string, string>() { { "Срок", "General" } });
                        headerRow.Add(new Dictionary<string, string>() { { "Дата УДО", "m/d/yyyy" } });
                        headerRow.Add(new Dictionary<string, string>() { { "Дата КП", "m/d/yyyy" } });
                        break;
                    case "Combine_obraz":
                        MainWindow.infoTb.Dispatcher.Invoke(()=>{MainWindow.infoTb.Text += "Выбираем информацию по образованию... \r\n";});
                        headerRow.Add(new Dictionary<string, string>() { { "Учебное заведение", "General" } });
                        headerRow.Add(new Dictionary<string, string>() { { "Год окончания", "General" } });
                        headerRow.Add(new Dictionary<string, string>() { { "Профессия", "General" } });  
                        break;
                    case "Combine_chasti":
                        MainWindow.infoTb.Dispatcher.Invoke(()=>{MainWindow.infoTb.Text += "Выбираем информацию по частям срока... \r\n";});
                        headerRow.Add(new Dictionary<string, string>() { { "Часть срока до УДО", "# ?/?" } });
                        headerRow.Add(new Dictionary<string, string>() { { "Часть срока до КП", "# ?/?" } });
                        
                        break;
                    case "Combine_grazhd":
                        MainWindow.infoTb.Dispatcher.Invoke(()=>{MainWindow.infoTb.Text += "Выбираем информацию по гражданству... \r\n";});
                        headerRow.Add(new Dictionary<string, string>() { { "Национальность", "General" } });
                        headerRow.Add(new Dictionary<string, string>() { { "Гражданство", "General" } });
                        headerRow.Add(new Dictionary<string, string>() { { "Зарегистрирован (страна)", "General" } });
                        headerRow.Add(new Dictionary<string, string>() { { "Зарегистрирован (край/область)", "General" } });
                        headerRow.Add(new Dictionary<string, string>() { { "Зарегистрирован (город/район)", "General" } });
                        headerRow.Add(new Dictionary<string, string>() { { "Зарегистрирован (адрес)", "General" } });
                        break;
                    case "Combine_narush":
                        MainWindow.infoTb.Dispatcher.Invoke(() => { MainWindow.infoTb.Text += "Выбираем информацию по нарушениям... \r\n"; });
                        headerRow.Add(new Dictionary<string, string>() { { "Количество нарушений", "General" } });
                        headerRow.Add(new Dictionary<string, string>() { { "Последнее нарушение", "General" } });
                        headerRow.Add(new Dictionary<string, string>() { { "Количество поощрений", "# ?/?" } });
                        headerRow.Add(new Dictionary<string, string>() { { "Последнее поощрение", "# ?/?" } });
                        break;
                    default:
                        break;
                }
                 MainWindow.progressBar.Dispatcher.Invoke(() => MainWindow.progressBar.Value = 0);
                for (int j = 0; j < resultList.Count; j++) 
                {
                   item.Value(resultList[j], conn);                
                }
            }
            MainWindow.lblStat.Dispatcher.Invoke(() => { MainWindow.lblStat.Content = "Кончил!"; });
         
            btn_ExcelLoad.Dispatcher.Invoke( () => btn_ExcelLoad.IsEnabled = true);
            
                c.Dispatcher.Invoke(delegate() { ((TextBox)c).Text += "Готово!\r\n"; });
                btn_start.Dispatcher.Invoke(() => { btn_start.IsEnabled = true; });
                btn_ExcelLoad.Dispatcher.Invoke(() => { btn_ExcelLoad.IsEnabled = true; });
                Thread.CurrentThread.Abort();
            }
        }
    
}
