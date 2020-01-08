using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using System.IO;
using System.Windows.Forms;
using System.Threading;
using System.Windows.Threading;
using System.Text.RegularExpressions;

namespace simple_file_search
{
    public static class Utility
    {
        public static bool IsTextBased(string filePath, ManualResetEvent mrEvent, CancellationToken token) 
        {
            int currentChar;
            using (StreamReader sr = new StreamReader(filePath))
            {
                while ((currentChar = sr.Read()) != -1)
                {
                    if (token.IsCancellationRequested)
                    {
                        break;
                    }
                    mrEvent.WaitOne(Timeout.Infinite);
                    if (currentChar > 0 && currentChar < 8 || currentChar > 13 && currentChar < 26)
                    return false;
                }
                return true;
            }
        }       
        public static void FileSearch(Settings CurrentSettings, State currentState, TreeView tv, Dispatcher d, ManualResetEvent mrEvent, CancellationToken token)
        {            
            List<string> fileList;
            List<string> GetDirList(string rootFolder)
            {
                List<string> result = new List<string>();
                List<string> rootFolders = new List<string>();
                rootFolders.AddRange(Directory.GetDirectories(rootFolder, "*.*", SearchOption.TopDirectoryOnly).ToList());
                void MakeDirList(string currentFolder)
                {
                    try 
                    {
                        List<string> temp = Directory.GetDirectories(currentFolder, "*.*", SearchOption.TopDirectoryOnly).ToList();
                      
                        foreach (string folder in temp)                            
                        {
                            if (token.IsCancellationRequested)
                            {
                                break;
                            }
                            mrEvent.WaitOne(Timeout.Infinite);
                            try
                            {                                
                                if (Directory.GetDirectories(folder, "*.*", SearchOption.TopDirectoryOnly).Count() == 0)
                                { 
                                    result.Add(folder);
                                    d.Invoke(() => currentState.TotalFolders += 1);
                                }
                                else 
                                {
                                    if (!result.Contains(folder))
                                    {
                                        result.Add(folder);
                                        d.Invoke(() => currentState.TotalFolders += 1);
                                    }
                                    currentFolder = folder;
                                    MakeDirList(currentFolder);
                                }
                            }
                            catch { continue; }
                        }
                    }
                    catch { };
                }
                foreach (string s in rootFolders)
                {
                    try
                    {
                        MakeDirList(s);
                        result.Add(s);
                        d.Invoke(() => currentState.TotalFolders += 1);
                    }
                    catch { continue; }
                }
                result.Add(rootFolder);
                result.Sort();
                return result;
            }
            List<string> GetFiles(string root, string mask, bool isMaskRegexp)
            {                
                List<string> filestList = new List<string>();
                List<string> dirList = GetDirList(root);
                
                switch (isMaskRegexp)
                {
                    case true:
                        Regex regEx = new Regex(CurrentSettings.FileName);
                        foreach (string folder in dirList)
                        {
                            if (token.IsCancellationRequested)
                            {
                                break;
                            }
                          mrEvent.WaitOne(Timeout.Infinite);
                          try
                            {
                                var temp = Directory.GetFiles(folder, "*.*", SearchOption.TopDirectoryOnly);
                                foreach (string s in temp)
                                {
                                    if (token.IsCancellationRequested)
                                    {
                                        break;
                                    }
                                     mrEvent.WaitOne(Timeout.Infinite);
                                    if (regEx.Match(s.Split('\\').Last()).Success)
                                    {
                                       filestList.Add(s);
                                    }
                                }
                            }
                            catch { continue; }
                        }
                        break;

                    case false:
                        foreach (string folder in dirList)
                        {
                            if (token.IsCancellationRequested)
                            {
                                break;
                            }
                            mrEvent.WaitOne(Timeout.Infinite);
                            try
                            {
                                filestList.AddRange(Directory.GetFiles(folder, mask, SearchOption.TopDirectoryOnly));
                            }
                            catch { continue; }
                        }
                        break;
                }
                return filestList;
            }
            bool CheckFileContent(bool isRegExp, string searchText, string _fileName)
            {
                using (StreamReader sr = new StreamReader(_fileName))
                {
                    string currentString;
                    bool result = false;
                    switch (isRegExp)
                    {
                        case true:
                            Regex regEx = new Regex(searchText);
                            while ((currentString = sr.ReadLine()) != null)
                            {
                                if (token.IsCancellationRequested)
                                {
                                    break;
                                }
                                mrEvent.WaitOne(Timeout.Infinite);
                                if (regEx.IsMatch(currentString)) result = true;
                                break;
                            }
                            break;
                        case false:

                            while ((currentString = sr.ReadLine()) != null)
                            {
                                if (token.IsCancellationRequested)
                                {
                                    break;
                                }
                                mrEvent.WaitOne(Timeout.Infinite);
                                if (currentString.Contains(searchText)) result = true;
                                break;
                            }
                            break;
                    }
                    return result; 
                }
            }
            void AddNode(string filepath)
            {
               
                string[] pathParts = filepath.Split('\\');
                var currentNode = tv.Nodes;
                int i = 0;
                void recursionAddNode()
                {
                    while (i < pathParts.Count())
                    {

                        if (currentNode.IndexOfKey(pathParts[i]) == -1)
                        {
                            currentNode.Add(pathParts[i], pathParts[i]);
                            var p = currentNode.IndexOfKey(pathParts[i]);
                            currentNode = currentNode[p].Nodes;
                            i++;
                        }
                        else
                        {
                            var p = currentNode.IndexOfKey(pathParts[i]);
                            currentNode = currentNode[p].Nodes;
                            i++;
                            recursionAddNode();
                        }
                    }
                }
                recursionAddNode(); 
                
            }
            fileList = GetFiles(CurrentSettings.StartFolder, CurrentSettings.FileName, CurrentSettings.IsFileNameRegExp);
            if (fileList.Count > 0)
            {
                int i = 0;
                d.Invoke(() => currentState.TotalFiles = fileList.Count);
                foreach (string s in fileList)
                {
                    if (token.IsCancellationRequested)
                    {
                        d.Invoke(() => tv.Nodes.Clear());
                        break;
                    }
                    mrEvent.WaitOne(Timeout.Infinite);
                    d.Invoke(() => currentState.FilesDone = ++i);
                    d.Invoke(() => currentState.CurrentFile = s);

                    if (CurrentSettings.SearchText != "")
                    {                    

                        if (IsTextBased(s, mrEvent, token) && CheckFileContent(CurrentSettings.IsSearchTextRegExp, CurrentSettings.SearchText, s))
                            {
                                d.Invoke(() => AddNode(s));
                                d.Invoke(() => currentState.MatchesFound++);
                            }
                    }
                    else
                    {
                        d.Invoke(() => currentState.MatchesFound++);
                        d.Invoke(() => AddNode(s));
                    }                    
                }
            }
            else
            {
                d.Invoke(() => currentState.CurrentFile = "По заданным критериям файлов не найдено");
            }       
        }
    }
}
