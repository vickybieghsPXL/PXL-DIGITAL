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

namespace DotNetExamenJuni
{
    /// <summary>
    /// Interaction logic for StageLineUpWindow.xaml
    /// </summary>
    public partial class StageLineUpWindow : Window
    {
        private string lastPath;
        private Window mainWindow;
        private List<Performer> performers = new List<Performer>();

        public StageLineUpWindow(Window window)
        {
            mainWindow = window;
            InitializeComponent();
            DisableEvents();
        }

        //TODO: zorg dat onderstaande code werkt, volgens richtlijnen opgave
        public void DisableEvents()
        {
            addButton.IsEnabled = false;
            removeButton.IsEnabled = false;
            saveMenuItem.IsEnabled = false;
        }

        //TODO: zorg dat onderstaande code werkt, volgens richtlijnen opgave
        public void EnableEvents()
        {
            addButton.IsEnabled = true;
            removeButton.IsEnabled = true;
            saveMenuItem.IsEnabled = true;
        }

        private void RemoveButton_Click(object sender, RoutedEventArgs e)
        {
            performers.RemoveAt(performListBox.SelectedIndex);

            //tip om de getoonde lijst te updaten.
            performListBox.Items.Refresh();
        }

        private void exitMenuItem_Click(object sender, RoutedEventArgs e)
        {
            Environment.Exit(0);
        }

        private void openMenuItem_Click(object sender, RoutedEventArgs e)
        {
            lastPath = getPathFromSelectedFile();
            string line = "";
            string[] input;
            StreamReader inputStream = null;
            int[] tempArray = new int[2];
            List<string> tempList;

            try
            {
                inputStream = File.OpenText(lastPath);
                line = inputStream.ReadLine();


                while (line != null)
                {
                    input = line.Split(',');

                    tempArray[0] = Convert.ToInt32(input[6]);
                    tempArray[1] = Convert.ToInt32(input[7]);
                    tempList = new List<string>();

                    for (int i = 8; i < input.Length; i++)
                    {
                        tempList.Add(input[i]);
                    }

                    if (input[0] == "B")
                    {
                        performers.Add(new Band(Convert.ToInt32(input[1]), input[2], Convert.ToInt32(input[3]), input[4], input[5], tempArray, tempList));
                    }
                    else
                    {
                        performers.Add(new Solo(input[1], input[2], Convert.ToInt32(input[3]), input[4], input[5], tempArray, tempList));
                    }

                    line = inputStream.ReadLine();
                }
                performListBox.ItemsSource = performers;
                SetStage();
                EnableEvents();

            }
            catch (FileNotFoundException ex)
            {
                MessageBox.Show(ex.ToString());
            }
            finally
            {
                if (inputStream != null)
                {
                    inputStream.Close();
                }
            }
        }

        //Tip bij bewaren:
        //obj is Band geeft true terug als obj van het type Band is.
        private string getPathFromSelectedFile()
        {
            OpenFileDialog openFileDialog = new OpenFileDialog();
            string startDir = Environment.GetFolderPath(Environment.SpecialFolder.Desktop);
            openFileDialog.InitialDirectory = startDir;
            openFileDialog.Filter = "All files (*.*)|*.*";

            if (openFileDialog.ShowDialog() == true)
            {
                return openFileDialog.FileName.ToString();
            }
            else
            {
                return "";
            }
        }

        private void saveMenuItem_Click(object sender, RoutedEventArgs e)
        {
            /*Vergeten hoe je kan checken of iets van een bepaalde klasse is maar de formule is als volgt:
             * 
             * if statement om te kijken iets van klasse band is
             *   Listitem casten naar een band
             *   Gegevens in een string schrijven
             *   string wegschrijven naar bestand
             *   
             * Idem voor Solo
             * 
             * Maar omdat ik het vergeten ben maar toch wil aantonen dat ik het kan zet ik alle performers om naar een band met 4 bandleden
             */

            StreamWriter outputStream = null;
            string line;

            try
            {
                outputStream = File.CreateText(lastPath);

                for(int i = 0; i < performers.Count; i++)
                {
                    line = ConstructStringToWriteToFile(i);
                    outputStream.WriteLine(line);
                }
            }
            catch(IOException ex)
            {
                MessageBox.Show(ex.Message);
            }
            finally
            {
                if (outputStream != null)
                {
                    outputStream.Close();
                }
            }
        }

        private string ConstructStringToWriteToFile(int index)
        {
            StringBuilder temp = new StringBuilder("B, 4,");

            temp.Append(performers[index].Name);
            temp.Append(",");
            temp.Append(performers[index].ReservationNumber);
            temp.Append(",");
            temp.Append(performers[index].StartTime.Hours);
            temp.Append(":");
            temp.Append(performers[index].StartTime.Minutes);
            temp.Append(",");
            temp.Append(performers[index].EndTime.Hours);
            temp.Append(":");
            temp.Append(performers[index].EndTime.Minutes);
            temp.Append(",");
            temp.Append(performers[index].TechnicalSupplies[0]);
            temp.Append(",");
            temp.Append(performers[index].TechnicalSupplies[1]);
            temp.Append(",");

            for(int i = 0; i < performers[index].Rider.Count; i++)
            {
                temp.Append(performers[index].Rider[i]);

                if(i != performers[index].Rider.Count - 1)
                {
                    temp.Append(",");
                }
            }

            return temp.ToString();
        }

        private void SetStage()
        {
            if(lastPath.Contains("Main Stage"))
            {
                stageTextBlock.Text = "Main Stage";

            } else if (lastPath.Contains("The Barn"))
            {
                stageTextBlock.Text = "The Barn";

            }
            else
            {
                stageTextBlock.Text = "The Slope";
            }
            
        }

        private void addButton_Click(object sender, RoutedEventArgs e)
        {
            DisableEvents();
            NewActWindow newActWindow = new NewActWindow(performers, performListBox);
            newActWindow.Show();
            //tip om de getoonde lijst te updaten.
            performListBox.Items.Refresh();
            EnableEvents();
        }
    }
}
