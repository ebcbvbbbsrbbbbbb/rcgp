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
using Microsoft.Win32;
using Microsoft.WindowsAPICodePack.Dialogs;





namespace WpfApplication4
{
    /// <summary>
    /// Логика взаимодействия для MainWindow.xaml
    /// </summary>
    public partial class MainWindow : Window
    {

        public static string dbPath = @"\\192.168.2.1\Database";
        public MainWindow()
        {
            InitializeComponent();
            lbl_folderPath.Content = dbPath;
            btn_ExcelLoad.IsEnabled = false;
            infoTb = tbInfo;
            progressBar = prBar;
            lblStat = lblStatus;

        }
        string qualifPath;
        string dataPath;
        public static string tempPath = System.IO.Path.Combine(System.IO.Path.GetTempPath(), "DBGrubber");
        List<string> qualifFiles = new List<string>() { "pc8.DBF", "pc7.CDX", "pc7.DBF", "pc22.CDX", "pc22.DBF", "pc52.CDX", "pc52.DBF", "pc1.DBF", "pc2.DBF", "pc3.DBF", "pc6.DBF" };
        List<string> dataFiles = new List<string>() { "card.dbf", "CARD.FPT", "OBRAZOV.cdx", "OBRAZOV.DBF", "OBRAZOV.FPT", "DISTIPL.dbf","distipl.fpt","pooshren.fpt", "POOSHREN.dbf" };
        public static TextBox infoTb;
        public static ProgressBar progressBar;
        public static Label lblStat;
        private static List<string> checkedOtr = new List<string>();

 
            
        

        private void btn_connect_Click(object sender, RoutedEventArgs e)
        {

            Class2.queryStringAdd = "";
            btn_ExcelLoad.IsEnabled = false;
            Class2.delegateArray.Clear();
            Class2.resultList.Clear();
            Class2.headerRow.Clear();
            checkedOtr.Clear();
            tbStatus.Text = "";
            tbInfo.Text = "";
            Class2 cl2 = new Class2(tbInfo, tbStatus, prBar, tempPath, btn_connect, btn_ExcelLoad);


            //-------------------------Проверяем чекнутые галки и чистим массив с делегатами --------------------------------------
            foreach (var item in cbContainer.Children) 
            {
                if ((((CheckBox)item).IsChecked) == false) { Class2.delegateArray.Remove(((CheckBox)item).Name); }
            
            }

            //-------------------------Собираем строку запроса по отрядам --------------------------------------
            foreach (var item in lbOtr.Items) 
            {
                if (((CheckBox)item).IsChecked == true) 
                {
                    checkedOtr.Add(((CheckBox)item).Tag.ToString());
                }            
            }
            if (checkedOtr.Count != 0) 
            {
                if (!checkedOtr.Contains("!!"))
                {
                    if (checkedOtr.Count > 1) 
                    {
                        Class2.queryStringAdd += " AND ( ";
                        for (int i = 0; i < checkedOtr.Count - 1; i++) 
                        {
                            Class2.queryStringAdd += "card.vnomotr = '" + checkedOtr[i] +"'";
                            Class2.queryStringAdd += " OR ";
                        }
                        Class2.queryStringAdd += "card.vnomotr = '" + checkedOtr[checkedOtr.Count - 1] + "')";
                
                    }
                    else Class2.queryStringAdd += " AND card.vnomotr = '" + checkedOtr[0] +"'";
                }
                else Class2.queryStringAdd = "";
            
            }
            else Class2.queryStringAdd = "";
            //--------------------------------------------------------------------------------------------------------------------
            
            Thread t = new Thread(cl2.collectInfo);

            //------------------------- Вытаскиваем нужные нам таблицы и копируем их в tempPath-----------------------------------
             bool itsOK = true;
            qualifPath = System.IO.Path.Combine(dbPath, "Qualif");
            dataPath = System.IO.Path.Combine(dbPath, "Data");
            if (!Directory.Exists(tempPath)) { Directory.CreateDirectory(tempPath);}
             foreach (var item in qualifFiles)
             {
                 if (!File.Exists(System.IO.Path.Combine(qualifPath, item)))
                 {
                     MessageBox.Show("Не найден файл " + item + ". Проверьте правильность пути к Database.");
                     itsOK = false;
                     break;

                 }
                 File.Copy(System.IO.Path.Combine(qualifPath, item), System.IO.Path.Combine(tempPath, item), true);


             }
             if (itsOK) 
             {
                 foreach (var item in dataFiles)
                 {
                     if (!File.Exists(System.IO.Path.Combine(dataPath, item)))
                     {
                         MessageBox.Show("Не найден файл " + item + ". Проверьте правильность пути к Database.");
                         itsOK = false;
                         break;

                     }

                     File.Copy(System.IO.Path.Combine(dataPath, item), System.IO.Path.Combine(tempPath, item), true);
                 }
             }

             if (itsOK)
             { 
                 ((Button)sender).IsEnabled = false;
            t.Start();  // Если все ОК, выполняем CollectInfo() из другого потока, чтобы не подвисал интерфейс
            tbInfo.Text = "Подключение к базе. Ожидайте... \r\n";

             }

       //--------------------------------------------------------------------------------------------------------------------
           
            
        }
             
        
        
      //------------------------------ Выбрать путь к Database ------------------------------  
        
        private void openFolderBtn_Click(object sender, RoutedEventArgs e)
        {
            var dialog = new CommonOpenFileDialog();
            dialog.IsFolderPicker = true;
            dialog.InitialDirectory = @"C:\\";
            if (dialog.ShowDialog() == CommonFileDialogResult.Ok) 
            {
                dbPath = @dialog.FileName;
                lbl_folderPath.Content = dbPath;
            }
        }

       //------------------------------------------------------------------------------------



        //------------------------------ Выгрузить инфу в Excel -----------------------------  
        private void btn_ExcelLoad_Click(object sender, RoutedEventArgs e)
        {
            DBFunctions.LoadToExcel(Class2.resultList);
        }

        private void btnCreateReport_Click(object sender, RoutedEventArgs e)
        {
            Window1 reportWindow = new Window1();
            reportWindow.Show();
        }

        private void suon_1_Click(object sender, RoutedEventArgs e)
        {
            suon_2.IsChecked =  ((CheckBox)sender).IsChecked;
        }

        //------------------------------------------------------------------------------------
    }
}
