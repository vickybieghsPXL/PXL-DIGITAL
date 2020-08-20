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

namespace Opdracht_4_11
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
            //outputLabel.Content = Convert.ToString(Convert.ToInt32(inputTextBox.Text, 10), 2);

            int number = Convert.ToInt32(inputTextBox.Text);
            int remainder;
            string binatyNumber = "";



            while (number > 0)
            {
                remainder = number % 2;
                number = number / 2;

                binatyNumber = remainder + binatyNumber; 
            }

            outputLabel.Content = binatyNumber;
        }
    }
}
