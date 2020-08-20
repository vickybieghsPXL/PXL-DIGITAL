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

namespace Oefening3
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

        public void ToonInkomen()
        {
            int jaarsalaris = 24000;
            int aantalJarenDienst = 5;
            int totaalVerdiend = jaarsalaris * aantalJarenDienst;

            MessageBox.Show(Convert.ToString(totaalVerdiend));
        }
    }
}
