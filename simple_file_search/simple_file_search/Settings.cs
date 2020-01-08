using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using System.ComponentModel;
using System.IO;
using System.Runtime.Serialization.Formatters.Binary;
using System.Text.RegularExpressions;

namespace simple_file_search
{
    [Serializable]
    public class Settings:INotifyPropertyChanged
    {
        private string _filename;
        private string _searchtext;
        private string _startfolder;
        private bool _isfilenameregexp;
        private bool _issearchtextregexp;
        private List<string> _errorLog;

        public List<string> ErrorLog 
        {
            get => _errorLog;
            set 
            {
                _errorLog = value;
                OnPropertyChanged("ErrorLog");
            }
        }


        public List<string> CheckSettings(Settings settings) 
        {
            ErrorLog.Clear();

            if (settings.StartFolder == "")
            {
                ErrorLog.Add("Не указана папка");
            }
            else
            {
                try
                {
                    Directory.GetDirectories(settings.StartFolder);
                }
                catch
                {
                    ErrorLog.Add("Нет доступа к указанной папке");
                }
            }

            if (settings.IsFileNameRegExp)
            {
                try { Regex regEx = new Regex(settings.FileName); }
                catch
                {
                    ErrorLog.Add("Неправильно составлено регулярное выражение для имени файла");
                }
            }
            if (settings.IsSearchTextRegExp)
            {
                try { Regex regEx = new Regex(settings.SearchText); }
                catch
                {
                    ErrorLog.Add("Неправильно составлено регулярное выражение для поиска внутри файла");

                }
            }
            return settings.ErrorLog;

        }
        public string FileName
        {
            get => _filename;

            set
            {
                _filename = value;
                OnPropertyChanged("FileName");
            }
            
        }

        public string SearchText
        {
            get => _searchtext;

            set
            {
                _searchtext = value;
                OnPropertyChanged("SearchText");
            }

        }

        public string StartFolder
        {
            get => _startfolder;

            set
            {
                _startfolder = value;
                OnPropertyChanged("StartFolder");
            }

        }

        public bool IsFileNameRegExp
        {
            get => _isfilenameregexp;

            set
            {
                _isfilenameregexp = value;
                OnPropertyChanged("IsFileNameRegExp");
            }

        }

        public bool IsSearchTextRegExp
        {
            get => _issearchtextregexp;

            set
            {
                _issearchtextregexp = value;
                OnPropertyChanged("IsSearchTextRegExp");
            }

        }
      
        protected void OnPropertyChanged(string prop = "")
        {
            PropertyChanged?.Invoke(this, new PropertyChangedEventArgs(prop));
        }
        [field:NonSerializedAttribute()] 
        public event PropertyChangedEventHandler PropertyChanged;

        public Settings InitSettings() 
        {
            Settings currentSettings;
            FileStream fs = new FileStream($"{Environment.CurrentDirectory}/settings.bin", FileMode.OpenOrCreate);
            BinaryFormatter bf = new BinaryFormatter();
            try
            {
                currentSettings = (Settings)bf.Deserialize(fs);
            }
            catch
            {
                currentSettings = new Settings();
            }
            fs.Close();
            return currentSettings;
        }
        public void SaveSettings() 
        {
            string path = Environment.CurrentDirectory;
            BinaryFormatter bf = new BinaryFormatter();
            FileStream fs = new FileStream($"{path}/settings.bin", FileMode.OpenOrCreate);
            bf.Serialize(fs, this);
            fs.Close();
        }

        public Settings() 
        {
            ErrorLog = new List<string>();
            StartFolder = "";
            SearchText = "";
            FileName = "";
            IsFileNameRegExp = false;
            IsSearchTextRegExp = false;
        }
    }


}
