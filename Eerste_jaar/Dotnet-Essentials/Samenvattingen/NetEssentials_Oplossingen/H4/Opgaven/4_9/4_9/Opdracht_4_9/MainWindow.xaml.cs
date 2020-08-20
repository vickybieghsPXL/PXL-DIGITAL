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

namespace Opdracht_4_9
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
            int amountGiven = 100;
            int itemCost = 45;
            int amountReturn = amountGiven - itemCost;

            int _1euro = amountReturn / 100;
            amountReturn = amountReturn % 100;
            int _50cent = amountReturn / 50;
            amountReturn = amountReturn % 50;
            int _20cent = amountReturn / 20;
            amountReturn = amountReturn % 20;
            int _10cent = amountReturn / 10;
            amountReturn = amountReturn % 10;
            int _5cent = amountReturn / 5;
            amountReturn = amountReturn % 5;
            int _2cent = amountReturn / 2;
            amountReturn = amountReturn % 2;
            int _1cent = amountReturn / 1;
            amountReturn = amountReturn % 1;

            if (amountReturn != 0)
            {
                MessageBox.Show("Error");
            } else
            {
                MessageBox.Show("Number of 1 euro coins is " + Convert.ToString(_1euro));
                MessageBox.Show("Number of 50 cent coins is " + Convert.ToString(_50cent));
                MessageBox.Show("Number of 20 cent coins is " + Convert.ToString(_20cent));
                MessageBox.Show("Number of 10 cent coins is " + Convert.ToString(_10cent));
                MessageBox.Show("Number of 5 cent coins is " + Convert.ToString(_5cent));
                MessageBox.Show("Number of 2 cent coins is " + Convert.ToString(_2cent));
                MessageBox.Show("Number of 1 cent coins is " + Convert.ToString(_1cent));
            }
        }
    }
}
