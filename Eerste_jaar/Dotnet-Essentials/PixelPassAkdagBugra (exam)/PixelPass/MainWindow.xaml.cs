using Microsoft.Win32;
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
using System.Windows.Navigation;
using System.Windows.Shapes;
using System.Windows.Threading;
using System.IO;

namespace PixelPass
{
    /// <summary>
    /// Interaction logic for MainWindow.xaml
    /// </summary>
    public partial class MainWindow : Window
    {
        private IAccountInfoCollection _accountInfoCollection;
        private AccountInfo _currentAccountInfo;
		private int countDownForCopy = 0;
		private DispatcherTimer timer = null;


	   public MainWindow()
        {
            InitializeComponent();
        }

		private void OpenItem_Click(object sender, RoutedEventArgs e)
		{
			OpenFileDialog fileDialog = new OpenFileDialog();
			string folderPath = Environment.GetFolderPath(Environment.SpecialFolder.MyDocuments);
			fileDialog.InitialDirectory = folderPath;
			if (fileDialog.ShowDialog() == true)
			{
				/* Opening file */
				string textFilePath = fileDialog.FileName;

				StreamReader reader = null;
				try
				{
					reader = File.OpenText(textFilePath);
					string line = reader.ReadLine();
					if (line.Substring(0, 5) == "Name:")
					{
						this.Title = "PixelPass - " + line.Substring(6);
						line = reader.ReadLine();
						_accountInfoCollection = AccountInfoCollectionReader.Read(textFilePath);
						accountInfoListBox.ItemsSource = _accountInfoCollection.AccountInfos;
						accountInfoListBox.SelectedIndex = 1;
						newAccountInfoButton.IsEnabled = true;
					}
					else
					{
						throw new ParseException(textFilePath + " seems corrupt." + Environment.NewLine + Environment.NewLine + "Details: " + Environment.NewLine + Environment.NewLine + textFilePath + " does not start with \"Name:\"");
					}
				}
				catch (FileNotFoundException)
				{
					MessageBox.Show("No such file was found");
				}
				catch (ParseException eMessage)
				{
					MessageBox.Show(eMessage.Message, "Error", MessageBoxButton.OK, MessageBoxImage.Error);
				}
				finally
				{
					reader?.Close();
				}
			}
		}

		private void AccountInfoListBox_SelectionChanged(object sender, SelectionChangedEventArgs e)
		{
			_currentAccountInfo = _accountInfoCollection.AccountInfos[accountInfoListBox.SelectedIndex];
			titleTextBlock.Text = _currentAccountInfo.Title;
			usernameTextBlock.Text = _currentAccountInfo.Username;
			notesTextBlock.Text = _currentAccountInfo.Notes;
			expirationTextBlock.Text = _currentAccountInfo.Expiration.ToShortDateString();
			if (_currentAccountInfo.IsExpired)
			{
				detailsCanvas.Background = new SolidColorBrush(Colors.LightCoral);
				copyButton.IsEnabled = false;

			}
			else
			{
				detailsCanvas.Background = new SolidColorBrush(Colors.White);
				copyButton.IsEnabled = true;
			}
		}


		private void CopyButton_Click(object sender, RoutedEventArgs e)
		{
			timer = new DispatcherTimer();
			timer.Interval = TimeSpan.FromSeconds(1);
			timer.Tick += Timer_Tick;
			countDownForCopy = 5;
			timer.Start();
			Clipboard.SetText(_currentAccountInfo.Password);
			expirationProgressBar.Value = 5;

		}

		private void Timer_Tick(object sender, EventArgs e)
		{
			if (countDownForCopy > 0)
			{
				countDownForCopy--;
				expirationProgressBar.Value = countDownForCopy;
			}
			else
			{
				Clipboard.Clear();
				timer.Stop();
			}
		}

		private void NewAccountInfoButton_Click(object sender, RoutedEventArgs e)
		{
			CreateAccountInfoWindow w = new CreateAccountInfoWindow(this, ref accountInfoListBox, ref _accountInfoCollection);
			w.Show();
			this.Hide();
		}
	}
}
