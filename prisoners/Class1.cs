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
    class Zk
    {
        public string id = "";
        public string fam = "";
        public string name = "";
        public string lastname = "";
        public string otr = "";
        public string st = "";
        public string vnachsroka = "";
        public string vkonecsrok = "";
        public string vdataudo = "";
        public string vdataposel = "";
        public string vsrok = "";
        public string chastUDO = "";
        public string chastKP = "";
        public string nameou = "";
        public string god = "";
        public string prof = "";
        public string vdatar = "";
        public string vnation = "";
        public string grazhd = "";
        public string strana = "";
        public string obl = "";
        public string gorod = "";
        public string adres = "";
        public string lastPooshr = "";
        public string lastNarush = "";
        public int totalNarush = 0;
        public int totalPooshr = 0;
        public List<string> forOutput = new List<string>();      

        public Zk(string itemperson, string fam, string name, string lastname, string vdatar, string otr) 
        {
            this.id = itemperson;
            this.fam = fam;
            this.name = name;
            this.lastname = lastname;
            this.otr = otr;
            this.vdatar = vdatar;
        }               
    }
 }
