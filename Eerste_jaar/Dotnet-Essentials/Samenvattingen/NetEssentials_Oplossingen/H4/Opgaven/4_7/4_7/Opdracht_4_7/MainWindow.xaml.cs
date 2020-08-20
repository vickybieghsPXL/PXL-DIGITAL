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

namespace Opdracht_4_7
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
            int totaalAantalSeconden = 2549;

            int uren = totaalAantalSeconden / 3600;
            int minuten = (totaalAantalSeconden % 3600) / 60;
            int seconden = (totaalAantalSeconden - (uren * 3600) - (minuten * 60));

            MessageBox.Show("H:" + Convert.ToString(uren) + "   M:" + Convert.ToString(minuten) + "   S:" + Convert.ToString(seconden));
        }
    }
}
