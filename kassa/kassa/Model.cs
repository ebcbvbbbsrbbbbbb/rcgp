using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using System.Data;
using System.ComponentModel;
using System.Collections.ObjectModel;
using System.Data.SqlClient;
using System.Windows.Controls;
using System.Windows.Media;
using System.Windows;
using System.IO;
using System.Windows.Data;
using System.Windows.Documents;
using System.Windows.Input;
using System.Windows.Media.Imaging;
using System.Windows.Navigation;
using System.Windows.Shapes;
using Microsoft.Win32;




namespace kassa
{
    public class Model
    {
        public static class WindowElements
        {
            public static Label statusLabel;
            public static DataGrid workListDataGrid;
            public static DataGrid exportListDataGrid;
            public static DataGrid paymentListDataGrid;
            public static ComboBox cmbRecordType;
            public static StackPanel calendPanel;
            public static TextBlock saldoLabel;
            public static ProgressBar progressBar;
            public static Button btnExport;
            public static DataGrid PaymentsGrid;
        }

        public class ConnectionParameters : INotifyPropertyChanged
        {
            private string serverName;
            private string databaseName;
            private string userName;
            private string userPassword;
            private string serverTimeout;

            public string ServerName
            {
                get { return serverName; }
                set { serverName = value;
                    OnPropertyChanged("ServerName"); }
            }
            public string DatabaseName
            {
                get { return databaseName; }
                set
                {
                    databaseName = value;
                    OnPropertyChanged("DatabaseName");
                }
            }
            public string UserName
            {
                get { return userName; }
                set
                {
                    userName = value;
                    OnPropertyChanged("UserName");
                }
            }
            public string UserPassword
            {
                get { return userPassword; }
                set
                {
                    userPassword = value;
                    OnPropertyChanged("UserPassword");
                }
            }
            public string ServerTimeout
            {
                get { return serverTimeout; }
                set
                {
                    serverTimeout = value;
                    OnPropertyChanged("ServerTimeout");
                }
            }
            public event PropertyChangedEventHandler PropertyChanged;
            public void OnPropertyChanged(string prop = "")
            {
                if (PropertyChanged != null)
                {
                    PropertyChanged(this, new PropertyChangedEventArgs(prop));
                }
            }
        }

        public class OccSummary
        {
         
            public int Occ_id { get; set; }
            public decimal Value { get; set; }

            public OccSummary(int _occId, decimal _occTotal)
            {
                Occ_id = _occId;
                Value = _occTotal;
            }
        }

        public class NegativeSummary
        {

            public int Occ_id { get; set; }
            public decimal Value { get; set; }

            public NegativeSummary(int _occId, decimal _occTotal)
            {
                Occ_id = _occId;
                Value = _occTotal;
            }
        }

        public class Payment:INotifyPropertyChanged,ICloneable
        {
            private int _packid;
            private string _date;
            private string _service;
            private decimal _value;
            private bool _isChecked = false;
            private decimal _correction = 0;
            private PaymentsGroup _parent; // Ссылка на объект, содержащий платеж
            private decimal _oldValue = 0; 
            private string _isp_name;
            private string _isp_inn;
            private int _isp_id;
            private int _isSent;

            public Payment() { }
            public object Clone()
            {
                Payment clonedObject = new Payment(new PaymentsGroup(), this.Date, this.Service, this.Value, this.Isp_inn, this.Isp_name, this.IspId, this.IsSent);
                clonedObject.OldValue = this.OldValue;
                clonedObject.Correction = this.Correction;
                clonedObject.IsChecked = this.IsChecked;
                return clonedObject;
            }

            public int IsSent
            {
                get { return _isSent; }
                set { _isSent = value; }
            }
            public int IspId
            {
                get { return _isp_id; }
                set { _isp_id = value; }
            }

            public string Isp_name
            {
                get { return _isp_name; }
                set { _isp_name = value; }
            }
            public string Isp_inn
            {
                get { return _isp_inn; }
                set { _isp_inn = value; }
            }
                                 
            public decimal Correction
            {
                get { return _correction; }
                set { 
                   _correction = Model.Utility.CorrectPayment(this, value);
                    OnPropertyChanged("Correction");
                    }
            }
            public decimal OldValue
            {
                get { return _oldValue; }
                set { _oldValue = value;}
            }
            public int PackId
            {
                get { return _packid; }
                set { _packid = value; }
            }
            public PaymentsGroup Parent
            {
                get { return _parent; }
                set { _parent = value; }
            }
            public string Date
            {
                get { return _date; }
                set { _date = value; }
            }
            public string Service
            {
                get { return _service; }
                set { _service = value; }
            }
            public decimal Value
            {
                get { return _value; }
                set { _value = value;
                    OnPropertyChanged("Value");
                     }
            }

