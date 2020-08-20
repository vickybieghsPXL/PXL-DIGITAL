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

namespace _5_1
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

        private void Drawbutton_Click(object sender, RoutedEventArgs e)
        {
            drawLogo(1, 100, 100);
            drawLogo(1, 160, 100);
            drawTriangle();
        }
        private void drawRectangle(int size, int xmargin, int ymargin)
        {
            Rectangle rect = new Rectangle();
            rect.Width = 20 * size;
            rect.Height = 20 * size;
            rect.Margin = new Thickness(xmargin, ymargin, 0, 0);
            rect.Stroke = new SolidColorBrush(Colors.Black);
            area.Children.Add(rect);
        }
        private void drawLogo(int size, int xmargin, int ymargin)
        {
            drawRectangle(size, xmargin, ymargin);
            drawRectangle(size + 1, xmargin, ymargin);
            drawRectangle(size + 2, xmargin, ymargin);
        }
        private void drawTriangle()
        {
        }
    }
}
