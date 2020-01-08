using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using System.ComponentModel;
using System.Windows.Threading;

namespace simple_file_search
{
    public class State : INotifyPropertyChanged
    {
        private int _totalFiles;
        private int _totalFolders;
        private int _filesDone;
        private string _currentFile;
        private bool _isPauseEnabled;
        private bool _isStartEnabled;
        private bool _isStopEnabled;
        private bool _isOpenFolderEnabled;
        private int _timeElapsed;
        private int _matchesFound;
        private Progress _progress;

        public State()
        {
            IsStartEnabled = true;
            IsPauseEnabled = false;
            IsStopEnabled = false;
            IsOpenFolderEnabled = true;
            ProgressState = Progress.Stopped;
        }

        public void SetDefault(Dispatcher dispatcher)
        {
            dispatcher.Invoke(() => FilesDone = 0);
            dispatcher.Invoke(() => TotalFiles = 0 );
            dispatcher.Invoke(() => TotalFolders = 0);
            dispatcher.Invoke(() => CurrentFile = "");
            dispatcher.Invoke(() => IsPauseEnabled = false);
            dispatcher.Invoke(() => IsStartEnabled = true);
            dispatcher.Invoke(() => IsOpenFolderEnabled = true);
            dispatcher.Invoke(() => IsStopEnabled = false);
            dispatcher.Invoke(() => TimeElapsed = 0);
            dispatcher.Invoke(() => MatchesFound = 0);
            dispatcher.Invoke(() => ProgressState = Progress.Stopped);
        }
        public Progress ProgressState
        {
            get => _progress;
            set
            {
                _progress = value;
                OnPropertyChanged("ProgressState");
            }

        }
        public int MatchesFound
        {
            get => _matchesFound;

            set
            {
                _matchesFound = value;
                OnPropertyChanged("MatchesFound");
            }
        }
        public int TotalFolders
        {
            get => _totalFolders;

            set
            {
                _totalFolders = value;
                OnPropertyChanged("TotalFolders");
            }

        }
        public int TotalFiles
        {
            get => _totalFiles;

            set
            {
                _totalFiles = value;
                OnPropertyChanged("TotalFiles");
            }

        }

        public int TimeElapsed
        {
            get => _timeElapsed;

            set
            {
                _timeElapsed = value;
                OnPropertyChanged("TimeElapsed");
            }

        }

        public int FilesDone
        {
            get => _filesDone;

            set
            {
                _filesDone = value;
                OnPropertyChanged("FilesDone");
            }

        }

        public string CurrentFile
        {
            get => _currentFile;

            set
            {
                _currentFile = value;
                OnPropertyChanged("CurrentFile");
            }

        }

        public bool IsPauseEnabled
        {
            get => _isPauseEnabled;

            set
            {
                _isPauseEnabled = value;
                OnPropertyChanged("IsPauseEnabled");
            }

        }

        public bool IsStartEnabled
        {
            get => _isStartEnabled;

            set
            {
                _isStartEnabled = value;
                OnPropertyChanged("IsStartEnabled");
            }

        }
        public bool IsStopEnabled
        {
            get => _isStopEnabled;

            set
            {
                _isStopEnabled = value;
                OnPropertyChanged("IsStopEnabled");
            }

        }

        public bool IsOpenFolderEnabled
        {
            get => _isOpenFolderEnabled;

            set
            {
                _isOpenFolderEnabled = value;
                OnPropertyChanged("IsOpenFolderEnabled");
            }

        }

        protected void OnPropertyChanged(string prop = "")
        {
            PropertyChanged?.Invoke(this, new PropertyChangedEventArgs(prop));
        }
       
        public event PropertyChangedEventHandler PropertyChanged;


    }
}
