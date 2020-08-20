using Microsoft.Win32;
using System;
using System.IO;
using System.Windows;
using System.Windows.Controls;
using System.Windows.Media;
using System.Windows.Threading;

namespace PixelPass
{
    /// <summary>
    /// Interaction logic for MainWindow.xaml
    /// </summary>
    public partial class MainWindow : Window
    {
        private IAccountInfoCollection _accountInfoCollection;
        private AccountInfo _currentAccountInfo;
        DispatcherTimer _timer;

        public object DataTime { get; private set; }

        public MainWindow()
        {
            InitializeComponent();
        }

        private void OpenItem_Click(object sender, RoutedEventArgs e)
        {
            OpenFileDialog openFileDialog = new OpenFileDialog();
            string startDir = Environment.GetFolderPath(Environment.SpecialFolder.Desktop);
            openFileDialog.InitialDirectory = startDir;
            openFileDialog.Filter = "Text Files|*.txt|All files|*.*";

            if (openFileDialog.ShowDialog() == true)
            {
                string myFile = openFileDialog.FileName;
                _accountInfoCollection = AccountInfoCollectionReader.Read(myFile);
                try
                {
                Title = $"PixelPass - {_accountInfoCollection.Name}";
                }
                catch (NullReferenceException)
                {

                }
                try
                {
                accountInfoListBox.ItemsSource = _accountInfoCollection.AccountInfos;
                }
                catch (NullReferenceException)
                {

                }
            }
        }

        private void SaveItem_Click(object sender, RoutedEventArgs e)
        {

        }

        private void ExitItem_Click(object sender, RoutedEventArgs e)
        {
            Environment.Exit(0);
        }

        private void AccountInfoListBox_SelectionChanged(object sender, System.Windows.Controls.SelectionChangedEventArgs e)
        {
            newAccountInfoButton.IsEnabled = true;
            //Accountgegevens inladen bij elke wijziging van de selectie.
            AccountInfo account = (AccountInfo)((ListBox)sender).SelectedItem;
            titleTextBlock.Text = account.Title;
            usernameTextBlock.Text = account.Username;
            copyButton.IsEnabled = !account.IsExpired;
            notesTextBlock.Text = account.Notes;
            expirationTextBlock.Text = account.Expiration.ToShortDateString();

            //Als het paswoord vervallen is, paswoord laten zien, achtergrond rood maken.
            if (!copyButton.IsEnabled)
            {
                detailsCanvas.Background = new SolidColorBrush(Colors.LightCoral);
                expirationProgressBar.Value = 0;
            }
            else
            {
                expirationProgressBar.Value = expirationProgressBar.Maximum;
                detailsCanvas.Background = new SolidColorBrush(Colors.White);
            }
            _currentAccountInfo = account;
        }

        private void CopyButton_Click(object sender, RoutedEventArgs e)
        {
            expirationProgressBar.Value = expirationProgressBar.Maximum;
            _timer = new DispatcherTimer();
            Clipboard.SetText(_currentAccountInfo.Password);
            _timer.Tick += Timer_Tick;
            _timer.Interval = TimeSpan.FromSeconds(1);
            _timer.Start();
        }

        private void Timer_Tick(object sender, EventArgs e)
        {
            expirationProgressBar.Value -= expirationProgressBar.Maximum * 0.2;
            if (expirationProgressBar.Value == 0)
            {
                Clipboard.Clear();
                MessageBox.Show("Tijd is om");
                _timer.Stop();
            }
        }

        private void NewAccountInfoButton_Click(object sender, RoutedEventArgs e)
        {
            CreateAccountInfoWindow window = new CreateAccountInfoWindow(_accountInfoCollection, accountInfoListBox);
            window.ShowDialog();
        }
    }
}
