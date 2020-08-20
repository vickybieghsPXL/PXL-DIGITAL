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
    /// Interaction logic for SlidersWindow.xaml
    /// </summary>
    public partial class SlidersWindow : Window
    {
        public SlidersWindow()
        {
            InitializeComponent();
        }

        private void horizSlider_ValueChanged(object sender, RoutedPropertyChangedEventArgs<double> e)
        {
            sizeChangingEllipse.Width = horizSlider.Value * 10;
            if (horizLabel != null)
            {
                horizLabel.Content = sizeChangingEllipse.Width;
            }
        }

        private void vertSlider_ValueChanged(object sender, RoutedPropertyChangedEventArgs<double> e)
        {
            sizeChangingEllipse.Height = vertSlider.Value * 10;
        }
    }
}
