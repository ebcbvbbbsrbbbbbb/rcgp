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

    public class OutterCellColorConverter : IMultiValueConverter //Конвертер цветов ячеек основного грида
    {
        object returnValue;
        public object Convert(object[] values, Type TargetType, object parameter, CultureInfo culture)
        {

            if (((int)values[0]) == 0)
            {

                if ((((DataGridRow)values[1]).GetIndex()) % 2 != 0)
                {
                    
                    if (((int)values[3]) > 0)
                    { 
                        returnValue = new SolidColorBrush(Colors.LightBlue); //#ffc64a
                    }
                    else returnValue = new SolidColorBrush(Color.FromArgb(0xff, 0xff, 0xc6, 0x4a)); //#ffc64a
                }

                else
                {
                    if (((int)values[3]) > 0)
                    {
                        returnValue = new SolidColorBrush(Colors.LightBlue); //#ffc64a
                    }
                    else returnValue = new SolidColorBrush(Color.FromArgb(0xff, 0xe8, 0xd7, 0x92)); //#e8d792
                }
            }
            else
            {
               
                returnValue = new SolidColorBrush(Colors.OrangeRed); //#e8d792
            }

            return returnValue;

        }

        public object[] ConvertBack(object value, Type[] targetTypes, object parameter, CultureInfo culture)
        {
            throw new NotImplementedException();            
            
        }
    }


    public class SummaryCellColorConverter : IMultiValueConverter //Конвертер цветов ячеек сводки
    {
        object returnValue;
        public object Convert(object[] values, Type TargetType, object parameter, CultureInfo culture)
        {
           
                if (((decimal)values[0]) >= 0)
                {
                    if ((((DataGridRow)values[1]).GetIndex()) % 2 != 0)
                    {
                        returnValue = new SolidColorBrush(Color.FromArgb(0xff, 0xd7, 0xf7, 0xfa)); //#d7f7fa
                    }

                    else
                    {
                        returnValue = new SolidColorBrush(Color.FromArgb(0xff, 0xc9, 0xe2, 0xff)); //#f2e099
                    }
                }
                else
                {
                    returnValue = new SolidColorBrush(Colors.OrangeRed); //#e8d792
                }

   

            return returnValue;

        }
        public object[] ConvertBack(object value, Type[] targetTypes, object parameter, CultureInfo culture)
        {
            throw new NotImplementedException();

        }
    }
        public class InnerCellColorConverter : IMultiValueConverter //Конвертер цветов ячеек внутреннего грида
    {
        object returnValue;
        public object Convert(object[] values, Type TargetType, object parameter, CultureInfo culture)
        {
            if ((string)parameter == "Enabled")
            {
                if ((bool)values[0] == true)
                {
                    returnValue = false;
                }
                else returnValue = true;
            }
            else {

                   if (((decimal)values[0]) >= 0)
                    {
                        if ((((DataGridRow)values[2]).GetIndex()) % 2 != 0)
                        {
                            returnValue = new SolidColorBrush(Color.FromArgb(0xff, 0xd7, 0xf7, 0xfa)); //#d7f7fa
                        }

                        else
                        {
                            returnValue = new SolidColorBrush(Color.FromArgb(0xff, 0xc9, 0xe2, 0xff)); //#f2e099
                        }
                    }
                    else
                    {
                        returnValue = new SolidColorBrush(Colors.OrangeRed); //#e8d792
                    }               
            }

            return returnValue;

        }

        public object[] ConvertBack(object value, Type[] targetTypes, object parameter, CultureInfo culture)
        {
            throw new NotImplementedException();
        }
    }

        public class RowColorConverter : IValueConverter
    {
        public object Convert(object IsCorrect, Type targetType, object parameter, CultureInfo culture)
        {
            object returnValue;

            if ((int)IsCorrect == 1)
            {
                switch ((string)parameter)
                {
                    case "BorderBrush":
                        returnValue = new SolidColorBrush(Colors.OrangeRed);
                        break;
                    case "Background":
                        returnValue = new SolidColorBrush(Colors.Red);
                        break;
                    case "BorderThickness":
                        returnValue = "1";
                        break;
                    case "Foreground": 
                        returnValue = new SolidColorBrush(Colors.White);
                        break;
                    default:
                        returnValue = null;
                        break;
                }
            }
            else
            {
                switch ((string)parameter)
                {
                    case "BorderBrush":
                        returnValue = new SolidColorBrush(Colors.OrangeRed);
                        break;
                    case "Background":
                        returnValue = new SolidColorBrush(Color.FromArgb(0xFF, 0xA4, 0xEA, 0xF7)); //#FFA4EAF7
                        break;
                    case "BorderThickness":
                        returnValue = "0";
                        break;
                    default:
                        returnValue = null;
                        break;
                }
            }
            return returnValue;

        }
        public object ConvertBack(object Total, Type targetType, object parameter, CultureInfo culture)
        {
            throw new Exception("Невозможно применить RowColorConverter");
        }

    }

    public class ValueConverter : IValueConverter
    {
        public object Convert(object value, Type targetType, object parameter, CultureInfo culture)
        {
            try
            {
                if ((decimal)value < 0)
                {
                    return new SolidColorBrush(Colors.OrangeRed);
                }
                else
                    return new SolidColorBrush(Colors.LightGreen);
            }
            catch { return new SolidColorBrush(Colors.LightGreen); }
           
        }
        public object ConvertBack(object value, Type targetType, object parameter, CultureInfo culture)
        {
            throw new Exception("Невозможно применить конвертер");   
        }

    }
    public partial class Payments : Window
    {
        public int currentPack;
        Dictionary<string, int> autodeleteProperty;
        DataTable occPayments; // Для сводки по счетам
        DataTable negativePayments; // Для сводки по отрицательным платежам
        DataRowView sp;    // Выделенная строка в exportListDataGrid
        public static ObservableCollection<Model.OccSummary> occSummary;
        public static ObservableCollection<Model.NegativeSummary> negativeSummary;
        public static ObservableCollection<Model.PaymentsGroup> o;
        public static ObservableCollection<Model.PaymentsGroup> source;
        public static Dictionary<int, ObservableCollection<Model.PaymentsGroup>> savedPacks;
        public static Dictionary<int, ObservableCollection<Model.PaymentsGroup>> sourcePacks; 
        public int paymQuantity { get; set; } = 0;

        public Payments(){}
        public Payments(object selectedPack, Dictionary<string,string> uploadedPacks)
        {
            InitializeComponent();
            Model.Saldo saldo = new Model.Saldo();
            Model.GlobalParameters.saldoObject = saldo;
            lblSaldo.DataContext = saldo;
            Model.WindowElements.PaymentsGrid = PaymentsGrid;
            occPayments = new DataTable("occPayments");
            occPayments.Columns.Add("occ_id", Type.GetType("System.Int32"));
            occPayments.Columns.Add("value", Type.GetType("System.Decimal"));
            negativePayments = new DataTable("negativePayments");
            negativePayments.Columns.Add("occ_id", Type.GetType("System.Int32"));
            negativePayments.Columns.Add("value", Type.GetType("System.Decimal"));
            grOccPayments.ItemsSource = occPayments.DefaultView;            
            autodeleteProperty = new Dictionary<string, int>(); 
            Model.GlobalParameters.saldo = 0; 
            Model.WindowElements.saldoLabel = lblSaldo;
            Model.WindowElements.saldoLabel.Text = Model.GlobalParameters.saldo.ToString("N2");
            SqlCommand cmd = new SqlCommand();
            cmd.Connection = Model.GlobalParameters.sqlConn;
            sp = Model.WindowElements.exportListDataGrid.SelectedItem as DataRowView;
            currentPack = (Int32)sp.Row["pack_id"]; // Выбранная пачка
            negativeSummary = new ObservableCollection<Model.NegativeSummary>();
            occSummary = new ObservableCollection<Model.OccSummary>();
            if (o == null)
                { 
                  o = new ObservableCollection<Model.PaymentsGroup>(); // Коллекция групп платежей текущей пачки
                }
            source = new ObservableCollection<Model.PaymentsGroup>(); // Коллекция групп платежей для сохранения исходного состояния пачки
            grOccNegative.ItemsSource = negativeSummary;
            grOccPayments.ItemsSource = occSummary;
            Model.WindowElements.PaymentsGrid.Items.Clear();

            if (sourcePacks == null)
            {        
                sourcePacks = new Dictionary<int, ObservableCollection<Model.PaymentsGroup>>();
            }


            if (savedPacks == null)
            { 
               savedPacks = new Dictionary<int, ObservableCollection<Model.PaymentsGroup>>();
            }


            if (savedPacks.ContainsKey(currentPack))
            {
                o = savedPacks[currentPack];
                btnLoadSource.Visibility = Visibility.Visible;  
            }


            else
            {
               
                if (sourcePacks.ContainsKey(currentPack))
                {
                    o = new ObservableCollection<Model.PaymentsGroup>(sourcePacks[currentPack].Select(i => (Model.PaymentsGroup)i.Clone()).ToList());
                    btnLoadSource.Visibility = Visibility.Collapsed;
                }
                
                else

                {
                  
                    if (sp.Row["send_date"].ToString() != "")
                    {
                        cmd.CommandText = "SELECT (select case when value < 0 then 1 else 0 end ) as isCorrect,  vipiska_id, vipiska_date, pack_id, pack_date, pack_total, docsnum, source,  occ_id, email, paying_id, service_name, value,  paying_date, isp_id, isp_name, isp_inn, 1 as isSent from Stack.kassa_history where pack_id = @pack_id order by occ_id";
                        SqlParameter p = new SqlParameter("@pack_id", System.Data.SqlDbType.Int);
                        p.Value = sp.Row["pack_id"];
                        cmd.Parameters.Add(p);
                        SqlDataAdapter da = new SqlDataAdapter(cmd);
                        btnSave.Visibility = Visibility.Collapsed; // Отключаем кнопку "Сохранить"
                        lblSaldo.Visibility = Visibility.Collapsed;
                        lblBalance.Visibility = Visibility.Collapsed;
                        BlockSent.Visibility = Visibility.Visible;
                        btnLoadSource.Visibility = Visibility.Collapsed;
                        packNumber.Content = "Пачка №" + currentPack.ToString();
                        packSendDate.Content = "дата отправки: " + ((DateTime)sp.Row["send_date"]).ToShortDateString();
                        Model.GlobalParameters.worklistDataset.Tables["PaymentsList"].Clear(); // Чистим список платежей 
                        da.Fill(Model.GlobalParameters.worklistDataset.Tables["PaymentsList"]);
                    }
                   
                    else
                    {
                        cmd.CommandText = "SELECT (select case when value < 0 then 1 else 0 end ) as isCorrect,  vipiska_id, vipiska_date, pack_id, pack_date, pack_total, docsnum, source,  occ_id, email, paying_id, service_name, value,  paying_date, isp_id, isp_name, isp_inn, 0 as isSent from Stack.kassa_payments where pack_id = @pack_id order by occ_id";
                        SqlParameter p = new SqlParameter("@pack_id", System.Data.SqlDbType.Int);
                        p.Value = sp.Row["pack_id"];
                        cmd.Parameters.Add(p);
                        SqlDataAdapter da = new SqlDataAdapter(cmd);
                        Model.GlobalParameters.worklistDataset.Tables["PaymentsList"].Clear();
                        da.Fill(Model.GlobalParameters.worklistDataset.Tables["PaymentsList"]);
                        btnSave.Visibility = Visibility.Visible;
                        lblSaldo.Visibility = Visibility.Visible;
                        lblBalance.Visibility = Visibility.Visible;
                        BlockSent.Visibility = Visibility.Collapsed;
                        btnLoadSource.Visibility = Visibility.Collapsed;


                    }
                    o.Clear();
                    Model.Utility.DistributePaymentsTable(negativeSummary, occSummary, o);
                    
                }

            }

            PaymentsGrid.ItemsSource = o;
            if (!sourcePacks.ContainsKey(currentPack))
            {
               
            var _source = ((ObservableCollection < Model.PaymentsGroup >)PaymentsGrid.ItemsSource).Select(i => (Model.PaymentsGroup)i.Clone()).ToList();
            sourcePacks.Add(currentPack, new ObservableCollection<Model.PaymentsGroup>(_source)); 
            }
        }

        private void OnChecked(object sender, RoutedEventArgs e)
        {
         
            DataGrid inn =  this.FindName("InnerGrid") as DataGrid;
        
        }
        private void OnUnchecked(object sender, RoutedEventArgs e)
        {
            DataRowView currentRow = (DataRowView)Model.WindowElements.paymentListDataGrid.SelectedItem;
            int index = Model.WindowElements.paymentListDataGrid.SelectedIndex;
            DataRow dr = Model.GlobalParameters.packsDataset.Tables[currentPack.ToString()].Rows[index];
            decimal oldValue = (decimal)dr["value"];
            
            Model.GlobalParameters.saldo = Model.GlobalParameters.saldo - (oldValue - (decimal)currentRow["value"]);
            Model.WindowElements.saldoLabel.Text = Model.GlobalParameters.saldo.ToString("f2");


            currentRow["value"] = oldValue;
            currentRow.EndEdit();
        }

        private void Button_Click(object sender, RoutedEventArgs e) // Кнопка "Загрузить исходную"
        {            

            savedPacks.Remove(currentPack);
            Model.GlobalParameters.savedPackId.Remove(currentPack);

            var source_temp = (sourcePacks[currentPack]).Select(i => (Model.PaymentsGroup)i.Clone()).ToList();
            PaymentsGrid.ItemsSource = new ObservableCollection<Model.PaymentsGroup>(source_temp);
            btnLoadSource.Visibility = Visibility.Collapsed;



        }


        private void Button_Click_1(object sender, RoutedEventArgs e) // Кнопка "Сохранить"
        {
            if (cbAllowUnbalanced.IsChecked == false)
            {
                if (Model.GlobalParameters.saldo != 0)
                { MessageBox.Show("Сохранение возможно только при балансе, равном нулю."); return; }
            }
          if (o.Where(i => (i.IsCorrect == 1)).Count() > 0)
            { MessageBox.Show("Есть отрицательные значения.");
            return;
            }

            if (savedPacks.ContainsKey(currentPack))
            {
                savedPacks.Remove(currentPack);
                Model.GlobalParameters.savedPackId.Remove(currentPack);
            }

            var _savedPacks = ((ObservableCollection<Model.PaymentsGroup>)PaymentsGrid.ItemsSource).Select((i => (Model.PaymentsGroup)i.Clone())).ToList();
            savedPacks.Add(currentPack, new ObservableCollection<Model.PaymentsGroup>(_savedPacks));
            Model.GlobalParameters.savedPackId.Add(currentPack); //По этому списку будем смотреть, какие пачки будем выгружать из локальной копии

           
            var x = (DataRow)(Model.GlobalParameters.worklistDataset.Tables["ExportList"].Select("pack_id=" + currentPack.ToString())).First();
            x["IsCorrect"] = 0;
            x = (DataRow)(Model.GlobalParameters.worklistDataset.Tables["Worklist"].Select("pack_id=" + currentPack.ToString())).First();
            x["IsCorrect"] = 0;
            Payments.GetWindow(this).Close();
        }

        private void PaymentsGrid_Unloaded(object sender, RoutedEventArgs e) //  DeferRefreshException при закрытии окна платежей
        {

            var grid = (DataGrid)sender;
            grid.CommitEdit(DataGridEditingUnit.Row, true);
            if (autodeleteProperty.ContainsKey(currentPack.ToString()))
            {
                if (autodeleteProperty[currentPack.ToString()] == 1)
                {
                    Model.GlobalParameters.packsDataset.Tables.Remove(currentPack.ToString());
                }

            }
        }


        private void PaymentsGrid_Loaded(object sender, RoutedEventArgs e) 
        {
            SqlParameter p = new SqlParameter("@pack_id", System.Data.SqlDbType.Int);
            p.Value = (int)currentPack;            
            SqlCommand cmd2 = new SqlCommand();
            cmd2.Connection = Model.GlobalParameters.sqlConn;
            
            cmd2.CommandText = sp["send_date"].ToString()==""? "SELECT occ_id, SUM(value) as value from stack.kassa_payments where pack_id = @pack_id GROUP BY occ_id order by value desc":"SELECT occ_id, SUM(value) as value from stack.kassa_history where pack_id = @pack_id GROUP BY occ_id  order by value desc ";
            cmd2.Parameters.Add(p);
            SqlDataAdapter db = new SqlDataAdapter(cmd2);
            db.Fill(occPayments);
            cmd2.CommandText = sp["send_date"].ToString() == "" ? "SELECT occ_id, value from stack.kassa_payments where pack_id = @pack_id and value<0 ORDER BY occ_id": "SELECT occ_id, value from stack.kassa_history where pack_id = @pack_id and value<0 ORDER BY occ_id";
            db.Fill(negativePayments);
            if (negativePayments.Rows.Count > 0)
            {
                negPanel.Visibility = Visibility.Visible;
                tbNegExists.Text = "Есть";
                tbNegExists.Foreground = new SolidColorBrush(Colors.Red);
            }
            else
            {
                negPanel.Visibility = Visibility.Collapsed;
                tbNegExists.Text = "Нет";
                tbNegExists.Foreground = new SolidColorBrush(Colors.Green);
            }
            tbPaymentsQuantity.Text = Model.GlobalParameters.worklistDataset.Tables["PaymentsList"].Rows.Count.ToString();
            tbOccQuantity.Text = occPayments.Rows.Count.ToString();


            if ((savedPacks.ContainsKey(currentPack)) || (sp.Row["send_date"].ToString() != "")) // Скрываем чекбоксы
            {
             Model.Utility.HideCheckboxes(PaymentsGrid, "InnerGrid");
            }

        }

        private void CheckBox_Checked_1(object sender, RoutedEventArgs e) // Галочка "Исключить"
        {

            Model.Payment currentPayment = ((CheckBox)sender).DataContext as Model.Payment;
            if (currentPayment.OldValue == 0) { currentPayment.OldValue = currentPayment.Value; }
         
                        
            currentPayment.Correction = -currentPayment.OldValue;
            currentPayment.Parent.HowManyRecordsChecked += 1;

        }

        private void CheckBox_Unchecked(object sender, RoutedEventArgs e)
        {
            Model.Payment currentPayment = ((CheckBox)sender).DataContext as Model.Payment;

           
            currentPayment.Correction = 0;
            currentPayment.Value = currentPayment.OldValue;
            currentPayment.Parent.HowManyRecordsChecked -= 1;

        }
    }
}
