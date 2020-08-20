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
    /// Interaction logic for dictionaryWindow.xaml
    /// </summary>
    public partial class DictionaryWindow : Window
    {
        Dictionary<int, char> alfabet = new Dictionary<int, char>();
        public DictionaryWindow()
        {
            InitializeComponent();
            CreateDictionary();
        }

        public void CreateDictionary()
        {
            for (int i = 97; i <= 122; i++)
            {
                alfabet.Add(i - 96, Convert.ToChar(i));
            }
        }

        private void SearchButton_Click(object sender, RoutedEventArgs e)
        {
            int key = Convert.ToInt32(searchTextBox.Text);
            if (alfabet.ContainsKey(key))
            {
                resultLabel.Content = alfabet[key];
            }
        }
    }
}
