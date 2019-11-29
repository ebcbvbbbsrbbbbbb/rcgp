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
using System.Windows.Shapes;
using System.Data.SqlClient;
using System.Data;
using System.Globalization;
using System.ComponentModel;
using System.Runtime.CompilerServices;
using System.Collections.ObjectModel;
using System.Windows.Controls.Primitives;

namespace kassa
{
    /// <summary>
    /// Логика взаимодействия для Settings.xaml
    /// </summary>
    public partial class Settings : Window
    {
        public Settings()
        {
            InitializeComponent();
        }

        private void BtnTestConnection_Click(object sender, RoutedEventArgs e)
        {
           string connStr =  Model.Utility.makeConnectionString(tbServerAdress.Text, tbDbname.Text, tbLogin.Text, tbPassword.Password, 100);
            Model.Utility.connectToDatabase(connStr);
            if (Model.GlobalParameters.sqlConn == null || Model.GlobalParameters.sqlConn.State == ConnectionState.Closed)
            {
                MessageBox.Show("Не удается подключиться к серверу\r\nПроверьте настройки подключения");
            }
            else
            {
                MessageBox.Show("Соединение установлено\r\nНе забудьте сохранить настройки");

            }
        }

        private void BtnSaveSettings_Click(object sender, RoutedEventArgs e)
        {
            Model.GlobalParameters.Host = tbServerAdress.Text;
            Model.GlobalParameters.DBname = tbDbname.Text;
            Model.GlobalParameters.Username = tbLogin.Text;
            Model.GlobalParameters.Password = tbPassword.Password;
            Model.GlobalParameters.connectionString = Model.Utility.makeConnectionString(tbServerAdress.Text, tbDbname.Text, tbLogin.Text, tbPassword.Password, 100);
            Model.GlobalParameters.sqlConn = null;
            GetWindow(this).Close();
        }
    }
}
