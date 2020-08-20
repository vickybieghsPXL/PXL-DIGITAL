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

namespace Demo
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

        private void Button1_Click(object sender, RoutedEventArgs e)
        {
            Label1.Content = "Ja";
            Label2.Content = "Ja";
            Label3.Content = "Ja";
        }

        private void Button2_Click(object sender, RoutedEventArgs e)
        {
            Button1.Content = "Nee";
            Button2.Content = "Nee";
            Button3.Content = "Nee";
        }

        private void Button3_Click(object sender, RoutedEventArgs e)
        {
            Label1.Content = "A";
            Label2.Content = "B";
            Label3.Content = "C";
        }
    }
}
