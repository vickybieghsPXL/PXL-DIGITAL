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
    public enum TestEnum
    {
        Iets = 'A',
        NogIets = 'B',
        EenGetal = 5,
        NogEenGetal = 6,
    }

    public partial class EnumWindow : Window
    {
        TestEnum testEnum = new TestEnum();

        public EnumWindow()
        {
            InitializeComponent();
        }

        private void enum1Button_Click(object sender, RoutedEventArgs e)
        {
            this.testEnum = (TestEnum)Convert.ToChar(enumSource1.Content);
            MessageBox.Show(testEnum.ToString());
        }

        private void enum2Button_Click(object sender, RoutedEventArgs e)
        {
            this.testEnum = (TestEnum)Convert.ToInt32(enumSource2.Content);
            MessageBox.Show(testEnum.ToString());
        }
    }
}
