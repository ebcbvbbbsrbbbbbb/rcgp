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
using System.Data;
using System.Data.SqlClient;
using Microsoft.Win32;
using System.IO;
using System.Threading;

namespace kassa
{

    public partial class MainWindow : Window
    {
        decimal Sum = 0;
        Dictionary<string, string> uploadedPacks; // Пачки, которые уже были выгружены, для проверки на повторную выгрузку
        public MainWindow()
        {
            
            InitializeComponent();
            DataContext = new ViewModel(MainGrid, ExportGrid, cmbInterval, calendPanel);
            cmbInterval.SelectionChanged += cmbOnselectionChanged;
            dpDateFrom.SelectedDate = DateTime.Now; 
            dpDateTo.SelectedDate = DateTime.Now;
            uploadedPacks = new Dictionary<string, string>(); // Словарь для хранения идентификаторов пачек, которые уже выгружались ранее, с датой выгрузки
            Model.WindowElements.progressBar = prBar;
            Model.WindowElements.btnExport = btnExport;

            Model.GlobalParameters.connectionString = Model.Utility.makeConnectionString(Model.GlobalParameters.Host, Model.GlobalParameters.DBname, Model.GlobalParameters.Username, Model.GlobalParameters.Password, 100);
            Model.Utility.connectToDatabase(Model.GlobalParameters.connectionString);
            if (Model.GlobalParameters.sqlConn == null || Model.GlobalParameters.sqlConn.State == ConnectionState.Closed)
            {
                MessageBox.Show("Не удается подключиться к серверу\r\nПроверьте настройки подключения");
                indicator.Fill = Brushes.Red;
                indicator.ToolTip = "Нет соединения с БД";
                btnExport.IsEnabled = false;
                btnShowRecord.IsEnabled = false;
                btnReconnect.Visibility = Visibility.Visible;
            }
            else
            {
                try
                {
                    SqlCommand cmd = new SqlCommand();
                    cmd.CommandType = CommandType.StoredProcedure;
                    cmd.CommandText = "kassaGetDataFirstWithInn";
                    cmd.Connection = Model.GlobalParameters.sqlConn;
                    cmd.ExecuteNonQuery();
                }
                catch (Exception f)
                {
                    MessageBox.Show(f.Message.ToString());
                    this.Close();
                }
                indicator.Fill = Brushes.Green;
                indicator.ToolTip = " Подключено к " + Model.GlobalParameters.Host+"\r\n БД: "+ Model.GlobalParameters.DBname+"\r\n Пользователь: "+ Model.GlobalParameters.Username;
                btnExport.IsEnabled = true;
                btnShowRecord.IsEnabled = true;
                btnReconnect.Visibility = Visibility.Collapsed;
            }



        }



        private void cmbOnselectionChanged(object sender, SelectionChangedEventArgs e) // Переключение комбобокса
        {
            if (((ComboBoxItem)(((ComboBox)sender).SelectedItem)).Tag.ToString() == "1") 
            {
                // Устанавливаем значение начала периода в DatePicker как первый день текущего месяца
                calendPanel.Visibility = System.Windows.Visibility.Visible;
                ((DatePicker)((DockPanel)Model.WindowElements.calendPanel.Children[0]).Children[1]).Text =  (new DateTime(DateTime.Now.Year, DateTime.Now.Month, 1)).ToString(); 
            }
            else
            {
                calendPanel.Visibility = System.Windows.Visibility.Collapsed;              
            }
        }

        private void Button_Click(object sender, RoutedEventArgs e) // Кнопка "Добавить к выгрузке"
        {
            Model.DataGridUtilities.FillExportList(Model.GlobalParameters.worklistDataset);
        }

        private void Row_DoubleClick(object sender, RoutedEventArgs e) // Создание окна Payments
        {
            Window w = new Payments(sender, uploadedPacks);

            w.Show();
           
        }

        private void Button_Click_1(object sender, RoutedEventArgs e) // Кнопка "Выделить все"
        {
          string tableSelected =  tabItemW.IsSelected ? "Worklist" : "ExportList"; // Проверяем, какая вкладка является активной

            if (Model.GlobalParameters.selectAllFlag == false)
            {

                for (int i = 0; i < Model.GlobalParameters.worklistDataset.Tables[tableSelected].Rows.Count; i++)
                {
                    DataRow dr = Model.GlobalParameters.worklistDataset.Tables[tableSelected].Rows[i];
                    dr["isChecked"] = true;

                }
                Model.GlobalParameters.selectAllFlag = true;
            }
            else
            {
                for (int i = 0; i < Model.GlobalParameters.worklistDataset.Tables[tableSelected].Rows.Count; i++)
                {
                    DataRow dr = Model.GlobalParameters.worklistDataset.Tables[tableSelected].Rows[i];
                    dr["isChecked"] = false;

                }
                Model.GlobalParameters.selectAllFlag = false;
            }
                

 
        }

