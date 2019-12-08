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
using System.Windows;
using System.Windows.Input;
using System.Windows.Data;
using System.Windows.Documents;
using System.Windows.Media;
using System.Windows.Media.Imaging;
using System.Windows.Shapes;
using System.Globalization;


namespace kassa
{
    class MainGidValueConverter : IValueConverter
    {
        public object Convert(object value, Type targetType, object parameter, CultureInfo culture)
        {
            try
            {
                if ((int)value == 0)
                {
                    return new SolidColorBrush(Colors.LightBlue);
                }
                else
                {
                    return new SolidColorBrush(Colors.OrangeRed);
                }
            }
            catch
            {
                return new SolidColorBrush(Colors.LightBlue);
            }
        }
        public object ConvertBack(object value, Type targetType, object parameter, CultureInfo culture)
        {
            throw new Exception("Невозможно применить конввертор");
        }
    }
    class ViewModel : INotifyPropertyChanged
    {
        public ViewModel(object o, DataGrid ExportGrid, ComboBox cmbInterval, StackPanel calendPanel)
        {            
            Model.GlobalParameters.packsDataset = new DataSet();
            Model.GlobalParameters.selectAllFlag = false;
            Model.GlobalParameters.worklistDataset = new DataSet();
            Model.GlobalParameters.worklistDataset.Tables.Add("Worklist");
            Model.GlobalParameters.worklistDataset.Tables.Add("ExportList");
            Model.GlobalParameters.worklistDataset.Tables.Add("PaymentsList");
            Model.GlobalParameters.worklistDataset.Tables.Add("forExport");
            Model.GlobalParameters.worklistDataset.Tables["Worklist"].Columns.Add("isCorrect", Type.GetType("System.Int32"));
            Model.GlobalParameters.worklistDataset.Tables["Worklist"].Columns.Add("isChecked", Type.GetType("System.Boolean"));
            Model.GlobalParameters.worklistDataset.Tables["Worklist"].Columns["isChecked"].DefaultValue = false;
            Model.GlobalParameters.worklistDataset.Tables["Worklist"].Columns.Add("pack_id", Type.GetType("System.Int32"));
            Model.GlobalParameters.worklistDataset.Tables["Worklist"].Columns.Add("pack_total", Type.GetType("System.Decimal"));
            Model.GlobalParameters.worklistDataset.Tables["Worklist"].Columns.Add("pack_date", Type.GetType("System.DateTime"));
            Model.GlobalParameters.worklistDataset.Tables["Worklist"].Columns.Add("docsnum", Type.GetType("System.Int32"));
            Model.GlobalParameters.worklistDataset.Tables["Worklist"].Columns.Add("send_date", Type.GetType("System.DateTime"));
            Model.GlobalParameters.worklistDataset.Tables["Worklist"].Columns.Add("source", Type.GetType("System.String"));
            Model.GlobalParameters.worklistDataset.Tables["Worklist"].Columns.Add("vipiska", Type.GetType("System.String"));
            Model.GlobalParameters.worklistDataset.Tables["Worklist"].Constraints.Add("worklist_pk_packid", Model.GlobalParameters.worklistDataset.Tables["Worklist"].Columns["pack_id"], true);
            Model.GlobalParameters.worklistDataset.Tables["ExportList"].Columns.Add("isCorrect", Type.GetType("System.Int32"));
            Model.GlobalParameters.worklistDataset.Tables["ExportList"].Columns.Add("isChecked", Type.GetType("System.Boolean"));
            Model.GlobalParameters.worklistDataset.Tables["ExportList"].Columns["isChecked"].DefaultValue = false;
            Model.GlobalParameters.worklistDataset.Tables["ExportList"].Columns.Add("pack_id", Type.GetType("System.Int32"));
            Model.GlobalParameters.worklistDataset.Tables["ExportList"].Columns.Add("pack_total", Type.GetType("System.Decimal"));
            Model.GlobalParameters.worklistDataset.Tables["ExportList"].Columns.Add("pack_date", Type.GetType("System.DateTime"));
            Model.GlobalParameters.worklistDataset.Tables["ExportList"].Columns.Add("docsnum", Type.GetType("System.Int32"));
            Model.GlobalParameters.worklistDataset.Tables["ExportList"].Columns.Add("send_date", Type.GetType("System.DateTime"));
            Model.GlobalParameters.worklistDataset.Tables["ExportList"].Columns.Add("source", Type.GetType("System.String"));
            Model.GlobalParameters.worklistDataset.Tables["ExportList"].Columns.Add("vipiska", Type.GetType("System.String"));
            Model.GlobalParameters.worklistDataset.Tables["ExportList"].Constraints.Add("exportlist_pk_packid", Model.GlobalParameters.worklistDataset.Tables["ExportList"].Columns["pack_id"], true);
            Model.GlobalParameters.worklistDataset.Tables["PaymentsList"].Columns.Add("isCorrect", Type.GetType("System.Int32"));
            Model.GlobalParameters.worklistDataset.Tables["PaymentsList"].Columns.Add("pack_id", Type.GetType("System.Int32"));
            Model.GlobalParameters.worklistDataset.Tables["PaymentsList"].Columns.Add("occ_id", Type.GetType("System.Int32"));
            Model.GlobalParameters.worklistDataset.Tables["PaymentsList"].Columns.Add("email", Type.GetType("System.String"));
            Model.GlobalParameters.worklistDataset.Tables["PaymentsList"].Columns.Add("paying_id", Type.GetType("System.Int32"));
            Model.GlobalParameters.worklistDataset.Tables["PaymentsList"].Columns.Add("paying_date", Type.GetType("System.DateTime"));
            Model.GlobalParameters.worklistDataset.Tables["PaymentsList"].Columns.Add("source", Type.GetType("System.String"));
            Model.GlobalParameters.worklistDataset.Tables["PaymentsList"].Columns.Add("service_name", Type.GetType("System.String"));
            Model.GlobalParameters.worklistDataset.Tables["PaymentsList"].Columns.Add("isp_name", Type.GetType("System.String"));
            Model.GlobalParameters.worklistDataset.Tables["PaymentsList"].Columns.Add("value", Type.GetType("System.Decimal"));
            Model.GlobalParameters.worklistDataset.Tables["PaymentsList"].Columns.Add("isp_inn", Type.GetType("System.String"));
            Model.GlobalParameters.worklistDataset.Tables["PaymentsList"].Columns.Add("isChecked", Type.GetType("System.Boolean")).DefaultValue = false;
            Model.GlobalParameters.worklistDataset.Tables["forExport"].Columns.Add("vipiska_id", Type.GetType("System.Int32"));
            Model.GlobalParameters.worklistDataset.Tables["forExport"].Columns.Add("vipiska_date", Type.GetType("System.DateTime"));
            Model.GlobalParameters.worklistDataset.Tables["forExport"].Columns.Add("pack_id", Type.GetType("System.Int32"));
            Model.GlobalParameters.worklistDataset.Tables["forExport"].Columns.Add("pack_date", Type.GetType("System.DateTime"));
            Model.GlobalParameters.worklistDataset.Tables["forExport"].Columns.Add("pack_total", Type.GetType("System.Decimal"));
            Model.GlobalParameters.worklistDataset.Tables["forExport"].Columns.Add("docsnum", Type.GetType("System.Int32"));
            Model.GlobalParameters.worklistDataset.Tables["forExport"].Columns.Add("source", Type.GetType("System.String"));
            Model.GlobalParameters.worklistDataset.Tables["forExport"].Columns.Add("occ_id", Type.GetType("System.Int32"));
            Model.GlobalParameters.worklistDataset.Tables["forExport"].Columns.Add("email", Type.GetType("System.String"));
            Model.GlobalParameters.worklistDataset.Tables["forExport"].Columns.Add("paying_id", Type.GetType("System.Int32"));
            Model.GlobalParameters.worklistDataset.Tables["forExport"].Columns.Add("service_name", Type.GetType("System.String"));
            Model.GlobalParameters.worklistDataset.Tables["forExport"].Columns.Add("value", Type.GetType("System.Decimal"));
            Model.GlobalParameters.worklistDataset.Tables["forExport"].Columns.Add("paying_date", Type.GetType("System.DateTime"));
            Model.GlobalParameters.worklistDataset.Tables["forExport"].Columns.Add("isp_id", Type.GetType("System.Int32"));
            Model.GlobalParameters.worklistDataset.Tables["forExport"].Columns.Add("isp_name", Type.GetType("System.String"));
            Model.GlobalParameters.worklistDataset.Tables["forExport"].Columns.Add("isp_inn", Type.GetType("System.String"));
            Model.GlobalParameters.worklistDataset.Tables["forExport"].Columns.Add("isSent", Type.GetType("System.Int32")).DefaultValue = 0;
            Model.WindowElements.cmbRecordType = cmbInterval;
            Model.WindowElements.calendPanel = calendPanel;
            Model.WindowElements.workListDataGrid = (DataGrid)o;
            Model.WindowElements.exportListDataGrid = ExportGrid;
            Model.GlobalParameters.cmbDictionary = new Dictionary<string, string>();
            Model.GlobalParameters.cmbDictionary.Add("1", "	SELECT DISTINCT 0 as isCorrect, kh.pack_id, kh.pack_total, kh.pack_date, kh.docsnum, kh.source, keh.export_date as send_date,   'От ' + cast(kh.vipiska_date as varchar) + ' (' + cast(kh.vipiska_id as varchar) + ')' as vipiska FROM stack.kassa_history kh inner join stack.kassa_export_history keh on keh.pack_id = kh.pack_id where kh.pack_date between cast(@dateFrom as date)  and cast(@dateTo as date)");
            Model.GlobalParameters.cmbDictionary.Add("2", "SELECT is_correct as isCorrect, pack_id, pack_total,  pack_date, docsnum, source, last_send as send_date, 'От '+ cast(vipiska_date as varchar)+' ('+cast(vipiska_id as varchar)+')'  as vipiska FROM stack.kassa_packs order by isCorrect desc"); // Еще не выгруженные записи

            Model.WindowElements.workListDataGrid.ItemsSource = Model.GlobalParameters.worklistDataset.Tables["Worklist"].DefaultView;
            Model.WindowElements.exportListDataGrid.ItemsSource = Model.GlobalParameters.worklistDataset.Tables["ExportList"].DefaultView;
            Model.GlobalParameters.savedPackId = new List<int>();            
        }
        public event PropertyChangedEventHandler PropertyChanged;
        void OnPropertyChanged(string prop) 
        {
            if (PropertyChanged != null) 
            {
                PropertyChanged(this,new PropertyChangedEventArgs(prop));
                
            }
        }     

    }
    
}

