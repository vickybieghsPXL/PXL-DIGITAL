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

namespace PixelPass
{
    /// <summary>
    /// Interaction logic for CreateOrUpdateAccountInfoWindow.xaml
    /// </summary>
    public partial class CreateAccountInfoWindow : Window
    {
        IAccountInfoCollection _accountInfoCollection;
        ListBox _accountListBox;
        public CreateAccountInfoWindow(IAccountInfoCollection accountInfoCollection, ListBox accountListBox)
        {
            InitializeComponent();
            _accountInfoCollection = accountInfoCollection;
            _accountListBox = accountListBox;
            expirationSlider.ValueChanged += ExpirationSlider_ValueChanged;
            expirationSlider.Minimum = DateTime.Now.Day + 1;
            expirationDateTextBlock.Text = $"{expirationSlider.Minimum}/{DateTime.Now.Month}/{DateTime.Now.Year}";
            

        }

        private void ExpirationSlider_ValueChanged(object sender, RoutedPropertyChangedEventArgs<double> e)
        {
            expirationDateTextBlock.Text = $"{Convert.ToInt32(expirationSlider.Value)}/{ DateTime.Now.Month}/{DateTime.Now.Year}";
        }

        private void CreateButton_Click(object sender, RoutedEventArgs e)
        {
            string title = titleTextBox.Text;
            string username = usernameTextBox.Text;
            string password = passwordTextBox.Text;
            string notes = notesTextBox.Text;
            int[] dateInt = Array.ConvertAll(expirationDateTextBlock.Text.Split('/'),int.Parse);
            DateTime date = new DateTime(dateInt[2], dateInt[1], dateInt[0]);
            AccountInfo accountInfo = new AccountInfo(title, username, password, notes, date);
            _accountInfoCollection.AccountInfos.Add(accountInfo);
            _accountListBox.Items.Refresh();
            Close();
        }

        private void PasswordTextBox_TextChanged(object sender, TextChangedEventArgs e)
        {
            string pass = passwordTextBox.Text;
            passwordStrengthTextBlock.Text = Convert.ToString(PasswordValidator.CalculateStrength(pass));
         
        }
    }
}
