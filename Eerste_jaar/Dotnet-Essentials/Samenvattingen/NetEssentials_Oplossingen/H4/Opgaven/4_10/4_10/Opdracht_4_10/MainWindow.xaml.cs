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

namespace Opdracht_4_10
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
            double b = 2000;
            int n = 5;
            double r = 0.13;

            double eind = b * Math.Pow((1 + (r / 100)), Convert.ToDouble(n));

            MessageBox.Show(Convert.ToString(eind));
        }
    }
}
