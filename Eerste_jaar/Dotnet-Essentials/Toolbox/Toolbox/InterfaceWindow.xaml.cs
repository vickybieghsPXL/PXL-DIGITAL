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
using System.Windows.Shapes;

namespace Toolbox
{
    /// <summary>
    /// Interaction logic for InterfaceWindow.xaml
    /// </summary>
    public partial class InterfaceWindow : Window
    {
        CircleWithInterface cirkel = new CircleWithInterface();
        SolidColorBrush brush = new SolidColorBrush(Colors.BlueViolet);

        public InterfaceWindow()
        {
            InitializeComponent();
            cirkel.DisplayOn(paperCanvas);
        }
    }
}
