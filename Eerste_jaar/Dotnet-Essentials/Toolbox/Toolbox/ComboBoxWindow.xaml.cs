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
    /// Interaction logic for ComboBoxWindow.xaml
    /// </summary>
    public partial class ComboBoxWindow : Window
    {
        public ComboBoxWindow()
        {
            InitializeComponent();
        }

        private void colorComboBox_SelectionChanged(object sender, SelectionChangedEventArgs e)
        {
            int index = colorComboBox.SelectedIndex;
            ComboBoxItem item = (ComboBoxItem)colorComboBox.Items[index];
            string colorString = Convert.ToString(item.Content);

            Color color = (Color)ColorConverter.ConvertFromString(colorString);

            colorLabel.Background = new SolidColorBrush(color);

        }
    }
}
