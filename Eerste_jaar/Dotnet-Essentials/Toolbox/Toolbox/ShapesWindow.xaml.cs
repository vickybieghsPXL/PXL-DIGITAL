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
    /// Interaction logic for Shapes.xaml
    /// </summary>
    public partial class ShapesWindow : Window
    {
        public ShapesWindow()
        {
            InitializeComponent();
        }

        private void drawButton_Click(object sender, RoutedEventArgs e)
        {
            Rectangle rect1 = new Rectangle();
            rect1.Width = 100;
            rect1.Height = 50;
            rect1.Margin = new Thickness(10, 10, 0, 0);
            rect1.Stroke = new SolidColorBrush(Colors.Black);
            rect1.Fill = new SolidColorBrush(Colors.Red);
            paperCanvas.Children.Add(rect1);

            Line line1 = new Line();
            line1.X1 = 10; line1.Y1 = 10;
            line1.X2 = 110; line1.Y2 = 60;
            line1.Stroke = new SolidColorBrush(Colors.Black);
            line1.Fill = new SolidColorBrush(Colors.Red);
            paperCanvas.Children.Add(line1);

            Rectangle rect2 = new Rectangle();
            rect2.Width = 100;
            rect2.Height = 50;
            rect2.Margin = new Thickness(10, 80, 0, 0);
            rect2.Stroke = new SolidColorBrush(Colors.Black);
            rect2.Fill = new SolidColorBrush(Colors.Red);
            paperCanvas.Children.Add(rect2);

            Ellipse ellipse1 = new Ellipse();
            ellipse1.Width = 100;
            ellipse1.Height = 50;
            ellipse1.Margin = new Thickness(10, 80, 0, 0);
            ellipse1.Stroke = new SolidColorBrush(Colors.Black);
            ellipse1.Fill = new SolidColorBrush(Colors.Red);
            paperCanvas.Children.Add(ellipse1);

            Ellipse ellipse2 = new Ellipse();
            ellipse2.Width = 100;
            ellipse2.Height = 50;
            ellipse2.Margin = new Thickness(10, 150, 0, 0);
            ellipse2.Fill = new SolidColorBrush(Colors.Gray);
            ellipse2.Fill = new SolidColorBrush(Colors.Red);
            paperCanvas.Children.Add(ellipse2);

            BitmapImage bi = new BitmapImage();
            bi.BeginInit();
            //bi.UriSource = new Uri("imagedemo.jpg", UriKind.RelativeOrAbsolute);
            bi.UriSource = new Uri("imagedemo.jpg",
                                   UriKind.RelativeOrAbsolute);
            bi.EndInit();
            Image picture = new Image();
            picture.Source = bi;
            picture.Margin = new Thickness(120, 10, 0, 0);
            picture.Width = 150;
            picture.Height = 150;
            paperCanvas.Children.Add(picture);

            // draw a triangle
            // first line
            Line l1 = new Line();
            l1.X1 = 20; l1.Y1 = 280;
            l1.X2 = 70; l1.Y2 = 210;
            l1.Stroke = new SolidColorBrush(Colors.Black);
            // second line
            Line l2 = new Line();
            l2.X1 = 70; l2.Y1 = 210;
            l2.X2 = 120; l2.Y2 = 280;
            l2.Stroke = new SolidColorBrush(Colors.Black);
            // third line
            Line l3 = new Line();
            l3.X1 = 120; l3.Y1 = 280;
            l3.X2 = 20; l3.Y2 = 280;
            l3.Stroke = new SolidColorBrush(Colors.Black);
            // add to the canvas
            paperCanvas.Children.Add(l1);
            paperCanvas.Children.Add(l2);
            paperCanvas.Children.Add(l3);
        }
    }
}
