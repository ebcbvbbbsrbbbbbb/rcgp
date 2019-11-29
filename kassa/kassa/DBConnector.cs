using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using System.Data.SqlClient;
using System.Windows.Controls;
using System.Windows.Media;

namespace kassa
{
    public static class DBConnector
    {
        static string dataSource;
        static string initialCatalog;
        static string userName;
        static string password;
        static string connTimeout;
        //Data Source=PSKOVSQL;Initial Catalog=it_gh;User ID=sa;Password=***********;Connect Timeout=999
        static string connString = "Data Source=" + dataSource + ";Initial Catalog=" + initialCatalog + "; User ID=" + userName + "Password=" + password;
        public static void createConnection(string dataSource, string initialCatalog, string userName, string password, string connTimeout, Label lb)
        {
            DBConnector.dataSource = dataSource;
            DBConnector.initialCatalog = initialCatalog;
            DBConnector.userName = userName;
            DBConnector.password = password;
            DBConnector.connTimeout = connTimeout;
            string connString = "Data Source=" + dataSource + ";Initial Catalog=" + initialCatalog + ";User ID=" + userName + ";Password=" + password + ";Connect Timeout="+connTimeout; 
            SqlConnection conn = new SqlConnection(connString);
            
            try 
            {
                conn.Open();
                lb.Content = "Соединение установлено.";
                lb.Foreground = Brushes.Green;
                Model.conn = conn;
            }
            catch (Exception e)
            {
                lb.Content = "Не удается установить соединение";
                lb.Foreground = Brushes.Red;
              
            }

        }
    }

}
