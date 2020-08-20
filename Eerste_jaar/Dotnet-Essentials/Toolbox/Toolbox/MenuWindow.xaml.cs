using Microsoft.Win32;
using System;
using System.Collections.Generic;
using System.IO;
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

namespace Toolbox
{
    public partial class MenuWindow : Window
    {

        private string currentFile;

        public MenuWindow()
        {
            InitializeComponent();
            currentFile = "";
        }


        private void openMenuItem_Click(object sender, RoutedEventArgs e)
        {
            StreamReader inputStream;
            OpenFileDialog dialog = new OpenFileDialog();
            dialog.InitialDirectory = Environment.GetFolderPath(Environment.SpecialFolder.MyDocuments);
            dialog.Filter = "txt files (*.txt)|*.txt";
            if (dialog.ShowDialog() == true)
            {
                currentFile = dialog.FileName;
                inputStream = File.OpenText(currentFile);
                mainTextBox.Text = inputStream.ReadToEnd();
                inputStream.Close();
            }
        }

        private void saveMenuItem_Click(object sender, RoutedEventArgs e)
        {
            if (currentFile == "")
            {
                SaveFileDialog dialog = new SaveFileDialog();
                dialog.InitialDirectory = Environment.GetFolderPath(Environment.SpecialFolder.MyDocuments);
                if (dialog.ShowDialog() == true)
                {
                    currentFile = dialog.FileName;
                }
            }

            StreamWriter outputStream = File.CreateText(currentFile);
            outputStream.Write(mainTextBox.Text);
            outputStream.Close();
        }

        private void saveAsMenuItem_Click(object sender, RoutedEventArgs e)
        {
            StreamWriter outputStream;
            SaveFileDialog dialog = new SaveFileDialog();
            dialog.Filter = "txt files (*.txt)|*.txt|All files (*.*)|*.*";
            dialog.FilterIndex = 2;
            dialog.RestoreDirectory = true;
            //dialog.InitialDirectory = Environment.GetFolderPath(Environment.SpecialFolder.MyDocuments);
            if (dialog.ShowDialog() == true)
            {
                currentFile = dialog.FileName;
                outputStream = File.CreateText(currentFile);
                outputStream.Write(mainTextBox.Text);
                outputStream.Close();
            }
        }

        private void exitMenuItem_Click(object sender, RoutedEventArgs e)
        {
            Environment.Exit(0);
        }
    }
}
