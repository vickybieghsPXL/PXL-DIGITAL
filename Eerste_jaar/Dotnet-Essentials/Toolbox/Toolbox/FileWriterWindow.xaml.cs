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
    public partial class FileWriterWindow : Window
    {
        public FileWriterWindow()
        {
            InitializeComponent();
        }

        public void writeButton_Click(object sender, RoutedEventArgs e)
        {
            StreamWriter writer = null;
            FileStream stream = null;
            try
            {
                stream = new FileStream("users.txt", FileMode.Append, FileAccess.Write);
                writer = new StreamWriter(stream);
                writer.WriteLine("this text will be written to the file.");
            }
            catch (IOException ex)
            {
                MessageBox.Show(ex.Message);
                throw ex;
            }
            finally
            {
                writer?.Close();
                stream?.Close();
            }
        }

        public void clearAndWriteButton_Click(object sender, RoutedEventArgs e)
        {
            StreamWriter writer = null;
            FileStream stream = null;
            try
            {
                StreamWriter bestand = null;
                bestand = File.CreateText(System.IO.Path.Combine(Environment.GetFolderPath(Environment.SpecialFolder.MyDocuments), "domineering.txt"));
                bestand.Write(Environment.NewLine);
                bestand.Write("some stuff to write");
                bestand.WriteLine("some stuff on a new line");
            }
            catch (IOException ex)
            {
                MessageBox.Show(ex.Message);
                throw ex;
            }
            finally
            {
                writer?.Close();
                stream?.Close();
            }
        }
    }
}
