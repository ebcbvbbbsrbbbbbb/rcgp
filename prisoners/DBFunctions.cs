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
    class DBFunctions
    {

       public static void Combine_stat(Zk zk, OdbcConnection conn) 
        {
            DataTable stData = new DataTable();
            string tempSt;
            int i = 0; //счетчик при разбиении строки со статьями
         
            string stat = "";
            string st;
            //---------------------------------- Забираем список статей ---------------------------------
            OdbcCommand cmd = conn.CreateCommand();
            cmd.CommandText = "SELECT card.vosustatia FROM card WHERE card.itemperson = ?";
            OdbcParameter st_param = new OdbcParameter("@id_p", OdbcType.VarChar);
            st_param.Value = zk.id.ToString();
            cmd.Parameters.Add(st_param);
            stData.Load(cmd.ExecuteReader());
            tempSt = stData.Rows[0][0].ToString().Trim();
            st = "";
            if (tempSt.Length / 2 > 1)
            {
                while (i < (tempSt.Length / 2) - 1)
                {

                    stat = tempSt.Substring(2 * i, 2);
                    OdbcCommand stcmd = conn.CreateCommand();
                    stcmd.CommandText = "SELECT pc8.name FROM pc8 WHERE pc8.item = '" + stat + "'";
                    DataTable stData2 = new DataTable();
                    stData2.Load(stcmd.ExecuteReader());
                    st += stData2.Rows[0][0].ToString().Trim();
                    st += ", ";
                    i++;
                }
            }
            
            stat = tempSt.Substring(tempSt.Length-2, 2);
            OdbcCommand stcmd2 = conn.CreateCommand();
            stcmd2.CommandText = "SELECT pc8.name FROM pc8 WHERE pc8.item = '" + stat + "'";
            DataTable stData3 = new DataTable();
            stData3.Load(stcmd2.ExecuteReader());
            st += stData3.Rows[0][0].ToString().Trim();
            st += ".";
            i++;
            zk.st = st;
            zk.forOutput.Add(st);
           

      }
            //--------------------------------------------------------------------------------------------
       public static void Combine_obraz(object o, OdbcConnection conn) 
        {
                //---------------------------------- Инфа по образованию -------------------------------------
            MainWindow.progressBar.Dispatcher.Invoke(() => MainWindow.progressBar.Value += 1);
           Zk zk = (Zk)o; 
           int i2 = 0;;
            string pr = "";
            string nameou = "";
            string god = "";
            string prof = "";
            OdbcCommand cmd = new OdbcCommand();
            cmd = conn.CreateCommand();
            cmd.CommandText = "SELECT obrazov.nameou, obrazov.god, obrazov.prof FROM obrazov WHERE obrazov.itemperson=?";
            OdbcParameter par_id = new OdbcParameter();
            par_id.Value = zk.id;
            cmd.Parameters.Add(par_id);
            DataTable obrazData = new DataTable();
            obrazData.Load(cmd.ExecuteReader());
            MainWindow.lblStat.Dispatcher.Invoke(() => { MainWindow.lblStat.Content = zk.fam.Trim() + " " + zk.name.Trim() + " " + zk.lastname.Trim(); });

            if (obrazData.Rows.Count > 1) 
            {
                for (var ir = 0; ir < obrazData.Rows.Count - 1; ir++)
                {
                    nameou += obrazData.Rows[ir][0].ToString().Trim() + "\r\n";
                    god += obrazData.Rows[ir][1].ToString().Trim() + "\r\n";
                    i2 = 0;
                    while (i2 < (obrazData.Rows[ir][2].ToString().Trim().Length) / 2)
                    {
                        pr = obrazData.Rows[ir][2].ToString().Substring(2 * i2, 2);
                        OdbcCommand cmd_prof = conn.CreateCommand();
                        cmd_prof.CommandText = "select pc7.name from pc7 where pc7.item = ?";
                        OdbcParameter pr_param = new OdbcParameter("pr_param", OdbcType.VarChar);
                        pr_param.Value = pr.Trim();
                        cmd_prof.Parameters.Add(pr_param);
                        DataTable profDt = new DataTable();
                        profDt.Load(cmd_prof.ExecuteReader());
                        prof += profDt.Rows[0][0].ToString().Trim() + ";";
                        i2++;

                    }
                    prof += "\r\n";
                }
                    nameou += obrazData.Rows[obrazData.Rows.Count-1][0].ToString().Trim();
                    god += obrazData.Rows[obrazData.Rows.Count-1][1].ToString().Trim();
                    i2 = 0;
                    while (i2 < (obrazData.Rows[obrazData.Rows.Count - 1][2].ToString().Trim().Length) / 2)
                    {
                        pr = obrazData.Rows[obrazData.Rows.Count - 1][2].ToString().Substring(2 * i2, 2);
                        OdbcCommand cmd_prof = conn.CreateCommand();
                        cmd_prof.CommandText = "select pc7.name from pc7 where pc7.item = ?";
                        OdbcParameter pr_param = new OdbcParameter("pr_param", OdbcType.VarChar);
                        pr_param.Value = pr.Trim();
                        cmd_prof.Parameters.Add(pr_param);
                        DataTable profDt = new DataTable();
                        profDt.Load(cmd_prof.ExecuteReader());
                        prof += profDt.Rows[0][0].ToString().Trim() + ";";
                        i2++;

                    }
                
                zk.nameou = nameou;
                zk.god = god;
                zk.prof = prof;
                zk.forOutput.Add(nameou);
                zk.forOutput.Add(god);
                zk.forOutput.Add(prof);
            
            }
            else if (obrazData.Rows.Count == 1) 
                {
                    nameou = obrazData.Rows[0][0].ToString().Trim();
                    god = obrazData.Rows[0][1].ToString().Trim();
                    while (i2 < (obrazData.Rows[0][2].ToString().Trim().Length) / 2)
                    {
                        pr = obrazData.Rows[0][2].ToString().Substring(2 * i2, 2);
                        OdbcCommand cmd_prof = conn.CreateCommand();
                        cmd_prof.CommandText = "select pc7.name from pc7 where pc7.item = ?";
                        OdbcParameter pr_param = new OdbcParameter("pr_param", OdbcType.VarChar);
                        pr_param.Value = pr.Trim();
                        cmd_prof.Parameters.Add(pr_param);
                        DataTable profDt = new DataTable();
                        profDt.Load(cmd_prof.ExecuteReader());
                        prof += profDt.Rows[0][0].ToString().Trim() + ";";
                        i2++;

                    }
                    zk.nameou = nameou;
                    zk.god = god;
                    zk.prof = prof;
                    zk.forOutput.Add(nameou);
                    zk.forOutput.Add(god);
                    zk.forOutput.Add(prof);
                }
            else 
            {
                zk.nameou = "";
                zk.god = "";
                zk.prof = "";
                zk.forOutput.Add(nameou);
                zk.forOutput.Add(god);
                zk.forOutput.Add(prof);
            }



             
        }
        //-----------------------------------Инфа по сроку (начало, конец, УДО, КП, срок)-----------------------------------------------
        public static void Combine_srok(object o, OdbcConnection conn)
        {
           
            Zk zk = (Zk)o;
            OdbcCommand cmd = new OdbcCommand();
            cmd = conn.CreateCommand();
            cmd.CommandText = "SELECT card.vnachsroka, card.vkonecsrok, card.vsroklet, card.vsrokmes, vsrokdney, card.vdataudo, card.vdataposel FROM card WHERE card.itemperson = ? ";
            OdbcParameter par_id = new OdbcParameter();
            par_id.Value = zk.id;
            cmd.Parameters.Add(par_id);
            DataTable srok = new DataTable();
            srok.Load(cmd.ExecuteReader());
            MainWindow.lblStat.Dispatcher.Invoke(() => { MainWindow.lblStat.Content = zk.fam.Trim() + " " + zk.name.Trim() + " " + zk.lastname.Trim(); });

            MainWindow.progressBar.Dispatcher.Invoke(() => MainWindow.progressBar.Value += 1);
            for (int i = 0; i < srok.Rows.Count; i++) 
            {
               
                zk.vnachsroka = srok.Rows[i][0].ToString().Trim();
                zk.vkonecsrok = srok.Rows[i][1].ToString().Trim();

                if (((Int32.Parse(srok.Rows[i][2].ToString().Trim()) >= 1) && (Int32.Parse(srok.Rows[i][2].ToString().Trim()) <= 4)) || ((Int32.Parse(srok.Rows[i][2].ToString().Trim()) > 20) && (Int32.Parse(srok.Rows[i][2].ToString().Trim()) <= 24)))
                {
                    zk.vsrok = srok.Rows[i][2].ToString().Trim() == "0" ? "" : srok.Rows[i][2].ToString().Trim() + " г. ";
                    zk.vsrok += srok.Rows[i][3].ToString().Trim() == "0" ? "" : srok.Rows[i][3].ToString().Trim() + " м. ";
                    zk.vsrok += srok.Rows[i][4].ToString().Trim() == "0" ? "" : srok.Rows[i][4].ToString().Trim() + " д. ";

                }
                else
                {
                    zk.vsrok = srok.Rows[i][2].ToString().Trim() == "0" ? "" : srok.Rows[i][2].ToString().Trim() + " л. ";
                    zk.vsrok += srok.Rows[i][3].ToString().Trim() == "0" ? "" : srok.Rows[i][3].ToString().Trim() + " м. ";
                    zk.vsrok += srok.Rows[i][4].ToString().Trim() == "0" ? "" : srok.Rows[i][4].ToString().Trim() + " д. ";
                }

                zk.vnachsroka = srok.Rows[i][0].ToString().Trim();
                zk.vdataudo = srok.Rows[i][5].ToString().Trim();
                zk.vdataposel = srok.Rows[i][6].ToString().Trim();
            }
            zk.forOutput.Add(zk.vnachsroka);
            zk.forOutput.Add(zk.vkonecsrok);
            zk.forOutput.Add(zk.vsrok);
            zk.forOutput.Add(zk.vdataudo);
            zk.forOutput.Add(zk.vdataposel);
        }

        //-------------------------------------------------------------------------------------------------------------------------------
        public static void Combine_chasti(object o, OdbcConnection conn)
        {
            
            Zk zk = (Zk)o;
            int chastUDO;
            int chastKP;
            OdbcCommand cmd = new OdbcCommand();
            cmd = conn.CreateCommand();
            cmd.CommandText = "SELECT card.vsrokudo, card.vsrokposel FROM card WHERE card.itemperson=?"; //SELECT pc6.name, pc1.name, pc1.name, pc2.name, pc3.name, card.vmestopadr FROM card LEFT OUTER JOIN pc6 ON card.vnation = pc6.item LEFT OUTER JOIN pc1 ON card.vgrajdanst = pc1.item LEFT OUTER JOIN pc1 ON card.vmestopgos = pc1.item LEFT OUTER JOIN pc2 ON card.vmestopobl = pc2.item LEFT OUTER JOIN pc3 ON card.vmestopgor = pc3.item WHERE card.itemperson=?
            OdbcParameter par_id = new OdbcParameter();
            par_id.Value = zk.id;
            cmd.Parameters.Add(par_id);
            DataTable chastiData = new DataTable();
            chastiData.Load(cmd.ExecuteReader());
            chastUDO = Int32.Parse(chastiData.Rows[0][0].ToString().Trim());
            switch (chastUDO) 
            {
                case 1:
                    zk.chastUDO = "1/3";
                    break;
                case 2:
                    zk.chastUDO = "1/2";
                    break;
                case 3:
                    zk.chastUDO = "2/3";
                    break;
                case 4:
                    zk.chastUDO = "3/4";
                    break;
                case 5:
                    zk.chastUDO = "4/5";
                    break;
            
            }
            chastKP = Int32.Parse(chastiData.Rows[0][1].ToString().Trim());
            switch (chastKP)
            {
                case 1:
                    zk.chastKP = "1/4";
                    break;
                case 2:
                    zk.chastKP = "1/3";
                    break;
                case 3:
                    zk.chastKP = "1/2";
                    break;
                case 4:
                    zk.chastKP = "2/3";
                    break;
                case 5:
                    zk.chastKP = "3/4";
                    break;
                case 6:
                    zk.chastKP = "4/5";
                    break;

            }
            zk.forOutput.Add(zk.chastUDO);
            zk.forOutput.Add(zk.chastKP);
            MainWindow.progressBar.Dispatcher.Invoke(() => MainWindow.progressBar.Value += 1);
            MainWindow.lblStat.Dispatcher.Invoke(() => { MainWindow.lblStat.Content = zk.fam.Trim() + " " + zk.name.Trim() + " " + zk.lastname.Trim(); });
        }

        public static void Combine_grazhd(object o, OdbcConnection conn)
        {
            MainWindow.progressBar.Dispatcher.Invoke(() => MainWindow.progressBar.Value += 1);
            Zk zk = (Zk)o;
            OdbcCommand cmd = new OdbcCommand();
            cmd = conn.CreateCommand();
            cmd.CommandText = "SELECT pc6.name, pc1.name, pc1.name, pc2.name, pc3.name, card.vmestopadr FROM card LEFT OUTER JOIN pc1 ON pc1.item = card.vgrajdanst AND card.vmestopgos = pc1.item LEFT OUTER JOIN pc6 ON pc6.item = card.vnation LEFT OUTER JOIN pc2 ON card.vmestopobl = pc2.item LEFT OUTER JOIN pc3 ON pc3.item =card.vmestopgor WHERE card.itemperson=?"; //SELECT pc6.name, pc1.name, pc1.name, pc2.name, pc3.name, card.vmestopadr FROM card LEFT OUTER JOIN pc6 ON card.vnation = pc6.item LEFT OUTER JOIN pc1 ON card.vgrajdanst = pc1.item LEFT OUTER JOIN pc1 ON card.vmestopgos = pc1.item LEFT OUTER JOIN pc2 ON card.vmestopobl = pc2.item LEFT OUTER JOIN pc3 ON card.vmestopgor = pc3.item WHERE card.itemperson=?
            OdbcParameter par_id = new OdbcParameter();
            par_id.Value = zk.id;
            cmd.Parameters.Add(par_id);
            DataTable grazhdData = new DataTable();
            grazhdData.Load(cmd.ExecuteReader());
            MainWindow.lblStat.Dispatcher.Invoke(() => { MainWindow.lblStat.Content = zk.fam.Trim() + " " + zk.name.Trim() + " " + zk.lastname.Trim(); });
            zk.vnation = grazhdData.Rows[0][0].ToString().Trim();
            zk.grazhd = grazhdData.Rows[0][1].ToString().Trim();
            zk.strana = grazhdData.Rows[0][2].ToString().Trim();
            zk.obl = grazhdData.Rows[0][3].ToString().Trim();
            zk.gorod = grazhdData.Rows[0][4].ToString().Trim();
            zk.adres = grazhdData.Rows[0][5].ToString().Trim();
            zk.forOutput.Add(zk.vnation);
            zk.forOutput.Add(zk.grazhd);
            zk.forOutput.Add(zk.strana);
            zk.forOutput.Add(zk.obl);
            zk.forOutput.Add(zk.gorod);
            zk.forOutput.Add(zk.adres);
        }

        public static void Combine_narush(object o, OdbcConnection conn)
        {
            Zk zk = (Zk)o;
            List<DateTime> narushArray = new List<DateTime>();
            List<DateTime> pooshrArray = new List<DateTime>();
            OdbcCommand cmd = new OdbcCommand();
            cmd = conn.CreateCommand();
            cmd.CommandText = "SET DELETED ON; SELECT itemme, vdata FROM distipl WHERE distipl.itemperson=?"; //SELECT pc6.name, pc1.name, pc1.name, pc2.name, pc3.name, card.vmestopadr FROM card LEFT OUTER JOIN pc6 ON card.vnation = pc6.item LEFT OUTER JOIN pc1 ON card.vgrajdanst = pc1.item LEFT OUTER JOIN pc1 ON card.vmestopgos = pc1.item LEFT OUTER JOIN pc2 ON card.vmestopobl = pc2.item LEFT OUTER JOIN pc3 ON card.vmestopgor = pc3.item WHERE card.itemperson=?
            OdbcParameter par_id = new OdbcParameter();
            par_id.Value = zk.id;
            cmd.Parameters.Add(par_id);
            DataTable narushData = new DataTable();
            narushData.Load(cmd.ExecuteReader());
            if (narushData.Rows.Count > 0)
            {

                for (int i = 0; i < narushData.Rows.Count; i++)
                {
                    if (narushData.Rows[i][1].ToString().Trim() != "")
                    {
                        narushArray.Add(DateTime.Parse(narushData.Rows[i][1].ToString()));
                    }
                    continue;

                }
                narushArray.Sort();
                narushArray.Reverse();
                zk.totalNarush = narushArray.Count;
                zk.lastNarush = narushArray[0].ToShortDateString().ToString();
                zk.forOutput.Add(zk.totalNarush.ToString());
                zk.forOutput.Add(zk.lastNarush);
            }
            else 
            {
                zk.totalNarush = 0;
                zk.lastNarush = "";
                zk.forOutput.Add(zk.totalNarush.ToString());
                zk.forOutput.Add(zk.lastNarush);
            
            }

            cmd = conn.CreateCommand();
            cmd.CommandText = "SET DELETED ON; SELECT itemme, vdataob FROM pooshren WHERE pooshren.itemperson=?"; //SELECT pc6.name, pc1.name, pc1.name, pc2.name, pc3.name, card.vmestopadr FROM card LEFT OUTER JOIN pc6 ON card.vnation = pc6.item LEFT OUTER JOIN pc1 ON card.vgrajdanst = pc1.item LEFT OUTER JOIN pc1 ON card.vmestopgos = pc1.item LEFT OUTER JOIN pc2 ON card.vmestopobl = pc2.item LEFT OUTER JOIN pc3 ON card.vmestopgor = pc3.item WHERE card.itemperson=?
            OdbcParameter par_id2 = new OdbcParameter();
            par_id2.Value = zk.id;
            cmd.Parameters.Add(par_id2);
            DataTable pooshrData = new DataTable();
            pooshrData.Load(cmd.ExecuteReader());

            if (pooshrData.Rows.Count > 0)
            {

                for (int i = 0; i < pooshrData.Rows.Count; i++)
                {
                    if (pooshrData.Rows[i][1].ToString().Trim() != "")
                    {
                        pooshrArray.Add(DateTime.Parse(pooshrData.Rows[i][1].ToString()));
                    }
                    continue;

                }
                pooshrArray.Sort();
                pooshrArray.Reverse();
                zk.totalPooshr = pooshrArray.Count;
                zk.lastPooshr = pooshrArray[0].ToShortDateString().ToString();
                zk.forOutput.Add(zk.totalPooshr.ToString());
                zk.forOutput.Add(zk.lastPooshr);
            }
            else
            {
                zk.totalPooshr = 0;
                zk.lastPooshr = "";
                zk.forOutput.Add(zk.totalPooshr.ToString());
                zk.forOutput.Add(zk.lastPooshr);

            }

            MainWindow.progressBar.Dispatcher.Invoke(() => MainWindow.progressBar.Value += 1);
            MainWindow.lblStat.Dispatcher.Invoke(() => { MainWindow.lblStat.Content = zk.fam.Trim() + " " + zk.name.Trim() + " " + zk.lastname.Trim(); });

            
        }

        public static void LoadToExcel(Dictionary<int, Zk> resultList) 
        {
            MainWindow.infoTb.Dispatcher.Invoke(delegate { MainWindow.infoTb.Text += "Выгружаем в Excel...\r\n"; });
            Excel.Application ExcellApp = new Excel.Application();
            Excel.Workbook workBook;
            Excel.Worksheet workSheet;
            workBook = ExcellApp.Workbooks.Add();
            workSheet = (Excel.Worksheet)workBook.Worksheets.get_Item(1);

           
            Excel.Range cols = ExcellApp.Columns;
            for (int i = 0; i < Class2.headerRow.Count; i++ )
            {

                ((Excel.Range)(cols.Columns[i + 1])).NumberFormat = Class2.headerRow[i].ToList()[0].Value;
                workSheet.Cells[1, i + 1] = Class2.headerRow[i].ToList()[0].Key;
            }
            int rowNum = 0;
            foreach (var item in resultList)
            {
                for (int i = 0; i < item.Value.forOutput.Count; i++ )
                {
                    workSheet.Cells[rowNum + 2, i+1] = item.Value.forOutput[i]; //workSheet.Cells[i + 2, 1] = 
                 
                }
                rowNum++;
                
            }
            Excel.Range headerRow = workSheet.Range[workSheet.Cells[1, 1], workSheet.Cells[1, Class2.headerRow.Count]];
            headerRow.Font.Bold = true;
            headerRow.Font.Name = "Times New Roman";
            headerRow.Font.Size = "10";


            
            cols.AutoFit();
            cols.Font.Name = "Times New Roman";
            cols.Font.Size = "10";
 

            cols[6].ColumnWidth = 60;
            cols[6].WrapText = true;
            
           // cols[6].ColumnWidth = 50;            
          //  cols[6].ShrinkToFit();
            


            ExcellApp.Visible = true;
        }
}

    
}
