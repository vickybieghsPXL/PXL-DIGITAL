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
    /// Interaction logic for ListBoxWindow.xaml
    /// </summary>
    public partial class ListBoxWindow : Window
    {
        private List<string> list;

        public ListBoxWindow()
        {
            InitializeComponent();
            list = new List<string>();
            LoadItems();
        }

        private void RefreshListBox()
        {
            shoppingListBox.ItemsSource = null;
            shoppingListBox.ItemsSource = list;
        }

        private void Load_Click(object sender, RoutedEventArgs e)
        {
            LoadItems();
        }

        private void LoadItems()
        {
            list.Add("there");
            list.Add("is");
            list.Add("no");
            list.Add("spoon");
            RefreshListBox();
        }


        private void Add_Click(object sender, RoutedEventArgs e)
        {
            list.Add(inputTextBox.Text);
            RefreshListBox();
        }

        private void Clear_Click(object sender, RoutedEventArgs e)
        {
            list.Clear();
            RefreshListBox();
        }

        private void Contains_Click(object sender, RoutedEventArgs e)
        {
            outputLabel.Content = list.Contains(inputTextBox.Text).ToString();
            RefreshListBox();
        }

        // kan ook gezien worden als first index of
        private void IndexOf_Click(object sender, RoutedEventArgs e)
        {
            if (shoppingListBox.SelectedItem != null)
            {
                outputLabel.Content = list.IndexOf(shoppingListBox.SelectedItem.ToString());
                RefreshListBox();
            }
        }

        private void LastIndexOf_Click(object sender, RoutedEventArgs e)
        {
            if (shoppingListBox.SelectedItem != null)
            {
                outputLabel.Content = list.LastIndexOf(shoppingListBox.SelectedItem.ToString());
                RefreshListBox();
            }

        }

        private void Remove_Click(object sender, RoutedEventArgs e)
        {
            try
            {
                list.RemoveAt(shoppingListBox.SelectedIndex);
                RefreshListBox();
            }
            catch (ArgumentOutOfRangeException outOfRangeException)
            {
                MessageBox.Show("You have not selected an item to delete. " + outOfRangeException.Message);
            }
        }

        private void RemoveAt_Click(object sender, RoutedEventArgs e)
        {
            list.RemoveAt(shoppingListBox.SelectedIndex);
            RefreshListBox();
        }

        private void Insert_Click(object sender, RoutedEventArgs e)
        {
            list.Insert(shoppingListBox.SelectedIndex, inputTextBox.Text);
            RefreshListBox();
        }

        private void Sort_Click(object sender, RoutedEventArgs e)
        {
            list.Sort();
            RefreshListBox();
        }

        private void Reverse_Click(object sender, RoutedEventArgs e)
        {
            list.Reverse();
            RefreshListBox();
        }

        private void Count_Click(object sender, RoutedEventArgs e)
        {
            outputLabel.Content = list.Count();
            RefreshListBox();
        }

        private void shuffleButton_Click(object sender, RoutedEventArgs e)
        {
            Random random = new Random();
            if (list.Count > 1)
            {
                for (int i = list.Count - 1; i >= 0; i--)
                {
                    string tmp = list[i];
                    int randomIndex = random.Next(i + 1);
                    list[i] = list[randomIndex];
                    list[randomIndex] = tmp;
                }
            }

            RefreshListBox();

            /*  -----------------------------beter
            List<Club> _tempClubs = new List<Club>();
            Random rand = new Random();
            int loopcount = _clubs.Count;
            for (int j = 0; j < loopcount; j++)
            {
                int randIndex = rand.Next(0, _clubs.Count);
                _tempClubs.Add(_clubs[randIndex]);
                _clubs.RemoveAt(randIndex);
            }

            _clubs = _tempClubs;
            */ //------------------------------------
        }
    }
}