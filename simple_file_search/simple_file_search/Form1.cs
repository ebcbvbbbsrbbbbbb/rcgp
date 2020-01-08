using System;
using System.Collections.Generic;
using System.ComponentModel;
using System.Collections.ObjectModel;
using System.Data;
using System.Drawing;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using System.Windows.Forms;
using System.IO;
using System.Windows.Threading;
using System.Text.RegularExpressions;
using System.Threading;



namespace simple_file_search
{
    public partial class Form1 : Form
    {
        public Settings CurrentSettings { get; set; }
        public State CurrentState { get; set; }
        public CancellationTokenSource Cts { get; set; }
        public CancellationToken Token { get; set; }
        private readonly Dispatcher mainDispatcher;        
        private ManualResetEvent mrEvent;
        private System.Windows.Forms.Timer timer; 
        private Task t;
        public void AddTime(object sender, EventArgs e)
        {           
                 mainDispatcher.Invoke(() => CurrentState.TimeElapsed += 1);           
        }
        public Form1()
        {
            InitializeComponent();
            Cts = new CancellationTokenSource();
            CurrentSettings = new Settings().InitSettings();
            CurrentState = new State();
            tbFileContent.DataBindings.Add(new Binding("Text", CurrentSettings, "SearchText"));
            tbFileName.DataBindings.Add(new Binding("Text", CurrentSettings, "FileName"));
            tbFilePath.DataBindings.Add(new Binding("Text", CurrentSettings, "StartFolder"));
            cbIsContentRegex.DataBindings.Add(new Binding("Checked", CurrentSettings, "IsSearchTextRegExp"));
            cbIsFileRegex.DataBindings.Add(new Binding("Checked", CurrentSettings, "IsFileNameRegExp"));
            lblStatus.DataBindings.Add(new Binding("Text", CurrentState, "CurrentFile"));
            lblFilesDone.DataBindings.Add(new Binding("Text", CurrentState, "FilesDone"));
            lblTotalFolders.DataBindings.Add(new Binding("Text", CurrentState, "TotalFolders"));
            lblTotalFiles.DataBindings.Add(new Binding("Text", CurrentState, "TotalFiles"));
            lblMatchesFound.DataBindings.Add(new Binding("Text", CurrentState, "MatchesFound"));
            btnOpenFolder.DataBindings.Add(new Binding("Enabled", CurrentState, "IsOpenFolderEnabled"));
            btnPause.DataBindings.Add(new Binding("Enabled", CurrentState, "IsPauseEnabled"));
            btnStart.DataBindings.Add(new Binding("Enabled", CurrentState, "IsStartEnabled"));
            btnStop.DataBindings.Add(new Binding("Enabled", CurrentState, "IsStopEnabled"));
            progressBar1.DataBindings.Add(new Binding("Value", CurrentState, "FilesDone"));
            progressBar1.DataBindings.Add(new Binding("Maximum", CurrentState, "TotalFiles"));
            lblTimeElapsed.DataBindings.Add(new Binding("Text", CurrentState, "TimeElapsed"));                                          
            mainDispatcher = Dispatcher.CurrentDispatcher;
            tvFilesFound.PathSeparator="/";
            mrEvent = new ManualResetEvent(true);   
        }
        private void BtnStart_Click(object sender, EventArgs e)
        {
            if (CurrentState.ProgressState == Progress.Stopped)
            {
                if (CurrentSettings.CheckSettings(CurrentSettings).Count() > 0)
                {
                    MessageBox.Show(string.Join("\r\n", CurrentSettings.ErrorLog));
                    return;
                }
                else
                {
                    timer = new System.Windows.Forms.Timer { Interval = 1000 };
                    timer.Tick += AddTime;
                    Cts = new CancellationTokenSource();
                    Token = Cts.Token;

                    timer.Start();
                    t = new Task(() => {
                        CurrentState.SetDefault(mainDispatcher);
                        mainDispatcher.Invoke(() => CurrentState.IsStartEnabled = false);
                        mainDispatcher.Invoke(() => CurrentState.IsStopEnabled = true);
                        mainDispatcher.Invoke(() => CurrentState.IsPauseEnabled = true);
                        mainDispatcher.Invoke(() => CurrentState.IsOpenFolderEnabled = false);
                        mainDispatcher.Invoke(() => CurrentState.ProgressState= Progress.InProgress);
                        mainDispatcher.Invoke(() => tvFilesFound.Nodes.Clear());
                        Utility.FileSearch(CurrentSettings, CurrentState, tvFilesFound, mainDispatcher, mrEvent, Token);                        
                        Task.Factory.StartNew(() => 
                        {
                            if (Cts.IsCancellationRequested == false) 
                            {
                                mainDispatcher.Invoke(()=> CurrentState.IsStartEnabled = true);
                                mainDispatcher.Invoke(() => CurrentState.IsStopEnabled = false);
                                mainDispatcher.Invoke(() => CurrentState.IsPauseEnabled = false);
                                mainDispatcher.Invoke(() => CurrentState.IsOpenFolderEnabled = true);
                                mainDispatcher.Invoke(() => CurrentState.ProgressState = Progress.Stopped);
                                timer.Stop();
                                timer.Dispose();
                            }
                        },TaskCreationOptions.AttachedToParent);
                    });                    
                    t.Start();
                }
            }
            else
            {
                mrEvent.Set();               
                timer.Start();
                CurrentState.IsPauseEnabled = true;
                CurrentState.IsStartEnabled = false;
                CurrentState.IsStopEnabled = true;
                CurrentState.IsOpenFolderEnabled = false;            
            }
            mrEvent.Set();
            CurrentState.ProgressState = Progress.InProgress;
        }
        private void Form1_FormClosing(object sender, FormClosingEventArgs e)
        {
            CurrentSettings.SaveSettings();
        }
        private void BtnOpenFolder_Click(object sender, EventArgs e)
        {
            FolderBrowserDialog fd = new FolderBrowserDialog();
            if (fd.ShowDialog() == DialogResult.OK)
            {
                CurrentSettings.StartFolder = fd.SelectedPath;
            }
            fd.Dispose();
        }
        private void BtnPause_Click(object sender, EventArgs e)
        {
            mrEvent.Reset();         
            timer.Stop();
            CurrentState.IsPauseEnabled = false;
            CurrentState.IsStartEnabled = true;
            CurrentState.IsStopEnabled = true;
            CurrentState.IsOpenFolderEnabled = false;
            CurrentState.ProgressState = Progress.Paused;
        }

        private void BtnStop_Click(object sender, EventArgs e)
        {
            mrEvent.Set(); // Если останавливаем с паузы
            Cts.Cancel();
            timer.Stop();
            CurrentState.IsPauseEnabled = false;
            CurrentState.IsStartEnabled = true;
            CurrentState.IsStopEnabled = false;
            CurrentState.IsOpenFolderEnabled = true;
            if (t.Status == TaskStatus.Running)
            {
                Task t2 = t.ContinueWith((t) => CurrentState.SetDefault(mainDispatcher));
            }
            else 
            { 
                CurrentState.SetDefault(mainDispatcher);
                tvFilesFound.Nodes.Clear();
            }
            mrEvent.Reset();          
            timer.Dispose();
        }

    }
}
