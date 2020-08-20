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

namespace Oefening12
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

        public double OppCirkel(double straal)
        {
            return (Math.PI * straal * straal);
        }

        public double OppCilinder(double straal, double hoogte)
        {
            double oppervlakte;

            oppervlakte = (OppCirkel(straal) * 2);
            oppervlakte += (2 * Math.PI * straal * hoogte);

            return oppervlakte;
        }
    }
}
