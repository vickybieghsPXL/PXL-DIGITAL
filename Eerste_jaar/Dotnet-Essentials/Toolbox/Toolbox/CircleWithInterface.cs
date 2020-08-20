using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using System.Windows;
using System.Windows.Controls;
using System.Windows.Media;
using System.Windows.Shapes;

namespace Toolbox
{
    public class CircleWithInterface : ICircle
    {
        Ellipse circle;

        public CircleWithInterface()
        {
            circle = new Ellipse();
            circle.Width = 100;
            circle.Height = 100;
            circle.Margin = new Thickness(10, 10, 0, 0);
            circle.Stroke = new SolidColorBrush(Colors.Black);
            circle.Fill = new SolidColorBrush(Colors.Red);
        }

        public void DisplayOn(Canvas drawArea)
        {
            drawArea.Children.Add(circle);
        }
    }
}
