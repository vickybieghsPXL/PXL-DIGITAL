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
using Microsoft.Win32;
using Toolbox.Inheritance;

namespace Toolbox
{
    /// <summary>
    /// Interaction logic for MainWindow.xaml
    /// </summary>
    public partial class MainWindow : Window
    {
        private SlidersWindow _sliderWindow;
        private ListBoxWindow _listBoxWindow;
        private DictionaryWindow _dictionaryWindow;
        private MessageBoxDialogWindow _messageBoxDialogWindow;
        private ShapesWindow _shapesWindow;
        private InheritanceWindow _inheritanceWindow;
        private MenuWindow _menuWindow;
        private DirectoryWindow _directoryWindow;
        private SwitchCaseWindow _switchCaseWindow;
        private StringsWindow _stringsWindow;
        private ProgressBarWindow _progressBarWindow;
        private FileReaderWindow _fileReaderWindow;
        private ComboBoxWindow _comboBoxWindow;
        private ExceptionWindow _exceptionWindow;
        private ArraysWindow _arraysWindow;
        private RadioButtonWindow _radioButtonWindow;
        private ClockWindow _clockWindow;
        private TimeSpanWindow _timeSpanWindow;
        private EnumWindow _enumWindow;
        private FileWriterWindow _fileWriterWindow;
        private InterfaceWindow _interfaceWindow;
        private ListBoxItemWindow _listBoxItemWindow;

        public MainWindow()
        {
            InitializeComponent();
        }

        private void sliderButton_Click(object sender, RoutedEventArgs e)
        {
            _sliderWindow = new SlidersWindow();
            _sliderWindow.Show();
        }

        private void listBoxButton_Click(object sender, RoutedEventArgs e)
        {
            _listBoxWindow = new ListBoxWindow();
            _listBoxWindow.Show();
        }

        private void shapesButton_Click(object sender, RoutedEventArgs e)
        {
            _shapesWindow = new ShapesWindow();
            _shapesWindow.Show();
        }

        private void dictionaryButton_Click(object sender, RoutedEventArgs e)
        {
            _dictionaryWindow = new DictionaryWindow();
            _dictionaryWindow.Show();
        }

        private void inheritanceButton_Click(object sender, RoutedEventArgs e)
        {
            _inheritanceWindow = new InheritanceWindow();
            _inheritanceWindow.Show();
        }

        private void menuButton_Click(object sender, RoutedEventArgs e)
        {
            _menuWindow = new MenuWindow();
            _menuWindow.Show();
        }

        private void directoryButton_Click(object sender, RoutedEventArgs e)
        {
            _directoryWindow = new DirectoryWindow();
            _directoryWindow.Show();
        }

        private void fileReaderButton_Click(object sender, RoutedEventArgs e)
        {
            _fileReaderWindow = new FileReaderWindow();
            _fileReaderWindow.Show();
        }

        private void switchCaseButton_Click(object sender, RoutedEventArgs e)
        {
            _switchCaseWindow = new SwitchCaseWindow();
            _switchCaseWindow.Show();
        }

        private void stringsButton_Click(object sender, RoutedEventArgs e)
        {
            _stringsWindow = new StringsWindow();
            _stringsWindow.Show();
        }

        private void minimiseButton_Click(object sender, RoutedEventArgs e)
        {
            this.WindowState = WindowState.Minimized;
        }

        private void progressBarButton_Click(object sender, RoutedEventArgs e)
        {
            _progressBarWindow = new ProgressBarWindow();
            _progressBarWindow.Show();
        }

        private void comboBoxButton_Click(object sender, RoutedEventArgs e)
        {
            _comboBoxWindow = new ComboBoxWindow();
            _comboBoxWindow.Show();
        }

        private void exceptionsButton_Click(object sender, RoutedEventArgs e)
        {
            _exceptionWindow = new ExceptionWindow();
            _exceptionWindow.Show();
        }

        private void arraysButton_Click(object sender, RoutedEventArgs e)
        {
            _arraysWindow = new ArraysWindow();
            _arraysWindow.Show();
        }

        private void radioButton_Click(object sender, RoutedEventArgs e)
        {
            _radioButtonWindow = new RadioButtonWindow();
            _radioButtonWindow.Show();
        }

        private void clockButton_Click(object sender, RoutedEventArgs e)
        {
            _clockWindow = new ClockWindow();
            _clockWindow.Show();
        }

        private void timeSpanButton_Click(object sender, RoutedEventArgs e)
        {
            _timeSpanWindow = new TimeSpanWindow();
            _timeSpanWindow.Show();
        }

        private void enumButton_Click(object sender, RoutedEventArgs e)
        {
            _enumWindow = new EnumWindow();
            _enumWindow.Show();
        }

        private void fileWriterButton_Click(object sender, RoutedEventArgs e)
        {
            _fileWriterWindow = new FileWriterWindow();
            _fileWriterWindow.Show();
        }

        private void interfaceButton_Click(object sender, RoutedEventArgs e)
        {
            _interfaceWindow = new InterfaceWindow();
            _interfaceWindow.Show();
        }

        private void listBoxItemButton_Click(object sender, RoutedEventArgs e)
        {
            _listBoxItemWindow = new ListBoxItemWindow();
            _listBoxItemWindow.Show();
        }
    }
}