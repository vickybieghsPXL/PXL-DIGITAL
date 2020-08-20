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
    /// Interaction logic for FileReaderWindow.xaml
    /// </summary>
    public partial class FileReaderWindow : Window
    {
        private FileStream stream;
        private StreamReader reader;

        public FileReaderWindow()
        {
            InitializeComponent();
        }

        public void readButton_Click(object sender, RoutedEventArgs e)
        {
            string filename = "thisfile.txt";
            try // possible to do             if (File.Exists(ploegenPad))           instead
            {
                //string fileInDocumentsDir = System.IO.Path.Combine("thisfile.txt", Environment.GetFolderPath(Environment.SpecialFolder.MyDocuments));
                 // filename = "thisfile.txt"
                reader = new StreamReader(stream);
                List<string> linesList = new List<string>();
                readTextBox.Text = reader.ReadToEnd();
                readTextBox.AppendText(Environment.NewLine + "suffix");
                stream.Position = 0;            // reset reader&stream to top of file
                reader.DiscardBufferedData();   //
                string line = reader.ReadLine();
                while (line != null)
                {
                    string[] csv = line.Split(',');
                    // List<string> csv = line.Split(',').ToList();  // same as hierboven

                    for (int i = 0; i < csv.Length; i++)
                    {
                        linesList.Add(csv[i]);
                    }

                    line = reader.ReadLine();
                }

                readListBox.ItemsSource = linesList;
            }
            catch (FileNotFoundException ex)
            {
                MessageBox.Show(String.Format("Bestand niet gevonden:{0}", filename));
            }
            catch (IOException ex)
            {
                MessageBox.Show("IOException");
            }
            catch (Exception ex)
            {
                MessageBox.Show(String.Format("Error concerning file{0}, {1} ", filename, ex.Message));
                throw ex;
            }
            finally
            {
                stream?.Close();
                reader?.Close();
            }
        }
    }
}