            public bool IsChecked
            {
                get { return _isChecked; }
                set {
                                      
                    _isChecked = value;
                    OnPropertyChanged("IsChecked");
                    if (value == true) { Parent.HowManyRecordsChecked += 1;} 
                    else Parent.HowManyRecordsChecked -= 1;                    
                     }
            }
            public Payment (PaymentsGroup _parent, string payment_date, string service_name, decimal payment_value, string _isp_inn, string _isp_name, int _isp_id, int _isSent )
            {
                IspId = _isp_id;
                IsSent = _isSent;
                Parent = _parent;
                Date = payment_date;
                Service = service_name;
                Value = payment_value;
                Parent.Total += Value;
                Isp_inn = _isp_inn;
                Isp_name = _isp_name;
            }

            public event PropertyChangedEventHandler PropertyChanged;
            public void OnPropertyChanged(string prop = "")
            {
                if (PropertyChanged != null)
                {
                    PropertyChanged(this, new PropertyChangedEventArgs(prop));
                }
            }

            public static explicit operator Payment(int v)
            {
                throw new NotImplementedException();
            }
        }

        public class PaymentsGroup:ICloneable, INotifyPropertyChanged // Группа платежей одного лицевого одной платежки (payment_id)
        {
            private int _occ; // Лицевой счет
            private int _payment_id; //ID платежа
            private decimal _total = 0; // Сумма платежей данного лицевого 
            private ObservableCollection<Payment> _paymentsCollection; // Коллекция конкретных платежей по услугам данного лицевого
            private int _iscorrect = 0; // Есть ли в этой группе отрицательные платежи 
            private int _pack_id; // ID пачки
            private string _source; // Источник платежа
            private string _email = "";
            private string _pack_date;
            private int _vipiska_id;
            private string _vipiska_date;
            private decimal _pack_total;
            private int _docsnum;
            private int _howManyRecordsChecked = 0; 
            public PaymentsGroup() { }
            public object Clone()
            {
                var _clonedPayments = this.PaymentsCollection.Select(i => (Payment)i.Clone()).ToList();
                this.Total = _clonedPayments.Select(i => i.Parent.Total).Sum();
                _clonedPayments.Select(i => i.Parent = null); 
                ObservableCollection<Payment> clonedPayments = new ObservableCollection<Payment>(_clonedPayments);
                PaymentsGroup clonedObject = new PaymentsGroup(this.IsCorrect, this.PackId, this.Occ, this.PaymentId, this.Email, clonedPayments, this.Source, this.Pack_date, this.Vipiska_id, this.Vipiska_date, this.Pack_total, this.Docsnum);
                foreach (Payment item in clonedObject.PaymentsCollection)
                {
                    item.Parent = clonedObject;
                }
              
                clonedObject.Total = this.Total;
                return clonedObject;
            }

            public int HowManyRecordsChecked
            {
                get { return _howManyRecordsChecked; }
                set { _howManyRecordsChecked = value;
                    OnPropertyChanged("HowManyRecordsChecked");
                }
            }
            public int Docsnum
            {
                get { return _docsnum; }
                set { _docsnum = value; }
            }

            public decimal Pack_total
            {
                get { return _pack_total; }
                set { _pack_total = value; }
            }
            
            public int Vipiska_id
            {
                get { return _vipiska_id; }
                set { _vipiska_id = value; }
            }
            public string Vipiska_date
            {
                get { return _vipiska_date; }
                set { _vipiska_date = value; }
            }
            public string Pack_date
            {
                get { return _pack_date; }
                set { _pack_date = value; }
            }
            public string Email
            {
                get { return _email; }
                set { _email = value; }
            }
            public string Source
            {
                get { return _source; }
                set { _source = value; }
            }
            public int PackId
            {
                get { return _pack_id; }
                set { _pack_id = value; }
            }
            public int IsCorrect
            {
                get { return _iscorrect; }
                set {
                    if(this.PaymentsCollection != null) {
                        if (this.PaymentsCollection.Where(i => (i.Value < 0)).Count() > 0)
                        {
                            _iscorrect = 1;
                        }
                        else { _iscorrect = 0; }
                    }
                    else _iscorrect = 0;
                   OnPropertyChanged("IsCorrect");

                }
            }
            public decimal  Total
            {
                get { return _total; }
                set { _total = value;
                    this.IsCorrect = _total >= 0 ? 0 : 1;
                        OnPropertyChanged("Total");
                }
            }
            public int Occ
            {
                get { return _occ; }
                set { _occ = value; }
            }
            public int PaymentId
            {
                get { return _payment_id; }
                set { _payment_id = value; }
            }


