﻿using System;
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

namespace Testvragen_h2
{
    /// <summary>
    /// Interaction logic for MainWindow.xaml
    /// </summary>
    public partial class MainWindow : Window
    {
        public MainWindow()
        {
            InitializeComponent();
        }

        private void halloButton_Click(object sender, RoutedEventArgs e)
        {
            MessageBox.Show("Hello World");
        }

        private void eindeButton_Click(object sender, RoutedEventArgs e)
        {
            MessageBox.Show("goodbye cruel world");
        }
    }
}
