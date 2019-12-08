using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
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
using System.Data;
using Microsoft.Win32;
using System.IO;

namespace WpfApp1
{
    /// <summary>
    /// Логика взаимодействия для MainWindow.xaml
    /// </summary>
    public partial class MainWindow : Window
    {
        public double total;
        public string minDate;
        public string maxDate;
        public int totalRecords; //Количество записей
        public string rNumber;
        string servNumber; //Номер услуги
        public string penya;
        public string uderzh;
        public double kperechisl;
        public string kodAgenta;
        public string rDate; // Дата формирования реестра
        public DataTable dt;

        public MainWindow()
        {
            InitializeComponent();
            dt = new DataTable();

        }

        private void Button_Click(object sender, RoutedEventArgs e) //открыть
        {
            btnOpen.IsEnabled = true;
            btnSave.IsEnabled = true;


            OpenFileDialog of = new OpenFileDialog();
            of.Filter = "DBF|*.dbf";
            if (of.ShowDialog() == true)
            {
                FileInfo file = new FileInfo(of.FileName);
                string dirName = file.DirectoryName;
                string fileName = file.Name;
                string conectionString = "Driver={Microsoft dBase Driver (*.dbf)};SourceType=DBF;DefaultDir=" + dirName + ";Exclusive=No;Collate=Machine; NULL=NO;DELETED=NO;BACKGROUNDFETCH=NO";
                OdbcConnection connect = new OdbcConnection(conectionString);
                connect.Open();
                OdbcCommand cmd = new OdbcCommand("Select data,nom, summfy, tippl, cb1,ce1,cb2,ce2,cb3,ce3 from " + fileName, connect);
                dt.Clear();
                try
                {
                    dt.Load(cmd.ExecuteReader());
                }
                catch
                {
                    MessageBox.Show("Что-то пошло не так. \r\nВозможно, в названии файла присутсвуют русские символы, \r\nили длина файла превышает 8 символов.");
                    return;
                }
                if (dt.Select("tippl is null or tippl = 0").ToList().Count > 0)
                {
                    string message = "";
                    List<DataRow> withoutType = dt.Select("tippl is null or tippl = 0").ToList();
                    foreach (DataRow item in withoutType)
                    {
                        message += "платеж номер "+ item["NOM"].ToString()+" на сумму " + item["SUMMFY"].ToString() +"\r\n";
                    }
                    MessageBox.Show("Проставьте тип платежа в итоговом файле для следующих платежей: \r\n" +message);
                    
                }

                total = Math.Round(dt.Select().Select(i => ((double)i["summfy"])).Sum(), 2);
                minDate = (dt.Select().Select(i => ((DateTime)i["data"])).Min()).ToString("dd'/'MM'/'yyyy hh:mm:ss");
                maxDate = (dt.Select().Select(i => ((DateTime)i["data"])).Max()).ToString("dd'/'MM'/'yyyy hh:mm:ss");
                totalRecords = dt.Rows.Count; //Количество записей
                rNumber = DateTime.Now.ToString("yyyyMMddhhmmss"); //Номер реестра
                dGrid.ItemsSource = dt.DefaultView;
                servNumber = "6554389"; //Номер услуги
                penya = "0.00";
                uderzh = "0.00";
                kperechisl = total;
                kodAgenta = "0";
                rDate = DateTime.Now.ToString("dd'/'MM'/'yyyy hh:mm:ss");
                prBar.Maximum = totalRecords;
                btnSave.IsEnabled = true;




            }
            else return;
        }

        private void Button_Click_1(object sender, RoutedEventArgs e)
        {

            SaveFileDialog sf = new SaveFileDialog();
            sf.Filter = "*.txt|.txt";
            sf.RestoreDirectory = true;
            sf.FileName = DateTime.Now.ToString("yyyyMMddhhmmss") + "_почта";
            if (sf.ShowDialog() == true)
            {
                string filePath = sf.FileName;
                FileStream fs = new FileStream(filePath, FileMode.Create, FileAccess.Write);
                StreamWriter sw = new StreamWriter(fs, System.Text.Encoding.Default);
                sw.Write("# {0}\r\n", rNumber);
                sw.Write("# {0}\r\n", total.ToString());
                sw.Write("# {0}\r\n", penya);
                sw.Write("# {0}\r\n", uderzh);
                sw.Write("# {0}\r\n", kperechisl.ToString());
                sw.Write("# {0}\r\n", totalRecords.ToString());
                sw.Write("# {0}\r\n", kodAgenta);
                sw.Write("# {0}\r\n", servNumber);
                sw.Write("# {0}\r\n", rDate);
                sw.Write("# {0}\r\n", minDate);
                sw.Write("# {0}\r\n", maxDate);
                sw.Write("# \r\n");
                foreach (DataRow item in dt.Rows)
                {

                    string cb1 = item["cb1"] is DBNull ? "" : Math.Round((double)item["cb1"], 2).ToString();
                    string ce1 = item["ce1"] is DBNull ? "" : Math.Round((double)item["ce1"], 2).ToString();
                    string cb2 = item["cb2"] is DBNull ? "" : Math.Round((double)item["cb2"], 2).ToString();
                    string ce2 = item["ce2"] is DBNull ? "" : Math.Round((double)item["ce2"], 2).ToString();
                    string cb3 = item["cb3"] is DBNull ? "" : Math.Round((double)item["cb3"], 2).ToString();
                    string ce3 = item["ce3"] is DBNull ? "" : Math.Round((double)item["ce3"], 2).ToString();



                    sw.Write("{0};{1}:{2}:{3}:{4}:{5}:{6}:{7}:{8}::::::::;{9};{10}\r\n",
                        Math.Round((double)item["summfy"], 2).ToString(),
                        item["nom"].ToString(),
                        item["tippl"].ToString(),
                        cb1,
                        ce1,
                        cb2,
                        ce2,
                        cb3,
                        ce3,
                        "123456789",
                        ((DateTime)item["data"]).ToString("dd'/'MM'/'yyyy")
                        );
                    prBar.Value += 1;
                }

                sw.Close();
                MessageBox.Show("Файл " + sf.FileName + " сохранен.");
                prBar.Value = 0;


            }
        }
    }
}
