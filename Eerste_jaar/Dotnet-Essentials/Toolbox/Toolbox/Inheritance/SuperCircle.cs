using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using System.Windows;
using System.Windows.Controls;
using System.Windows.Media;
using System.Windows.Shapes;
using System.Windows.Threading;

namespace Toolbox.Inheritance
{
    // kan ook abstract zijn en dus geen mogelijke implementatie hebben.
    public class SuperCircle
    {
        private Ellipse _ellipse;
        private bool red;

        public SuperCircle(int x, Canvas paperCanvas)
        {
            _ellipse = new Ellipse();
            _ellipse.Width = 50;
            _ellipse.Height = 50;
            _ellipse.Margin = new Thickness(x, 20, 0, 0);
            _ellipse.Stroke = new SolidColorBrush(Colors.Black);
            _ellipse.Fill = new SolidColorBrush(Colors.Red);
            red = true;
            paperCanvas.Children.Add(_ellipse);
        }

        public void Blink()
        {
            if (red)
            {
                _ellipse.Fill = new SolidColorBrush(Colors.Blue);
                red = false;
            }
            else
            {
                _ellipse.Fill = new SolidColorBrush(Colors.Red);
                red = true;
            }
        }
    }
}
