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
		public MainWindow _homeScreen { get; set; }
		public ListBox _listAccounts { get; set; }
		public IAccountInfoCollection _list { get; set; }
		public CreateAccountInfoWindow(MainWindow homeScreen, ref ListBox listAccount, ref IAccountInfoCollection list)
        {
            InitializeComponent();
			this._homeScreen = homeScreen;
			this._listAccounts = listAccount;
			this._list = list;
			expirationSlider.Value = 1;
	}

		private void Window_Closing(object sender, System.ComponentModel.CancelEventArgs e)
		{
			this.Hide();
			_homeScreen.Show();
		}

		private void ExpirationSlider_ValueChanged(object sender, RoutedPropertyChangedEventArgs<double> e)
		{
			if (expirationDateTextBlock != null)
			{
				DateTime expireDate = DateTime.Now.AddDays(expirationSlider.Value);
				expirationDateTextBlock.Text = expireDate.ToShortDateString();
			}
		}

		private void CreateButton_Click(object sender, RoutedEventArgs e)
		{
			AccountInfo newAccount = new AccountInfo();
			newAccount.Title = titleTextBox.Text;
			newAccount.Username = usernameTextBox.Text;
			newAccount.Password = passwordTextBox.Text;
			newAccount.Notes = notesTextBox.Text;
			newAccount.Expiration = DateTime.Now.AddDays(expirationSlider.Value);
			_list.AccountInfos.Add(newAccount);
			_listAccounts.Items.Refresh();
			this.Close();
		}

		private void PasswordTextBox_TextChanged(object sender, TextChangedEventArgs e)
		{
			passwordStrengthTextBlock.Text = PasswordValidator.CalculateStrength(passwordTextBox.Text).ToString();
		}
	}
}
