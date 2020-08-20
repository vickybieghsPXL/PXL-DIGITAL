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
using System.Windows.Threading;

namespace Toolbox.Inheritance
{
    /// <summary>
    /// Interaction logic for InheritanceWindow.xaml
    /// </summary>
    public partial class InheritanceWindow : Window
    {
        private DispatcherTimer _animationTimer;
        private SuperCircle _superCircle;
        private SuperCircle _subCircle; // polymorphism - variabele gebruiken we later voor subklasse "SubCircle".

        public InheritanceWindow()
        {
            InitializeComponent();
            _superCircle = new SuperCircle(70, paperCanvas);
            _subCircle = new SubCircle(10, paperCanvas);
            _animationTimer = new DispatcherTimer();
            _animationTimer.Interval = TimeSpan.FromSeconds(0.2);
            _animationTimer.Tick += AnimationTimer_Tick;
            _animationTimer.IsEnabled = true;
        }

        public void AnimationTimer_Tick(object sender, EventArgs e)
        {
            _superCircle.Blink();
            _subCircle.Blink();
        }
    }
}
