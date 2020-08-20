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

namespace Oefening18
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

        public string SecNaarUMS(int seconden)
        {
            int uren;
            int minuten;

            uren = seconden / 3600;
            seconden = seconden % 3600;

            minuten = seconden / 60;
            seconden = seconden % 60;

            string output = "Uren: " + Convert.ToString(uren) + " Minuten: " + Convert.ToString(minuten) + " Seconden: " + Convert.ToString(seconden);
            return output;
        }

        public string UMSVerschil(int t1, int t2)
        {
            int verschil = t2 - t1;
            if (verschil < 0) {
                verschil = -verschil;
            }
            string output = SecNaarUMS(verschil);
            return output;
        }
    }
}
