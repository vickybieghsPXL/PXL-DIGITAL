using Microsoft.Win32;
using System;
using System.Collections.Generic;
using System.IO;
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

namespace PixelPass
{
    /// <summary>
    /// Interaction logic for MainWindow.xaml
    /// </summary>
    public partial class MainWindow : Window
    {
        private IAccountInfoCollection _accountInfoCollection;
        private AccountInfo _currentAccountInfo;
        private DispatcherTimer timer = new DispatcherTimer();
        private int seconds = 0;

        public MainWindow()
        {
            InitializeComponent();
        }

        private void OpenItem_Click(object sender, RoutedEventArgs e)
        {
            OpenFileDialog dialog = new OpenFileDialog
            {
                InitialDirectory = Environment.GetFolderPath(Environment.SpecialFolder.Desktop),
                Filter = "Text Files | *.txt",
                FilterIndex = 1
            };
            if (dialog.ShowDialog() == true)
            {
                StreamReader reader = File.OpenText(dialog.FileName);
                string title = reader.ReadLine();
                try
                {
                    if (!title.Contains("Name:"))
                    {
                        throw new FormatException();

                    }
                    else
                    {
                        title = title.TrimStart('N', 'a', 'm', 'e', ':');
                        Title = "PixelPass -" + title;
                    }
                }
                catch (FormatException)
                {
                    MessageBox.Show(dialog.FileName + "\n" + "Invalid document, first line must contain 'Name:' ");
                }
                _accountInfoCollection = AccountInfoCollectionReader.Read(dialog.FileName);
            }
            foreach(AccountInfo item in _accountInfoCollection.AccountInfos)
            {
                accountInfoListBox.Items.Add(item);
            }
            newAccountInfoButton.IsEnabled = true;
            
        }

        private void CopyButton_Click(object sender, RoutedEventArgs e)
        {
            int index = accountInfoListBox.SelectedIndex;
            //Clipboard.SetText(_accountInfoCollection.AccountInfos);
            timer.Interval = TimeSpan.FromSeconds(0.1);
            timer.Tick -= Timer_Tick;
            timer.Start();
        }
        public void Timer_Tick(object sender, EventArgs e)
        {
            expirationProgressBar.Value = seconds;
            seconds--;
            if (seconds == 0)
            {
                seconds = 6;
            }
        }

        private void NewAccountInfoButton_Click(object sender, RoutedEventArgs e)
        {
            var window = new CreateAccountInfoWindow();
            window.Show();

        }
    }
}
