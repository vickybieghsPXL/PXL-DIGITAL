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

namespace Opdracht_h2_2
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

        private void ZichtbaarButton_Click(object sender, RoutedEventArgs e)
        {
            kleurLabel.Visibility = Visibility.Visible;
        }

        private void OnzichtbaarButton_Click(object sender, RoutedEventArgs e)
        {
            kleurLabel.Visibility = Visibility.Collapsed;
        }
    }
}