            public ObservableCollection<Payment> PaymentsCollection
            {
                get { return _paymentsCollection; }
                set { _paymentsCollection = value; }
            }
            public PaymentsGroup(int iscorrect, int _pack_id,  int occ_id, int payment_id, string _Email,  ObservableCollection<Payment> Payments, string _source, string _pack_date, int _vipiska_id, string _vipiska_date, decimal _pack_total, int _docsnum)
            {
                Occ = occ_id;
                PaymentId = payment_id;
                PaymentsCollection = Payments;
                IsCorrect = iscorrect;
                Email = _Email;
                PackId = _pack_id;
                Source = _source;
                Pack_date = _pack_date;
                Vipiska_id = _vipiska_id;
                Vipiska_date = _vipiska_date;
                Pack_total = _pack_total;
                Docsnum = _docsnum;
                
            }
            public event PropertyChangedEventHandler PropertyChanged;
            public void OnPropertyChanged(string prop = "")
            {
                if (PropertyChanged != null)
                {
                    PropertyChanged(this, new PropertyChangedEventArgs(prop));
                }
            }
        }

        public static class GlobalParameters
        {
            public static string connectionString = null;
            public static SqlConnection sqlConn = null;
            public static Dictionary<string, string> cmbDictionary;
            public static DataSet worklistDataset;
            public static bool selectAllFlag;
            private static decimal _saldo = 0;
            private static string username = "sa";
            private static string password = "1qW$";
            private static string dbname = "Stack";
            private static string host = "192.168.2.15";

            public static string Username
            {
                get { return username; }
                set { username = value; }
            }
            public static string DBname
            {
                get { return dbname; }
                set { dbname = value; }
            }
            public static string Password
            {
                get { return password; }
                set { password = value; }
            }
            public static string Host
            {
                get { return host; }
                set { host = value; }
            }
            public static decimal saldo {
                get { return _saldo;}
                set { _saldo = value;
                    saldoObject.OnPropertyChanged("saldo");
                }

            }
            public static DataSet packsDataset; 
            public static Saldo saldoObject;
            public static List<int> savedPackId; 

        }
        public class Saldo:INotifyPropertyChanged
        {
            public Saldo() { }
            public decimal saldo
            {
                get { return Model.GlobalParameters.saldo; }
                set { Model.GlobalParameters.saldo = value;
                    OnPropertyChanged("saldo");
                }
            }

            public event PropertyChangedEventHandler PropertyChanged;
            public void OnPropertyChanged(string prop = "")
            {
                if (PropertyChanged != null)
                {
                    PropertyChanged(this, new PropertyChangedEventArgs(prop));
                }
            }
        }
        
        public static class Utility
        {

            public static void HideCheckboxes(DependencyObject parent, string childDataGrid)
   
            {
                DataGrid temp;
                int childrenCount = VisualTreeHelper.GetChildrenCount(parent);

                    for (int i = 0; i < childrenCount; i++)
                    {
                            var currentChild = VisualTreeHelper.GetChild(parent, i);
                        if (( temp = currentChild as DataGrid) == null)
                        {
                            HideCheckboxes(currentChild, childDataGrid);
                        }
                        else
                        {
                        ((DataGrid)currentChild).Columns[3].Visibility = Visibility.Hidden;
                        ((DataGrid)currentChild).Columns[4].Visibility = Visibility.Hidden;
                    }
                    }               
                
            }
          
