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
    /// Interaction logic for messageBoxDialogWindow.xaml
    /// </summary>
    public partial class MessageBoxDialogWindow : Window
    {
        public MessageBoxDialogWindow()
        {
            InitializeComponent();
        }

        private void showButton_Click(object sender, RoutedEventArgs e)
        {
            // warning
            MessageBox.Show("The age must be over 18!",
                "Age is out of range!",
                MessageBoxButton.OK,
                MessageBoxImage.Exclamation);

            // question
            if (MessageBox.Show("Do you want to buy this?",
                    "CD Purchase",
                    MessageBoxButton.YesNo,
                    MessageBoxImage.Question) == MessageBoxResult.Yes)
            {
                MessageBox.Show("User clicked yes");
            }
            else
            {
                MessageBox.Show("User clicked no");
            }

            // testvraag 18.8
            if (MessageBox.Show("Is Parijs de hoofdstad van Frankrijk?",
                    "Quiz",
                    MessageBoxButton.YesNo,
                    MessageBoxImage.Question) == MessageBoxResult.Yes)
            {
                MessageBox.Show("Ja - correct!");
            }
            else
            {
                MessageBox.Show("Sorry: verkeerd");
            }
        }
    }
}
