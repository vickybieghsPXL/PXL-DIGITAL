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
using System.Windows.Navigation;
using System.Windows.Shapes;

namespace Opdracht_4_2
{
    /// <summary>
    /// Interaction logic for MainWindow.xaml
    /// </summary>
    public partial class MainWindow : Window
    {
        public MainWindow()
        {
            InitializeComponent();
        }

        private void BerekenButton_Click(object sender, RoutedEventArgs e)
        {
            double omtrek;
            double oppervlakte;
            double volume;

            omtrek = 2 * Math.PI * Convert.ToDouble(straalTextBox.Text);
            oppervlakte = Math.PI * Math.Pow(Convert.ToDouble(straalTextBox.Text), 2);
            volume = (4 * Math.PI / 3) * Math.Pow(Convert.ToDouble(straalTextBox.Text), 3);

            omtrekUitkomstLabel.Content = Convert.ToString(omtrek);
            oppervlakteUitkomstLabel.Content = Convert.ToString(oppervlakte);
            volumeUitkomstLabel.Content = $"{volume:0.00}";



        }
    }
}
