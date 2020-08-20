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
        private string title;
        private string name;
        private string password;
        private string notes;
        AccountInfo info;
        private DateTime expiration;

        public CreateAccountInfoWindow()
        {
            InitializeComponent();
            
        }
        public AccountInfo GetNewAccount()
        {
            return info;
        }
        private void CreateButton_Click(object sender, RoutedEventArgs e)
        {
            title = titleTextBox.Text;
            name = usernameTextBox.Text;
            password = passwordTextBox.Text;
            notes = notesTextBox.Text;
            info = new AccountInfo(title, name, password, notes, expiration);
        }

        private void ExpirationSlider_ValueChanged(object sender, RoutedPropertyChangedEventArgs<double> e)
        {
            int value = Convert.ToInt32(expirationSlider.Value);
            DateTime date = new DateTime();
            date.AddDays(value +1);
            expirationDateTextBlock.Text = Convert.ToString(date);
            expiration = date;
        }

        private void PasswordTextBox_TextChanged(object sender, TextChangedEventArgs e)
        {
            passwordTextBox.Text = Convert.ToString(PasswordValidator.CalculateStrength(password));
        }
    }
}
