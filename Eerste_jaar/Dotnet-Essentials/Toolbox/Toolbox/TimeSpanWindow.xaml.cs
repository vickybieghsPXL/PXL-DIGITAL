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
    /// Interaction logic for TimeSpanWindow.xaml
    /// </summary>
    public partial class TimeSpanWindow : Window
    {
        private DateTime startDateTime;
        private DateTime stopDateTime;
        private TimeSpan elapsedTimeSpan;
        private string time;

        public TimeSpanWindow()
        {
            InitializeComponent();
        }

        private void startButton_Click(object sender, RoutedEventArgs e)
        {
            startDateTime = DateTime.Now;
        }

        private void stopButton_Click(object sender, RoutedEventArgs e)
        {
            stopDateTime = DateTime.Now;
            elapsedTimeSpan = stopDateTime.Subtract(startDateTime);
            time = "sec: " + elapsedTimeSpan.Seconds + ", millisec: " + elapsedTimeSpan.Milliseconds;
            MessageBox.Show(time);
        }
    }
}
