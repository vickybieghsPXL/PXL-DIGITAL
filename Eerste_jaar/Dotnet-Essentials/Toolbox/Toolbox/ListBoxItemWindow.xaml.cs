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
    public partial class ListBoxItemWindow : Window
    {
        private List<ListCarrierForListBoxItemWindow> _randomList;
        private List<ListCarrierForListBoxItemWindow> _anotherList;

        public List<ListCarrierForListBoxItemWindow> AnotherList
        {
            get { return _anotherList; }
            set { _anotherList = value; }
        }


        public List<ListCarrierForListBoxItemWindow> RandomList
        {
            get { return _randomList; }
            set { _randomList = value; }
        }

        public ListBoxItemWindow()
        {
            InitializeComponent();
            RandomList = new List<ListCarrierForListBoxItemWindow>();
            RandomList.Add(new ListCarrierForListBoxItemWindow("firstlist", new List<string>() { "hello", "there", "good", "sir" }));
            RandomList.Add(new ListCarrierForListBoxItemWindow("secondlist", new List<string>() { "hows", "it", "hangin", "bro" }));
            firstListBox.ItemsSource = RandomList;
        }

        private void FirstListBox_OnSelectionChanged(object sender, SelectionChangedEventArgs e)
        {
            secondListBox.ItemsSource = RandomList[firstListBox.SelectedIndex].CarriedList;
        }

        private void SecondListBox_OnMouseDoubleClick(object sender, MouseButtonEventArgs e)
        {
            throw new NotImplementedException();
        }
    }
}
