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

namespace Oefening17
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

        public int TijdverschilInSec(int t1Uren, int t1Minuten, int t1Seconden, int t2Uren, int t2Minuten, int t2Seconden)
        {
            int verschil;
            int t1;
            int t2;

            t1 = TijdInSec(t1Uren, t1Minuten, t1Seconden);
            t2 = TijdInSec(t2Uren, t2Minuten, t2Seconden);

            verschil = t2 - t1;
            if (verschil < 0)
            {
                verschil = -verschil;
            }

            return verschil;
        }

        public int TijdInSec(int uren, int minuten, int seconden)
        {
            return (uren * 60 * 60) + (minuten * 60) + seconden;
        }

        public void Invoer3(out int a, out int b, out int c)
        {
            a = 10;
            b = 20;
            c = 30;
            aTextBox.Text = Convert.ToString(a);
            bTextBox.Text = Convert.ToString(b);
            cTextBox.Text = Convert.ToString(c);
        }
    }
}