        private void Button_Click_2(object sender, RoutedEventArgs e) // Кнопка "Обратить выделение"
        {
            string tableSelected = tabItemW.IsSelected ? "Worklist" : "ExportList";
            for (int i = 0; i < Model.GlobalParameters.worklistDataset.Tables[tableSelected].Rows.Count; i++)
            {
                DataRow dr = Model.GlobalParameters.worklistDataset.Tables[tableSelected].Rows[i];

                if ((bool)dr["isChecked"] == true)
                {
                    dr["isChecked"] = false;
                }
                else dr["isChecked"] = true;


            }
        }

        private void Button_Click_3(object sender, RoutedEventArgs e) // Кнопка "Выгрузить выделенные"
        {

            Thread t = new Thread(Model.DataGridUtilities.ExportData);
            t.Start();
           

        }

        private void BtnShowRecord_Click(object sender, RoutedEventArgs e)
        {
            try
            {
                Sum = 0;
                Model.GlobalParameters.worklistDataset.Tables["WorkList"].Clear();
                Model.DataGridUtilities.FillWorkList(Model.WindowElements.cmbRecordType);

                foreach (DataRow dr in Model.GlobalParameters.worklistDataset.Tables["WorkList"].Rows)
                {
                    Sum += (decimal)dr["pack_total"];
                }
                packsQuantity.Text = Model.GlobalParameters.worklistDataset.Tables["WorkList"].Rows.Count == 0 ? "0" : Model.GlobalParameters.worklistDataset.Tables["WorkList"].Rows.Count.ToString();
                packsSum.Text = Sum.ToString("f2");
                packsNegative.Text = Model.GlobalParameters.worklistDataset.Tables["WorkList"].Select("isCorrect=1").Count().ToString();
            }
            catch
            {
                MessageBox.Show("Не удается подключиться к серверу\r\nПроверьте настройки подключения");
                indicator.Fill = Brushes.Red;
                indicator.ToolTip = "Нет соединения с БД";
                btnExport.IsEnabled = false;
                btnShowRecord.IsEnabled = false;
                btnReconnect.Visibility = Visibility.Visible;
            }

        } // Кнопка "Показать"

        private void Button_Click_4(object sender, RoutedEventArgs e) // Кнопка "Очистить список"
        {
            
                string tableSelected = tabItemW.IsSelected ? "Worklist" : "ExportList";
                 Model.GlobalParameters.worklistDataset.Tables[tableSelected].Clear();

                
        }

        private void Window_Loaded(object sender, RoutedEventArgs e) // Скрипт на сервере, чистящий временные таблицы и собирающий в них инфу
        {

        }

        private void Button_Click_5(object sender, RoutedEventArgs e) // Настройки
        {
            Window settings = new Settings();
            settings.Show();

        }

        private void BtnReconnect_Click(object sender, RoutedEventArgs e) // Кнопка "Переподключиться"
        {
           string connStr =  Model.Utility.makeConnectionString(Model.GlobalParameters.Host, Model.GlobalParameters.DBname, Model.GlobalParameters.Username, Model.GlobalParameters.Password, 10000);
            Model.Utility.connectToDatabase(connStr);
            if (Model.GlobalParameters.sqlConn == null || Model.GlobalParameters.sqlConn.State == ConnectionState.Closed)
            {
                MessageBox.Show("Не удается подключиться к серверу\r\nПроверьте настройки подключения");
                indicator.Fill = Brushes.Red;
                indicator.ToolTip = "Нет соединения с БД";
                btnExport.IsEnabled = false;
                btnShowRecord.IsEnabled = false;
                btnReconnect.Visibility = Visibility.Visible;
            }
            else
            {
                try
                {
                    SqlCommand cmd = new SqlCommand();
                    cmd.CommandType = CommandType.StoredProcedure;
                    cmd.CommandText = "kassaGetDataFirstWithInn";
                    cmd.Connection = Model.GlobalParameters.sqlConn;
                    cmd.ExecuteNonQuery();
                }
                catch (Exception f)
                {
                    MessageBox.Show(f.Message.ToString());
                    this.Close();
                }
                indicator.Fill = Brushes.Green;
                indicator.ToolTip = " Подключено к " + Model.GlobalParameters.Host + "\r\n БД: " + Model.GlobalParameters.DBname + "\r\n Пользователь: " + Model.GlobalParameters.Username;
                btnExport.IsEnabled = true;
                btnShowRecord.IsEnabled = true;
                btnReconnect.Visibility = Visibility.Collapsed;
            }

        }
    }
}
