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
    /// <summary>
    /// Interaction logic for DirectoryWindow.xaml
    /// </summary>
    public partial class DirectoryWindow : Window
    {
        public DirectoryWindow()
        {
            InitializeComponent();
        }

        private void showButton_Click(object sender, RoutedEventArgs e)
        {
            filesTextBox.Clear();
            foldersTextBox.Clear();
            // Display all file names
            string[] files = Directory.GetFiles(folderTextBox.Text);
            foreach (string file in files)
            {
                filesTextBox.AppendText(file);
                filesTextBox.AppendText(Environment.NewLine);
            }
            // Display all folder names
            string[] dirs = Directory.GetDirectories(folderTextBox.Text);
            foreach (string dir in dirs)
            {
                foldersTextBox.AppendText(dir);
                foldersTextBox.AppendText(Environment.NewLine);
            }
        }
    }
}