            public static void DistributePaymentsTable(ObservableCollection<Model.NegativeSummary> negativeSummary, ObservableCollection<Model.OccSummary> occSummary, ObservableCollection<Model.PaymentsGroup> o) 
            {
            for (int i = 0; i<Model.GlobalParameters.worklistDataset.Tables["PaymentsList"].Rows.Count; i++) // Растусовываем полученные данные по объектам 
                {
                int payment_id = Convert.ToInt32(Model.GlobalParameters.worklistDataset.Tables["PaymentsList"].Rows[i]["paying_id"]);
                int occ_id = Convert.ToInt32(Model.GlobalParameters.worklistDataset.Tables["PaymentsList"].Rows[i]["occ_id"]);
                int isCorrect = Convert.ToInt32(Model.GlobalParameters.worklistDataset.Tables["PaymentsList"].Rows[i]["isCorrect"]);
                decimal value = (decimal)Model.GlobalParameters.worklistDataset.Tables["PaymentsList"].Rows[i]["value"];
                string payment_date = ((DateTime)Model.GlobalParameters.worklistDataset.Tables["PaymentsList"].Rows[i]["paying_date"]).ToShortDateString();
                string service_name = Model.GlobalParameters.worklistDataset.Tables["PaymentsList"].Rows[i]["service_name"].ToString();
                int pack_id = Convert.ToInt32(Model.GlobalParameters.worklistDataset.Tables["PaymentsList"].Rows[i]["pack_id"]);
                string email = Model.GlobalParameters.worklistDataset.Tables["PaymentsList"].Rows[i]["email"].ToString();
                string isp_inn = Model.GlobalParameters.worklistDataset.Tables["PaymentsList"].Rows[i]["isp_inn"].ToString();
                string isp_name = Model.GlobalParameters.worklistDataset.Tables["PaymentsList"].Rows[i]["isp_name"].ToString();
                int isp_id = Convert.ToInt32(Model.GlobalParameters.worklistDataset.Tables["PaymentsList"].Rows[i]["isp_id"]);
                int isSent = Convert.ToInt32(Model.GlobalParameters.worklistDataset.Tables["PaymentsList"].Rows[i]["isSent"]);
                string source = Model.GlobalParameters.worklistDataset.Tables["PaymentsList"].Rows[i]["source"].ToString();
                int docsnum = Convert.ToInt32(Model.GlobalParameters.worklistDataset.Tables["PaymentsList"].Rows[i]["docsnum"]);
                decimal pack_total = (decimal)Model.GlobalParameters.worklistDataset.Tables["PaymentsList"].Rows[i]["pack_total"];
                string pack_date = ((DateTime)Model.GlobalParameters.worklistDataset.Tables["PaymentsList"].Rows[i]["pack_date"]).ToShortDateString();
                int vipiska_id = Convert.ToInt32(Model.GlobalParameters.worklistDataset.Tables["PaymentsList"].Rows[i]["vipiska_id"]);
                string vipiska_date = ((DateTime)Model.GlobalParameters.worklistDataset.Tables["PaymentsList"].Rows[i]["vipiska_date"]).ToShortDateString();
                

                    if (negativeSummary != null && occSummary != null)
                    {
                        if (value <= 0)
                        {
                            negativeSummary.Add(new Model.NegativeSummary(occ_id, value));
                        }

                        if (occSummary.ToList().Find(x => (x.Occ_id == occ_id)) == null)
                        {
                            occSummary.Add(new Model.OccSummary(occ_id, value));
                        }
                        else
                        {
                            var item = occSummary.ToList().Find(x => (x.Occ_id == occ_id));
                            occSummary[occSummary.IndexOf(item)].Value += value;
                        }
                    }
                    if ((o.ToList().Find(x => (x.PaymentId.ToString() == Model.GlobalParameters.worklistDataset.Tables["PaymentsList"].Rows[i]["paying_id"].ToString())) == null))
                        {

                        o.Add(new Model.PaymentsGroup(isCorrect, pack_id, occ_id, payment_id, email, new ObservableCollection<Model.Payment>(),source, pack_date, vipiska_id,vipiska_date,pack_total, docsnum));
                            o.Last().PaymentsCollection.Add(new Model.Payment(o.Last(), payment_date, service_name, value, isp_inn, isp_name,isp_id,isSent));
                        }
                    else
                        {

                         var item = (o.ToList().Find(x => (x.PaymentId == payment_id)));
                        if (o[o.IndexOf(item)].IsCorrect < isCorrect) { o[o.IndexOf(item)].IsCorrect = isCorrect;}
                        o[o.IndexOf(item)].PaymentsCollection.Add(new Model.Payment(o[o.IndexOf(item)], payment_date, service_name, value, isp_inn, isp_name, isp_id, isSent));
                        }
                }
            }



            public static string makeConnectionString(string serverName, string dbName, string userName, string userPassword, int connectionTimeout)
            {
               return "Data Source=" + serverName + ";Initial Catalog=" + dbName + ";User ID=" + userName + ";Password=" + userPassword + ";Connect Timeout=" + connectionTimeout.ToString();

            }
         public static void connectToDatabase(string connectionString)
            {
                SqlConnection conn;
                try
                {  conn = new SqlConnection(connectionString);
                    try
                    {
                        conn.Open();
                        GlobalParameters.sqlConn = conn;

                    }
                    catch
                    {
                        GlobalParameters.sqlConn = null;
                    }

                }
                catch
                {
                    MessageBox.Show("Не удается подключиться к серверу. \r\n Проверьте настройки подключения.");
                    GlobalParameters.sqlConn = null;
                }               
            }

