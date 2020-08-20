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

namespace Opdracht_4_8
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
            double r1 = 4.7;
            double r2 = 6.8;

            double serie;
            double parallel;

            serie = r1 + r2;
            parallel = (r1 * r2) / (r1 + r2);

            serieLabel.Content = "Serie: " + Convert.ToString(serie);
            parallelLabel.Content = "Parallel: " + Convert.ToString(parallel);
        }
    }
}
