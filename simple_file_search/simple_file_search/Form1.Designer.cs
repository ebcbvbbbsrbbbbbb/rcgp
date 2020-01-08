namespace simple_file_search
{
    partial class Form1
    {
        /// <summary>
        /// Обязательная переменная конструктора.
        /// </summary>
        private System.ComponentModel.IContainer components = null;

        /// <summary>
        /// Освободить все используемые ресурсы.
        /// </summary>
        /// <param name="disposing">истинно, если управляемый ресурс должен быть удален; иначе ложно.</param>
        protected override void Dispose(bool disposing)
        {
            if (disposing && (components != null))
            {
                components.Dispose();
            }
            base.Dispose(disposing);
        }

        #region Код, автоматически созданный конструктором форм Windows

        /// <summary>
        /// Требуемый метод для поддержки конструктора — не изменяйте 
        /// содержимое этого метода с помощью редактора кода.
        /// </summary>
        private void InitializeComponent()
        {
            this.components = new System.ComponentModel.Container();
            this.tvFilesFound = new System.Windows.Forms.TreeView();
            this.panel1 = new System.Windows.Forms.Panel();
            this.panel4 = new System.Windows.Forms.Panel();
            this.btnOpenFolder = new System.Windows.Forms.Button();
            this.tbFilePath = new System.Windows.Forms.TextBox();
            this.label3 = new System.Windows.Forms.Label();
            this.panel3 = new System.Windows.Forms.Panel();
            this.tbFileContent = new System.Windows.Forms.TextBox();
            this.label2 = new System.Windows.Forms.Label();
            this.cbIsContentRegex = new System.Windows.Forms.CheckBox();
            this.panel2 = new System.Windows.Forms.Panel();
            this.tbFileName = new System.Windows.Forms.TextBox();
            this.label1 = new System.Windows.Forms.Label();
            this.cbIsFileRegex = new System.Windows.Forms.CheckBox();
            this.btnPause = new System.Windows.Forms.Button();
            this.btnStop = new System.Windows.Forms.Button();
            this.btnStart = new System.Windows.Forms.Button();
            this.panel6 = new System.Windows.Forms.Panel();
            this.panel7 = new System.Windows.Forms.Panel();
            this.panel8 = new System.Windows.Forms.Panel();
            this.panel5 = new System.Windows.Forms.Panel();
            this.label5 = new System.Windows.Forms.Label();
            this.progressBar1 = new System.Windows.Forms.ProgressBar();
            this.panel15 = new System.Windows.Forms.Panel();
            this.label10 = new System.Windows.Forms.Label();
            this.panel17 = new System.Windows.Forms.Panel();
            this.lblTotalFiles = new System.Windows.Forms.Label();
            this.label7 = new System.Windows.Forms.Label();
            this.panel13 = new System.Windows.Forms.Panel();
            this.label8 = new System.Windows.Forms.Label();
            this.panel16 = new System.Windows.Forms.Panel();
            this.lblTimeElapsed = new System.Windows.Forms.Label();
            this.panel11 = new System.Windows.Forms.Panel();
            this.label6 = new System.Windows.Forms.Label();
            this.panel14 = new System.Windows.Forms.Panel();
            this.lblMatchesFound = new System.Windows.Forms.Label();
            this.panel10 = new System.Windows.Forms.Panel();
            this.label4 = new System.Windows.Forms.Label();
            this.panel12 = new System.Windows.Forms.Panel();
            this.lblFilesDone = new System.Windows.Forms.Label();
            this.panel9 = new System.Windows.Forms.Panel();
            this.lblTotalFolders = new System.Windows.Forms.Label();
            this.lblStatus = new System.Windows.Forms.Label();
            this.toolTip1 = new System.Windows.Forms.ToolTip(this.components);
            this.toolTip2 = new System.Windows.Forms.ToolTip(this.components);
            this.toolTip3 = new System.Windows.Forms.ToolTip(this.components);
            this.toolTip4 = new System.Windows.Forms.ToolTip(this.components);
            this.panel1.SuspendLayout();
            this.panel4.SuspendLayout();
            this.panel3.SuspendLayout();
            this.panel2.SuspendLayout();
            this.panel6.SuspendLayout();
            this.panel7.SuspendLayout();
            this.panel8.SuspendLayout();
            this.panel5.SuspendLayout();
            this.panel15.SuspendLayout();
            this.panel17.SuspendLayout();
            this.panel13.SuspendLayout();
            this.panel16.SuspendLayout();
            this.panel11.SuspendLayout();
            this.panel14.SuspendLayout();
            this.panel10.SuspendLayout();
            this.panel12.SuspendLayout();
            this.panel9.SuspendLayout();
            this.SuspendLayout();
            // 
            // tvFilesFound
            // 
            this.tvFilesFound.Anchor = ((System.Windows.Forms.AnchorStyles)(((System.Windows.Forms.AnchorStyles.Top | System.Windows.Forms.AnchorStyles.Bottom) 
            | System.Windows.Forms.AnchorStyles.Left)));
            this.tvFilesFound.Location = new System.Drawing.Point(12, 12);
            this.tvFilesFound.Name = "tvFilesFound";
            this.tvFilesFound.Size = new System.Drawing.Size(403, 406);
            this.tvFilesFound.TabIndex = 0;
            // 
            // panel1
            // 
            this.panel1.Controls.Add(this.panel4);
            this.panel1.Controls.Add(this.panel3);
            this.panel1.Controls.Add(this.panel2);
            this.panel1.Location = new System.Drawing.Point(421, 12);
            this.panel1.Name = "panel1";
            this.panel1.Size = new System.Drawing.Size(336, 118);
            this.panel1.TabIndex = 7;
            // 
            // panel4
            // 
            this.panel4.Controls.Add(this.btnOpenFolder);
            this.panel4.Controls.Add(this.tbFilePath);
            this.panel4.Controls.Add(this.label3);
            this.panel4.Location = new System.Drawing.Point(3, 3);
            this.panel4.Name = "panel4";
            this.panel4.Size = new System.Drawing.Size(330, 32);
            this.panel4.TabIndex = 10;
            // 
            // btnOpenFolder
            // 
            this.btnOpenFolder.Anchor = ((System.Windows.Forms.AnchorStyles)(((System.Windows.Forms.AnchorStyles.Top | System.Windows.Forms.AnchorStyles.Left) 
            | System.Windows.Forms.AnchorStyles.Right)));
            this.btnOpenFolder.AutoEllipsis = true;
            this.btnOpenFolder.Location = new System.Drawing.Point(157, 4);
            this.btnOpenFolder.Name = "btnOpenFolder";
            this.btnOpenFolder.Size = new System.Drawing.Size(170, 23);
            this.btnOpenFolder.TabIndex = 6;
            this.btnOpenFolder.Text = "Выбрать папку";
            this.btnOpenFolder.UseVisualStyleBackColor = true;
            this.btnOpenFolder.Click += new System.EventHandler(this.BtnOpenFolder_Click);
            // 
            // tbFilePath
            // 
            this.tbFilePath.Enabled = false;
            this.tbFilePath.Location = new System.Drawing.Point(3, 3);
            this.tbFilePath.Name = "tbFilePath";
            this.tbFilePath.Size = new System.Drawing.Size(100, 20);
            this.tbFilePath.TabIndex = 4;
            // 
            // label3
            // 
            this.label3.AutoSize = true;
            this.label3.Location = new System.Drawing.Point(109, 6);
            this.label3.Name = "label3";
            this.label3.Size = new System.Drawing.Size(31, 13);
            this.label3.TabIndex = 5;
            this.label3.Text = "Путь";
            // 
            // panel3
            // 
            this.panel3.Controls.Add(this.tbFileContent);
            this.panel3.Controls.Add(this.label2);
            this.panel3.Controls.Add(this.cbIsContentRegex);
            this.panel3.Location = new System.Drawing.Point(3, 76);
            this.panel3.Name = "panel3";
            this.panel3.Size = new System.Drawing.Size(330, 32);
            this.panel3.TabIndex = 9;
            // 
            // tbFileContent
            // 
            this.tbFileContent.Location = new System.Drawing.Point(3, 3);
            this.tbFileContent.Name = "tbFileContent";
            this.tbFileContent.Size = new System.Drawing.Size(100, 20);
            this.tbFileContent.TabIndex = 4;
            this.toolTip2.SetToolTip(this.tbFileContent, "Можно искать по маске, например *.txt, или использовать регулярное выражение");
            // 
            // label2
            // 
            this.label2.AutoSize = true;
            this.label2.Location = new System.Drawing.Point(109, 6);
            this.label2.Name = "label2";
            this.label2.Size = new System.Drawing.Size(107, 13);
            this.label2.TabIndex = 5;
            this.label2.Text = "Содержимое файла";
            // 
            // cbIsContentRegex
            // 
            this.cbIsContentRegex.AutoSize = true;
            this.cbIsContentRegex.Dock = System.Windows.Forms.DockStyle.Right;
            this.cbIsContentRegex.Location = new System.Drawing.Point(272, 0);
            this.cbIsContentRegex.Name = "cbIsContentRegex";
            this.cbIsContentRegex.Size = new System.Drawing.Size(58, 32);
            this.cbIsContentRegex.TabIndex = 6;
            this.cbIsContentRegex.Text = "RegEx";
            this.toolTip3.SetToolTip(this.cbIsContentRegex, "Искать по регулярному выражению");
            this.cbIsContentRegex.UseVisualStyleBackColor = true;
            // 
            // panel2
            // 
            this.panel2.Controls.Add(this.tbFileName);
            this.panel2.Controls.Add(this.label1);
            this.panel2.Controls.Add(this.cbIsFileRegex);
            this.panel2.Location = new System.Drawing.Point(3, 41);
            this.panel2.Name = "panel2";
            this.panel2.Size = new System.Drawing.Size(330, 32);
            this.panel2.TabIndex = 8;
            // 
            // tbFileName
            // 
            this.tbFileName.Location = new System.Drawing.Point(3, 3);
            this.tbFileName.Name = "tbFileName";
            this.tbFileName.Size = new System.Drawing.Size(100, 20);
            this.tbFileName.TabIndex = 4;
            this.toolTip1.SetToolTip(this.tbFileName, "Можно искать по маске, например *.txt, или использовать регулярное выражение");
            // 
            // label1
            // 
            this.label1.AutoSize = true;
            this.label1.Location = new System.Drawing.Point(109, 6);
            this.label1.Name = "label1";
            this.label1.Size = new System.Drawing.Size(64, 13);
            this.label1.TabIndex = 5;
            this.label1.Text = "Имя файла";
            // 
            // cbIsFileRegex
            // 
            this.cbIsFileRegex.AutoSize = true;
            this.cbIsFileRegex.Dock = System.Windows.Forms.DockStyle.Right;
            this.cbIsFileRegex.Location = new System.Drawing.Point(272, 0);
            this.cbIsFileRegex.Name = "cbIsFileRegex";
            this.cbIsFileRegex.Size = new System.Drawing.Size(58, 32);
            this.cbIsFileRegex.TabIndex = 6;
            this.cbIsFileRegex.Text = "RegEx";
            this.toolTip4.SetToolTip(this.cbIsFileRegex, "Искать по регулярному выражению");
            this.cbIsFileRegex.UseVisualStyleBackColor = true;
            // 
            // btnPause
            // 
            this.btnPause.Location = new System.Drawing.Point(65, 3);
            this.btnPause.Name = "btnPause";
            this.btnPause.Size = new System.Drawing.Size(56, 29);
            this.btnPause.TabIndex = 3;
            this.btnPause.Text = "Pause";
            this.btnPause.UseVisualStyleBackColor = true;
            this.btnPause.Click += new System.EventHandler(this.BtnPause_Click);
            // 
            // btnStop
            // 
            this.btnStop.Location = new System.Drawing.Point(127, 3);
            this.btnStop.Name = "btnStop";
            this.btnStop.Size = new System.Drawing.Size(48, 29);
            this.btnStop.TabIndex = 2;
            this.btnStop.Text = "Stop";
            this.btnStop.UseVisualStyleBackColor = true;
            this.btnStop.Click += new System.EventHandler(this.BtnStop_Click);
            // 
            // btnStart
            // 
            this.btnStart.Location = new System.Drawing.Point(6, 3);
            this.btnStart.Name = "btnStart";
            this.btnStart.Size = new System.Drawing.Size(53, 29);
            this.btnStart.TabIndex = 1;
            this.btnStart.Text = "Start";
            this.btnStart.UseVisualStyleBackColor = true;
            this.btnStart.Click += new System.EventHandler(this.BtnStart_Click);
            // 
            // panel6
            // 
            this.panel6.Anchor = ((System.Windows.Forms.AnchorStyles)(((System.Windows.Forms.AnchorStyles.Top | System.Windows.Forms.AnchorStyles.Left) 
            | System.Windows.Forms.AnchorStyles.Right)));
            this.panel6.Controls.Add(this.btnStart);
            this.panel6.Controls.Add(this.btnStop);
            this.panel6.Controls.Add(this.btnPause);
            this.panel6.Location = new System.Drawing.Point(424, 136);
            this.panel6.Name = "panel6";
            this.panel6.Size = new System.Drawing.Size(332, 40);
            this.panel6.TabIndex = 11;
            // 
            // panel7
            // 
            this.panel7.Controls.Add(this.panel8);
            this.panel7.Location = new System.Drawing.Point(421, 12);
            this.panel7.Name = "panel7";
            this.panel7.Size = new System.Drawing.Size(338, 406);
            this.panel7.TabIndex = 12;
            // 
            // panel8
            // 
            this.panel8.Controls.Add(this.panel5);
            this.panel8.Controls.Add(this.progressBar1);
            this.panel8.Controls.Add(this.panel15);
            this.panel8.Controls.Add(this.panel17);
            this.panel8.Controls.Add(this.panel13);
            this.panel8.Controls.Add(this.panel16);
            this.panel8.Controls.Add(this.panel11);
            this.panel8.Controls.Add(this.panel14);
            this.panel8.Controls.Add(this.panel10);
            this.panel8.Controls.Add(this.panel12);
            this.panel8.Controls.Add(this.panel9);
            this.panel8.Location = new System.Drawing.Point(5, 168);
            this.panel8.Name = "panel8";
            this.panel8.Size = new System.Drawing.Size(330, 238);
            this.panel8.TabIndex = 10;
            // 
            // panel5
            // 
            this.panel5.BorderStyle = System.Windows.Forms.BorderStyle.FixedSingle;
            this.panel5.Controls.Add(this.label5);
            this.panel5.Location = new System.Drawing.Point(3, 38);
            this.panel5.Name = "panel5";
            this.panel5.Size = new System.Drawing.Size(161, 28);
            this.panel5.TabIndex = 6;
            // 
            // label5
            // 
            this.label5.Anchor = ((System.Windows.Forms.AnchorStyles)((System.Windows.Forms.AnchorStyles.Left | System.Windows.Forms.AnchorStyles.Right)));
            this.label5.AutoSize = true;
            this.label5.Location = new System.Drawing.Point(19, 7);
            this.label5.Name = "label5";
            this.label5.Size = new System.Drawing.Size(99, 13);
            this.label5.TabIndex = 0;
            this.label5.Text = "Файлов найдено: ";
            // 
            // progressBar1
            // 
            this.progressBar1.Dock = System.Windows.Forms.DockStyle.Bottom;
            this.progressBar1.Location = new System.Drawing.Point(0, 215);
            this.progressBar1.MarqueeAnimationSpeed = 5;
            this.progressBar1.Name = "progressBar1";
            this.progressBar1.Size = new System.Drawing.Size(330, 23);
            this.progressBar1.Step = 1;
            this.progressBar1.TabIndex = 0;
            // 
            // panel15
            // 
            this.panel15.BorderStyle = System.Windows.Forms.BorderStyle.FixedSingle;
            this.panel15.Controls.Add(this.label10);
            this.panel15.Location = new System.Drawing.Point(2, 140);
            this.panel15.Name = "panel15";
            this.panel15.Size = new System.Drawing.Size(161, 28);
            this.panel15.TabIndex = 8;
            // 
            // label10
            // 
            this.label10.Anchor = ((System.Windows.Forms.AnchorStyles)((System.Windows.Forms.AnchorStyles.Left | System.Windows.Forms.AnchorStyles.Right)));
            this.label10.AutoSize = true;
            this.label10.Location = new System.Drawing.Point(19, 7);
            this.label10.Name = "label10";
            this.label10.Size = new System.Drawing.Size(117, 13);
            this.label10.TabIndex = 0;
            this.label10.Text = "Времени прошло (c.): ";
            // 
            // panel17
            // 
            this.panel17.BorderStyle = System.Windows.Forms.BorderStyle.FixedSingle;
            this.panel17.Controls.Add(this.lblTotalFiles);
            this.panel17.Controls.Add(this.label7);
            this.panel17.Location = new System.Drawing.Point(167, 38);
            this.panel17.Name = "panel17";
            this.panel17.Size = new System.Drawing.Size(70, 28);
            this.panel17.TabIndex = 5;
            // 
            // lblTotalFiles
            // 
            this.lblTotalFiles.Anchor = ((System.Windows.Forms.AnchorStyles)((System.Windows.Forms.AnchorStyles.Left | System.Windows.Forms.AnchorStyles.Right)));
            this.lblTotalFiles.AutoSize = true;
            this.lblTotalFiles.Location = new System.Drawing.Point(11, 8);
            this.lblTotalFiles.Name = "lblTotalFiles";
            this.lblTotalFiles.Size = new System.Drawing.Size(0, 13);
            this.lblTotalFiles.TabIndex = 1;
            // 
            // label7
            // 
            this.label7.Anchor = ((System.Windows.Forms.AnchorStyles)((System.Windows.Forms.AnchorStyles.Left | System.Windows.Forms.AnchorStyles.Right)));
            this.label7.AutoSize = true;
            this.label7.Location = new System.Drawing.Point(7, 6);
            this.label7.Name = "label7";
            this.label7.Size = new System.Drawing.Size(0, 13);
            this.label7.TabIndex = 0;
            // 
            // panel13
            // 
            this.panel13.BorderStyle = System.Windows.Forms.BorderStyle.FixedSingle;
            this.panel13.Controls.Add(this.label8);
            this.panel13.Location = new System.Drawing.Point(2, 106);
            this.panel13.Name = "panel13";
            this.panel13.Size = new System.Drawing.Size(161, 28);
            this.panel13.TabIndex = 6;
            // 
            // label8
            // 
            this.label8.Anchor = ((System.Windows.Forms.AnchorStyles)((System.Windows.Forms.AnchorStyles.Left | System.Windows.Forms.AnchorStyles.Right)));
            this.label8.AutoSize = true;
            this.label8.Location = new System.Drawing.Point(19, 7);
            this.label8.Name = "label8";
            this.label8.Size = new System.Drawing.Size(120, 13);
            this.label8.TabIndex = 0;
            this.label8.Text = "Найдено совпадений: ";
            // 
            // panel16
            // 
            this.panel16.BorderStyle = System.Windows.Forms.BorderStyle.FixedSingle;
            this.panel16.Controls.Add(this.lblTimeElapsed);
            this.panel16.Location = new System.Drawing.Point(166, 140);
            this.panel16.Name = "panel16";
            this.panel16.Size = new System.Drawing.Size(71, 28);
            this.panel16.TabIndex = 7;
            // 
            // lblTimeElapsed
            // 
            this.lblTimeElapsed.Anchor = ((System.Windows.Forms.AnchorStyles)((System.Windows.Forms.AnchorStyles.Left | System.Windows.Forms.AnchorStyles.Right)));
            this.lblTimeElapsed.AutoSize = true;
            this.lblTimeElapsed.Location = new System.Drawing.Point(11, 6);
            this.lblTimeElapsed.Name = "lblTimeElapsed";
            this.lblTimeElapsed.Size = new System.Drawing.Size(0, 13);
            this.lblTimeElapsed.TabIndex = 0;
            // 
            // panel11
            // 
            this.panel11.BorderStyle = System.Windows.Forms.BorderStyle.FixedSingle;
            this.panel11.Controls.Add(this.label6);
            this.panel11.Location = new System.Drawing.Point(2, 72);
            this.panel11.Name = "panel11";
            this.panel11.Size = new System.Drawing.Size(161, 28);
            this.panel11.TabIndex = 4;
            // 
            // label6
            // 
            this.label6.Anchor = ((System.Windows.Forms.AnchorStyles)((System.Windows.Forms.AnchorStyles.Left | System.Windows.Forms.AnchorStyles.Right)));
            this.label6.AutoSize = true;
            this.label6.Location = new System.Drawing.Point(19, 7);
            this.label6.Name = "label6";
            this.label6.Size = new System.Drawing.Size(116, 13);
            this.label6.TabIndex = 0;
            this.label6.Text = "Файлов обработано: ";
            // 
            // panel14
            // 
            this.panel14.BorderStyle = System.Windows.Forms.BorderStyle.FixedSingle;
            this.panel14.Controls.Add(this.lblMatchesFound);
            this.panel14.Location = new System.Drawing.Point(166, 106);
            this.panel14.Name = "panel14";
            this.panel14.Size = new System.Drawing.Size(71, 28);
            this.panel14.TabIndex = 5;
            // 
            // lblMatchesFound
            // 
            this.lblMatchesFound.Anchor = ((System.Windows.Forms.AnchorStyles)((System.Windows.Forms.AnchorStyles.Left | System.Windows.Forms.AnchorStyles.Right)));
            this.lblMatchesFound.AutoSize = true;
            this.lblMatchesFound.Location = new System.Drawing.Point(11, 6);
            this.lblMatchesFound.Name = "lblMatchesFound";
            this.lblMatchesFound.Size = new System.Drawing.Size(0, 13);
            this.lblMatchesFound.TabIndex = 0;
            // 
            // panel10
            // 
            this.panel10.BorderStyle = System.Windows.Forms.BorderStyle.FixedSingle;
            this.panel10.Controls.Add(this.label4);
            this.panel10.Location = new System.Drawing.Point(3, 4);
            this.panel10.Name = "panel10";
            this.panel10.Size = new System.Drawing.Size(161, 28);
            this.panel10.TabIndex = 2;
            // 
            // label4
            // 
            this.label4.Anchor = ((System.Windows.Forms.AnchorStyles)((System.Windows.Forms.AnchorStyles.Left | System.Windows.Forms.AnchorStyles.Right)));
            this.label4.AutoSize = true;
            this.label4.Location = new System.Drawing.Point(19, 7);
            this.label4.Name = "label4";
            this.label4.Size = new System.Drawing.Size(90, 13);
            this.label4.TabIndex = 0;
            this.label4.Text = "Папок найдено: ";
            // 
            // panel12
            // 
            this.panel12.BorderStyle = System.Windows.Forms.BorderStyle.FixedSingle;
            this.panel12.Controls.Add(this.lblFilesDone);
            this.panel12.Location = new System.Drawing.Point(166, 72);
            this.panel12.Name = "panel12";
            this.panel12.Size = new System.Drawing.Size(71, 28);
            this.panel12.TabIndex = 3;
            // 
            // lblFilesDone
            // 
            this.lblFilesDone.Anchor = ((System.Windows.Forms.AnchorStyles)((System.Windows.Forms.AnchorStyles.Left | System.Windows.Forms.AnchorStyles.Right)));
            this.lblFilesDone.AutoSize = true;
            this.lblFilesDone.Location = new System.Drawing.Point(11, 6);
            this.lblFilesDone.Name = "lblFilesDone";
            this.lblFilesDone.Size = new System.Drawing.Size(0, 13);
            this.lblFilesDone.TabIndex = 0;
            // 
            // panel9
            // 
            this.panel9.BorderStyle = System.Windows.Forms.BorderStyle.FixedSingle;
            this.panel9.Controls.Add(this.lblTotalFolders);
            this.panel9.Location = new System.Drawing.Point(167, 4);
            this.panel9.Name = "panel9";
            this.panel9.Size = new System.Drawing.Size(70, 28);
            this.panel9.TabIndex = 1;
            // 
            // lblTotalFolders
            // 
            this.lblTotalFolders.AutoSize = true;
            this.lblTotalFolders.Location = new System.Drawing.Point(11, 7);
            this.lblTotalFolders.Name = "lblTotalFolders";
            this.lblTotalFolders.Size = new System.Drawing.Size(0, 13);
            this.lblTotalFolders.TabIndex = 0;
            this.lblTotalFolders.TextAlign = System.Drawing.ContentAlignment.MiddleCenter;
            // 
            // lblStatus
            // 
            this.lblStatus.AutoSize = true;
            this.lblStatus.Location = new System.Drawing.Point(14, 426);
            this.lblStatus.Name = "lblStatus";
            this.lblStatus.Size = new System.Drawing.Size(0, 13);
            this.lblStatus.TabIndex = 9;
            // 
            // Form1
            // 
            this.AutoScaleDimensions = new System.Drawing.SizeF(6F, 13F);
            this.AutoScaleMode = System.Windows.Forms.AutoScaleMode.Font;
            this.ClientSize = new System.Drawing.Size(769, 450);
            this.Controls.Add(this.lblStatus);
            this.Controls.Add(this.panel6);
            this.Controls.Add(this.panel1);
            this.Controls.Add(this.tvFilesFound);
            this.Controls.Add(this.panel7);
            this.DoubleBuffered = true;
            this.FormBorderStyle = System.Windows.Forms.FormBorderStyle.FixedSingle;
            this.MaximizeBox = false;
            this.Name = "Form1";
            this.Text = "Simple file search";
            this.FormClosing += new System.Windows.Forms.FormClosingEventHandler(this.Form1_FormClosing);
            this.panel1.ResumeLayout(false);
            this.panel4.ResumeLayout(false);
            this.panel4.PerformLayout();
            this.panel3.ResumeLayout(false);
            this.panel3.PerformLayout();
            this.panel2.ResumeLayout(false);
            this.panel2.PerformLayout();
            this.panel6.ResumeLayout(false);
            this.panel7.ResumeLayout(false);
            this.panel8.ResumeLayout(false);
            this.panel5.ResumeLayout(false);
            this.panel5.PerformLayout();
            this.panel15.ResumeLayout(false);
            this.panel15.PerformLayout();
            this.panel17.ResumeLayout(false);
            this.panel17.PerformLayout();
            this.panel13.ResumeLayout(false);
            this.panel13.PerformLayout();
            this.panel16.ResumeLayout(false);
            this.panel16.PerformLayout();
            this.panel11.ResumeLayout(false);
            this.panel11.PerformLayout();
            this.panel14.ResumeLayout(false);
            this.panel14.PerformLayout();
            this.panel10.ResumeLayout(false);
            this.panel10.PerformLayout();
            this.panel12.ResumeLayout(false);
            this.panel12.PerformLayout();
            this.panel9.ResumeLayout(false);
            this.panel9.PerformLayout();
            this.ResumeLayout(false);
            this.PerformLayout();

        }

        #endregion

        private System.Windows.Forms.TreeView tvFilesFound;
        private System.Windows.Forms.Panel panel1;
        private System.Windows.Forms.Panel panel4;
        private System.Windows.Forms.Button btnOpenFolder;
        private System.Windows.Forms.TextBox tbFilePath;
        private System.Windows.Forms.Label label3;
        private System.Windows.Forms.Panel panel3;
        private System.Windows.Forms.TextBox tbFileContent;
        private System.Windows.Forms.Label label2;
        private System.Windows.Forms.CheckBox cbIsContentRegex;
        private System.Windows.Forms.Panel panel2;
        private System.Windows.Forms.TextBox tbFileName;
        private System.Windows.Forms.Label label1;
        private System.Windows.Forms.CheckBox cbIsFileRegex;
        private System.Windows.Forms.Button btnPause;
        private System.Windows.Forms.Button btnStop;
        private System.Windows.Forms.Button btnStart;
        private System.Windows.Forms.Panel panel6;
        private System.Windows.Forms.Panel panel7;
        private System.Windows.Forms.Label label4;
        private System.Windows.Forms.ProgressBar progressBar1;
        private System.Windows.Forms.Label lblStatus;
        private System.Windows.Forms.Panel panel8;
        private System.Windows.Forms.Panel panel15;
        private System.Windows.Forms.Label label10;
        private System.Windows.Forms.Panel panel13;
        private System.Windows.Forms.Label label8;
        private System.Windows.Forms.Panel panel16;
        private System.Windows.Forms.Label lblTimeElapsed;
        private System.Windows.Forms.Panel panel11;
        private System.Windows.Forms.Label label6;
        private System.Windows.Forms.Panel panel14;
        private System.Windows.Forms.Label lblMatchesFound;
        private System.Windows.Forms.Panel panel10;
        private System.Windows.Forms.Panel panel12;
        private System.Windows.Forms.Label lblFilesDone;
        private System.Windows.Forms.Panel panel9;
        private System.Windows.Forms.Label lblTotalFolders;
        private System.Windows.Forms.Label lblTotalFiles;
        private System.Windows.Forms.Panel panel5;
        private System.Windows.Forms.Label label5;
        private System.Windows.Forms.Panel panel17;
        private System.Windows.Forms.Label label7;
        private System.Windows.Forms.ToolTip toolTip1;
        private System.Windows.Forms.ToolTip toolTip2;
        private System.Windows.Forms.ToolTip toolTip3;
        private System.Windows.Forms.ToolTip toolTip4;
    }
}