            public static decimal CorrectPayment(Model.Payment currentPayment, decimal newCorrection)
            {
                decimal returnValue;
                if (currentPayment.OldValue == 0) { currentPayment.OldValue = currentPayment.Value;}

                if (currentPayment.Correction == 0)
                {
                    returnValue = newCorrection;
                    currentPayment.Value = currentPayment.OldValue + newCorrection;
                    currentPayment.Parent.Total += newCorrection; 
                   
                    Model.GlobalParameters.saldo += newCorrection;
                }
                else
                {
                    Model.GlobalParameters.saldo -= (currentPayment.Correction - newCorrection);
                   
                    returnValue = newCorrection;
                    currentPayment.Value = currentPayment.OldValue + newCorrection;
                    currentPayment.Parent.Total -= (currentPayment.Correction - newCorrection);
                }
                return returnValue;
            }
        }
        
        public static class DataGridUtilities
        {
            public static SqlCommand cmd;
            public static SqlParameter dateFrom;
            public static SqlParameter dateTo;
            public static SqlDataAdapter adapter;
            public static void FillWorkList(ComboBox cmbRecordTypes)
            {

                cmd = new SqlCommand();
                cmd.CommandText = GlobalParameters.cmbDictionary[((ComboBoxItem)(cmbRecordTypes.SelectedItem)).Tag.ToString()];
                cmd.Connection = Model.GlobalParameters.sqlConn;
                dateFrom = new SqlParameter("@dateFrom", DbType.Date);
                dateTo = new SqlParameter("@dateTo", DbType.Date);

                switch (((ComboBoxItem)(cmbRecordTypes.SelectedItem)).Tag.ToString())
                
                {
                    case "1": 
                        dateFrom.Value = Convert.ToDateTime(((DatePicker)((DockPanel)Model.WindowElements.calendPanel.Children[0]).Children[1]).Text);
                        dateTo.Value = Convert.ToDateTime(((DatePicker)((DockPanel)Model.WindowElements.calendPanel.Children[1]).Children[1]).Text);
                    break;

                    case "2":
                        dateFrom.Value = new DateTime(DateTime.Now.Year, DateTime.Now.Month,1);
                        dateTo.Value = new DateTime(DateTime.Now.Year, DateTime.Now.Month+1, 1).AddDays(-1);
                        break;

                }

                cmd.Parameters.Add(dateFrom);
                cmd.Parameters.Add(dateTo);
                SqlDataAdapter adapter = new SqlDataAdapter(cmd);
                Model.GlobalParameters.worklistDataset.Tables["Worklist"].Clear();
                adapter.Fill(Model.GlobalParameters.worklistDataset,"Worklist");
                
            }
            public static void ExportData()
            {
                decimal totalSum = 0; // Сумма всех платежей выгрузки


                if (Model.GlobalParameters.worklistDataset.Tables["ExportList"].Select("isChecked = true").Count() == 0)
                {
                    MessageBox.Show("Не выделено ни одной пачки.");
                    return;
                };
                if (Model.GlobalParameters.worklistDataset.Tables["ExportList"].Select("isCorrect = 1").Count() != 0)
                {
                    MessageBox.Show("Выделены пачки с отрицательными платежами");
                    return;
                };
                List<int> packsNew = Model.GlobalParameters.worklistDataset.Tables["ExportList"].Select("send_date is null and isChecked=true")
                    .Select(i => ((int)i["pack_id"])).Where(i => !Model.GlobalParameters.savedPackId.Contains(i)).ToList(); //Пачки, которые ранее не выгружались, и которые не содержатся в savedPacks
                List<int> packsOld = Model.GlobalParameters.worklistDataset.Tables["ExportList"]
                    .Select("send_date is not null and isChecked=true").Select(i => ((int)i["pack_id"])).ToList(); //Пачки, которые ранее уже выгружались
                
                // Если есть отмеченные пачки, которые либо ранее выгружались, 
                // либо не выгружались, но НЕ лежат в сохраненных
                if (packsNew.Count > 0 || packsOld.Count > 0)
                {
                    // Отправляем ли ранее отправленные пачки повторно
                    if (packsOld.Count > 0)
                    {
                        string message = "Следующие пачки уже были выгружены:  \r\n \r\n";
                        foreach (var i in packsOld)
                        {
                            message += "Пачка " + i.ToString() + "\r\n";

                        }
                        MessageBox.Show(message,
                        "Пачки уже были выгружены!", MessageBoxButton.OK, MessageBoxImage.Warning);

                        MessageBoxResult result = MessageBox.Show("Вы действительно хотите ПОВТОРНО отправить данные?",
                        "Подтверждение повторной отправки", MessageBoxButton.OKCancel, MessageBoxImage.Warning);
                        if (result == MessageBoxResult.Cancel)
                        {
                            return;
                        }

                    }
                    Application.Current.Dispatcher.Invoke(delegate () { Model.WindowElements.btnExport.IsEnabled = false; });
                    string selectParam = "";
                    string historySelectParam = "";
                    string selectFull = "";

                    //Формируем строку запроса 
                    if (packsOld.Count > 0)
                    {
                        foreach (int item in packsOld)
                        {
                            historySelectParam += item.ToString() + ',';
                        }
                        historySelectParam = historySelectParam.Substring(0, historySelectParam.Length - 1);
                    }
                    else historySelectParam = "";

                    if (packsNew.Count > 0)
                    {
                        foreach (int item in packsNew)
                        {
                            selectParam += item.ToString() + ',';
                        }
                        selectParam = selectParam.Substring(0, selectParam.Length - 1);

                    }
                    else selectParam = "";
                    selectParam = selectParam == "" ? "" : "SELECT vipiska_id, vipiska_date, pack_id, pack_date, pack_total, docsnum, source, occ_id, email, paying_id,  service_name, value, paying_date, isp_id,  isp_name, isp_inn, 0 as isSent from Stack.kassa_payments where pack_id in (" + selectParam + ")";
                    historySelectParam = historySelectParam == "" ? "" : "SELECT vipiska_id, vipiska_date, pack_id, pack_date, pack_total, docsnum, source, occ_id, email, paying_id,  service_name, value, paying_date, isp_id,  isp_name, isp_inn, 1 as isSent from Stack.kassa_history where pack_id in (" + historySelectParam + ")";
                    if (selectParam != "" && historySelectParam != "")
                    {
                        selectFull = selectParam + " UNION " + historySelectParam + " order by occ_id";
                    }
                    else selectFull = selectParam + historySelectParam + " order by occ_id";
                   

                    //Заполняем итоговую таблицу, из которой будем выгружать в файл
                    SqlCommand cmd = new SqlCommand(selectFull, Model.GlobalParameters.sqlConn);
                    SqlDataAdapter da = new SqlDataAdapter(cmd);
                    da.Fill(Model.GlobalParameters.worklistDataset, "forExport");
                }
                // Если есть отмеченные пачки, которые были сохранены после редактирования
                
                if (Model.GlobalParameters.worklistDataset.Tables["ExportList"].Select("isChecked=true")
                   .Select(i => ((int)i["pack_id"])).Where(i => Model.GlobalParameters.savedPackId.Contains(i)).Count() > 0)
                {
                    foreach (int item in Model.GlobalParameters.worklistDataset.Tables["ExportList"].Select("isChecked=true")
                   .Select(i => ((int)i["pack_id"])).Where(i => Model.GlobalParameters.savedPackId.Contains(i)))
                    {
                        foreach (PaymentsGroup pg in Payments.savedPacks[item])
                        {
                            foreach (Payment p in pg.PaymentsCollection) {
                                if (p.Value > 0)
                                { 
                                Model.GlobalParameters.worklistDataset.Tables["forExport"].Rows.Add(
                                    pg.Vipiska_id,
                                    pg.Vipiska_date,
                                    pg.PackId,
                                    pg.Pack_date,
                                    pg.Pack_total,
                                    pg.Docsnum,
                                    pg.Source,
                                    pg.Occ,
                                    pg.Email,
                                    pg.PaymentId,
                                    p.Service,
                                    p.Value,
                                    p.Date,
                                    p.IspId,
                                    p.Isp_name,
                                    p.Isp_inn,
                                    p.IsSent
                                    );
                                }
                            }
                        }
                    }
                }
               
                if
                (
                 Model.GlobalParameters.worklistDataset.Tables["forExport"].Select("value<0").Count() > 0 ||
                 Model.GlobalParameters.worklistDataset.Tables["forExport"].Rows.Count == 0
                )
                {
                    MessageBox.Show("Таблица пуста или имеются отрицательные платежи.");
                    return;
                }
                if (Model.GlobalParameters.worklistDataset.Tables["forExport"].Select("isp_name='' or isp_inn=''").Count()>0)
                {
                    List < DataRow > withoutIsp = Model.GlobalParameters.worklistDataset.Tables["forExport"].Select("isp_name='' or isp_inn=''").ToList();
                    string message = "Не заполнены данные об исполнителе в следующих платежах:\r\n";
                    foreach (var i in withoutIsp)
                    {
                        message += "Лицевой счет: " + i["occ_id"].ToString() + " услуга: " +i["service_name"].ToString() +" сумма: " +i["value"].ToString() + "\r\n";
                    }
                    message += "Продолжаем?";

                    MessageBoxResult result = MessageBox.Show(message,
                    "Подтверждение отправки", MessageBoxButton.OKCancel, MessageBoxImage.Warning);
                    if (result == MessageBoxResult.Cancel)
                    {
                        return;
                    }
                }
                //Отделяем платежи, которые уже были выгружены, от еще не выгруженных
                //и отправляем получившуюся таблицу в процедуру на сервере
                Model.GlobalParameters.worklistDataset.Tables.Add("payingsToAdd"); //Таблица с платежами, которую будем отправлять на сервер
                Model.GlobalParameters.worklistDataset.Tables["payingsToAdd"].Columns.Add("vipiska_id", Type.GetType("System.Int32"));
                Model.GlobalParameters.worklistDataset.Tables["payingsToAdd"].Columns.Add("vipiska_date", Type.GetType("System.DateTime"));
                Model.GlobalParameters.worklistDataset.Tables["payingsToAdd"].Columns.Add("pack_id", Type.GetType("System.Int32"));
                Model.GlobalParameters.worklistDataset.Tables["payingsToAdd"].Columns.Add("pack_date", Type.GetType("System.DateTime"));
                Model.GlobalParameters.worklistDataset.Tables["payingsToAdd"].Columns.Add("pack_total", Type.GetType("System.Decimal"));
                Model.GlobalParameters.worklistDataset.Tables["payingsToAdd"].Columns.Add("docsnum", Type.GetType("System.Int32"));
                Model.GlobalParameters.worklistDataset.Tables["payingsToAdd"].Columns.Add("source", Type.GetType("System.String"));
                Model.GlobalParameters.worklistDataset.Tables["payingsToAdd"].Columns.Add("occ_id", Type.GetType("System.Int32"));
                Model.GlobalParameters.worklistDataset.Tables["payingsToAdd"].Columns.Add("email", Type.GetType("System.String"));
                Model.GlobalParameters.worklistDataset.Tables["payingsToAdd"].Columns.Add("paying_id", Type.GetType("System.Int32"));
                Model.GlobalParameters.worklistDataset.Tables["payingsToAdd"].Columns.Add("service_name", Type.GetType("System.String"));
                Model.GlobalParameters.worklistDataset.Tables["payingsToAdd"].Columns.Add("value", Type.GetType("System.Decimal"));
                Model.GlobalParameters.worklistDataset.Tables["payingsToAdd"].Columns.Add("paying_date", Type.GetType("System.DateTime"));
                Model.GlobalParameters.worklistDataset.Tables["payingsToAdd"].Columns.Add("isp_id", Type.GetType("System.Int32"));
                Model.GlobalParameters.worklistDataset.Tables["payingsToAdd"].Columns.Add("isp_name", Type.GetType("System.String"));
                Model.GlobalParameters.worklistDataset.Tables["payingsToAdd"].Columns.Add("isp_inn", Type.GetType("System.String"));
                Model.GlobalParameters.worklistDataset.Tables["payingsToAdd"].Columns.Add("isSent", Type.GetType("System.Int32")).DefaultValue = 0;
                Model.GlobalParameters.worklistDataset.Tables["forExport"].Select("isSent=0").CopyToDataTable(Model.GlobalParameters.worklistDataset.Tables["payingsToAdd"], LoadOption.OverwriteChanges);
                SqlCommand command = new SqlCommand();
                command.Connection = Model.GlobalParameters.sqlConn;
                command.CommandType = CommandType.StoredProcedure;
                command.CommandText = "dbo.InsertToHistory"; 
                command.Parameters.Add(new SqlParameter("@table", Model.GlobalParameters.worklistDataset.Tables["payingsToAdd"]));
                command.ExecuteNonQuery();
                string filePath = "";
                decimal total = 0; 
                decimal total2 = 0; 
                int paymentsCount = Model.GlobalParameters.worklistDataset.Tables["forExport"].Rows.Count; // Общее количество платежей
                SaveFileDialog sf = new SaveFileDialog();
                sf.Filter = "*.csv|.csv";
                sf.RestoreDirectory = true;
                sf.FileName = "[" + DateTime.Now.Year + DateTime.Now.Month + DateTime.Now.Day + DateTime.Now.Hour + DateTime.Now.Minute + DateTime.Now.Second + "] выгрузка для онлайн-кассы";
                if (sf.ShowDialog() == true)
                {
                    Application.Current.Dispatcher.Invoke(delegate () { Model.WindowElements.btnExport.IsEnabled = false; });
                    Application.Current.Dispatcher.Invoke(delegate () { Model.WindowElements.progressBar.Maximum = Model.GlobalParameters.worklistDataset.Tables["forExport"].Rows.Count; });
                    filePath = sf.FileName;
                    totalSum = (decimal)Model.GlobalParameters.worklistDataset.Tables["forExport"].Compute("SUM(value)", string.Empty);
                    FileStream fs = new FileStream(filePath, FileMode.Create, FileAccess.Write);
                    StreamWriter sw = new StreamWriter(fs, System.Text.Encoding.Default);
                    sw.Write("#Выгрузка данных для онлайн-кассы\r\n");
                    sw.Write("#"+ DateTime.Now.ToString()+"\r\n");
                    sw.Write("#Количество платежей:" + paymentsCount.ToString() + "\r\n");
                    sw.Write("#Сумма платежей: "+totalSum.ToString()+"\r\n");
                    sw.Write("#Идентификатор платежа|Дата платежа|Лицевой счет|Электронная почта|{услуга:сумма:ИНН исполнителя}|Сумма платежей\r\n");
                    sw.WriteLine();
                    List<int> payingIdList = new List<int>(); // Список уникальных платежей для выгрузки
                    payingIdList = Model.GlobalParameters.worklistDataset.Tables["forExport"].Select().Select(i => ((int)i["paying_id"])).Distinct().ToList();
                    List<List<DataRow>> paymentsList = new List<List<DataRow>>(); //Список сгруппированных по paying_id платежей
                   
                    foreach (int item in payingIdList)
                    {
                        paymentsList.Add(Model.GlobalParameters.worklistDataset.Tables["forExport"].Select("paying_id="+item.ToString()).ToList());
                    }
                    foreach (List<DataRow> drList in paymentsList)
                    {
                        sw.Write(drList[0]["paying_id"].ToString() + "|" + ((DateTime)drList[0]["paying_date"]).ToShortDateString() + "|" + drList[0]["occ_id"].ToString() + "|" + drList[0]["email"] + "|");

                        foreach (DataRow dr in drList)
                        {
                            sw.Write("{" + dr["service_name"].ToString() + ":" + ((decimal)dr["value"]).ToString("f2") +":"+ dr["isp_inn"].ToString() + "}");
                            total += (decimal)dr["value"];
                            total2 += (decimal)dr["value"];
                            Application.Current.Dispatcher.Invoke(delegate () { Model.WindowElements.progressBar.Value += 1; });
                        }
                        sw.Write("|" + total.ToString("f2")); // В конце строки выводим итоговую сумму платежей по данному paying_id
                        sw.Write("\r\n");
                        total = 0;
                    }

                    sw.Close();
                    MessageBox.Show("Файл сохранен: " + filePath);
                }
                MessageBox.Show(totalSum.ToString());
                MessageBox.Show(total2.ToString());              
                packsNew.Clear();
                packsOld.Clear();
                List<DataRow> rowsToDeleteEL = new List<DataRow>(Model.GlobalParameters.worklistDataset.Tables["ExportList"].Select("isChecked = true").ToList());
                foreach (DataRow dr in rowsToDeleteEL)
                {
                    Model.GlobalParameters.worklistDataset.Tables["ExportList"].Rows.Remove(dr);

                }  
                List<DataRow> rowsToDeleteWL = new List<DataRow>(Model.GlobalParameters.worklistDataset.Tables["Worklist"].Select("isChecked = true").ToList()); ;
                foreach (DataRow dr in rowsToDeleteWL)
                {
                    Model.GlobalParameters.worklistDataset.Tables["Worklist"].Rows.Remove(dr);

                }
                Model.GlobalParameters.worklistDataset.AcceptChanges();
                Model.GlobalParameters.worklistDataset.Tables["forExport"].Clear();
                if (Payments.savedPacks != null) Payments.savedPacks.Clear();
                Model.GlobalParameters.worklistDataset.Tables.Remove("payingsToAdd");
                Model.GlobalParameters.savedPackId.Clear();
                Application.Current.Dispatcher.Invoke(delegate () { Model.WindowElements.btnExport.IsEnabled = true; });
                Application.Current.Dispatcher.Invoke(delegate () { Model.WindowElements.progressBar.Value = 0; });
                Application.Current.Dispatcher.Invoke(delegate () {Model.WindowElements.workListDataGrid.Items.Refresh();});
                Application.Current.Dispatcher.Invoke(delegate () { Model.WindowElements.exportListDataGrid.Items.Refresh(); });

            }
            public static void FillExportList(DataSet ds)
            {
                IEnumerable<DataRow> query =
                     from wl in ds.Tables["Worklist"].AsEnumerable()
                     where wl.Field<Boolean>("isChecked") == true
                     orderby wl.Field<Int32>("isCorrect") descending
                     select wl;
                foreach (DataRow dr in query)
                {
                   if (!ds.Tables["ExportList"].Rows.Contains(dr.ItemArray[2]))
                   {
                        ds.Tables["ExportList"].ImportRow(dr);
                        
                   }
                }
                (ds.Tables["ExportList"].AsDataView()).Sort = "isCorrect";

            }
        }
    }
}
