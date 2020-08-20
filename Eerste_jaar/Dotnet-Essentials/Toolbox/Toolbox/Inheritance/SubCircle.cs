using System;
using System.Collections.Generic;
using System.Linq;
using System.Runtime.CompilerServices;
using System.Security.Cryptography.X509Certificates;
using System.Text;
using System.Threading.Tasks;
using System.Windows;
using System.Windows.Controls;
using System.Windows.Media;
using System.Windows.Shapes;

namespace Toolbox.Inheritance
{
    class SubCircle : SuperCircle
    {
        private Rectangle _rect;

        public SubCircle(int x, Canvas paperCanvas) : base(x, paperCanvas)
        {
            _rect = new Rectangle();
            _rect.Width = 30;
            _rect.Height = 30;
            _rect.Margin = new Thickness(x+10, 30, 0, 0);
            _rect.Stroke = new SolidColorBrush(Colors.Black);
            _rect.Fill = new SolidColorBrush(Colors.White);
            paperCanvas.Children.Add(_rect);
        }
    }
}
