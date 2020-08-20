using System;
using System.Collections.Generic;
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
    /// Interaction logic for NewActWindow.xaml
    /// </summary>
    public partial class NewActWindow : Window
    {
        private ListBox otherListBox;
        private List<Performer> performers;
        private int buttonChecked;

        public NewActWindow(List<Performer> otherList, ListBox listbox )
        {
            otherListBox = listbox;
            InitializeComponent();
            performers = otherList;
            buttonChecked = 0;
            
        }



        private void BandRadioButton_Checked(object sender, RoutedEventArgs e)
        {
            if (typeCountLabel != null)
            {
                typeCountLabel.Content = "Members";
            }

            buttonChecked = 0;

        }

        private void SoloRadioButton_Checked(object sender, RoutedEventArgs e)
        {
            if (typeCountLabel != null)
            {
                typeCountLabel.Content = "Type of artist";
            }

            buttonChecked = 1;
        }

        private void AddActButton_Click(object sender, RoutedEventArgs e)
        {
            int[] tempArray = new int[2];
            string[] riderTemp = null;
            string[] technicalTemp = null;
            List<string> tempList = new List<string>();

            try
            {
                CheckInput();
                CheckTimeForOverlap();
                technicalTemp = technicalTextBox.Text.Split(' ');
                riderTemp = riderTextBox.Text.Split(',');

                tempArray[0] = Convert.ToInt32(technicalTemp[0]);
                tempArray[1] = Convert.ToInt32(technicalTemp[1]);

                for(int i = 0; i < riderTemp.Length; i++)
                {
                    tempList.Add(riderTemp[i]);
                }


                if(buttonChecked == 0)
                {
                    performers.Add(new Band(Convert.ToInt32(typeCountTextBox.Text), nameTextBox.Text, Convert.ToInt32(numberTextBox.Text), startHourTextBox.Text, endHourTextBox.Text, tempArray, tempList));
                }
                else
                {
                    performers.Add(new Solo(typeCountTextBox.Text, nameTextBox.Text, Convert.ToInt32(numberTextBox.Text), startHourTextBox.Text, endHourTextBox.Text, tempArray, tempList));
                }

                sortListAccordingToTime();
                otherListBox.Items.Refresh();
                this.Close();

            }
            catch(FestivalException ex)
            {
                MessageBox.Show(ex.Message);
            }
        }

        private void CheckTimeForOverlap()
        {
            /*
             Helaas geen tijd hiervoor

            Begin tijd en eind tijd omzetten naar time spans

            begintijd vergelijken om te kijken wanneer je start, dan begintijd vergelijken met eindtijd van het volgende evenement om zo te zien of het kan
            anders
            throw new FestivalException("Vorig Festival is not niet beëindigd.")
             
             
             */

            string[] tijd1 = startHourTextBox.Text.Split(':');
            string[] tijd2 = endHourTextBox.Text.Split(':');

            TimeSpan startTime = new TimeSpan(Convert.ToInt32(tijd1[0]), Convert.ToInt32(tijd1[1]), 0);
            TimeSpan endTime = new TimeSpan(Convert.ToInt32(tijd2[0]), Convert.ToInt32(tijd2[1]), 0);

            for(int i = 0; i < performers.Count - 1; i++)
            {
                if(performers[i].EndTime < startTime)
                {

                    if(performers[i+1].StartTime < endTime)
                    {
                        throw new FestivalException("Vorig optreden is not niet beëndigd");
                    }
                }
            }

        }

        private void sortListAccordingToTime()
        {
            TimeSpan lowest = performers[0].StartTime;

            for (int i = 0; i < performers.Count; i++)
            {

                for (int j = i; j < performers.Count; j++)
                {
                    if (performers[j].StartTime < performers[i].StartTime)
                    {
                        Performer temp = performers[i];
                        performers[i] = performers[j];
                        performers[j] = temp;
                    }
                }
            }
        }

        private void CheckInput()
        {
            if (typeCountTextBox.Text == "" || nameTextBox.Text == "" || numberTextBox.Text == "" || startHourTextBox.Text == "" || endHourTextBox.Text == "" || technicalTextBox.Text == "" || riderTextBox.Text == "")
            {
                throw new FestivalException("Gelieve alle velden in te vullen!");
            }
        }
    }
}
