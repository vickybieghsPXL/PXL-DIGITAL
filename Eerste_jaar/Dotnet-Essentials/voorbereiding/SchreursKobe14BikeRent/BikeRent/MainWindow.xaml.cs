using System;
using System.IO;
using System.Security.Policy;
using System.Windows;
using System.Windows.Media;
using System.Windows.Media.Imaging;

namespace BikeRent
{
    /// <summary>
    /// Interaction logic for MainWindow.xaml
    /// </summary>
    public partial class MainWindow : Window
    {
        private Company _company;

        private BitmapImage _maleBikeImage;
        private BitmapImage _femaleBikeImage;
        private BitmapImage _electricalImage;
        private BikeBase _currentBike;
        public MainWindow()
        {
            InitializeComponent();

            _maleBikeImage = ImageUtils.CreateBitmapImage("Images/MaleBike.png");
            _femaleBikeImage = ImageUtils.CreateBitmapImage("Images/FemaleBike.png");
            _electricalImage = ImageUtils.CreateBitmapImage("Images/Electrical.png");

            _company = new Company();
            
            BindCurrentBike(_company.CurrentBike);
        }

        private void nextButton_Click(object sender, RoutedEventArgs e)
        {
            _company.Next();
            BindCurrentBike(_company.CurrentBike);
        }

        private void BindCurrentBike(BikeBase bike)
        {
            _currentBike = bike;
            // ToDo:
            //  - Place info on the screen
            //  - look at the screenshots to know exactly what and when
            if(bike.Gender == Gender.Male)
            {
                genderImage.Source = _maleBikeImage;
            }
            else
            {
                genderImage.Source = _femaleBikeImage;
            }
            //
            idTextBlock.Text = bike.Id.ToString("000");
            typeTextBlock.Text = bike.Type;
            maintenanceTextBlock.Text = bike.TotalDistance + " / " + bike.KmPerMaintenanceCycle;
            brandTextBlock.Text = bike.Brand;
            descriptionTextBlock.Text = bike.Description;
            maintenanceProgressBar.Value = bike.TotalDistance;
            Rental rental = bike.FindCurrentRental();

            EBike eBike = new EBike();
            if (object.ReferenceEquals(eBike, bike))
            {
                eBike = (EBike)bike;
                batteryTextBlock.Visibility = Visibility.Visible;
                batteryTextBlock.Text = eBike.BatteryCapacity.ToString();
                electricalImage.Visibility = Visibility.Visible;
            }
            else
            {
                electricalImage.Visibility = Visibility.Hidden;
                batteryTextBlock.Visibility = Visibility.Hidden;
            }
            if (bike.IsOccupied)
            {
                rentStatusTextBlock.Visibility = Visibility.Visible;
                rentStatusTextBlock.Text = "Verhuurd aan " + rental.Customer + " tot " + rental.EndDate.ToShortDateString();
                rentOrReturnButton.Content = "Retour";
            }
            else
            {
                rentStatusTextBlock.Visibility = Visibility.Hidden;
                rentOrReturnButton.Content = "Huur";
            }
            rentOrReturnButton.IsEnabled = true;
            if (bike.TotalDistance > bike.KmPerMaintenanceCycle)
            {
                rentOrReturnButton.IsEnabled = false;
            }
           

        }

        private void rentOrReturnButton_Click(object sender, RoutedEventArgs e)
        {
            // ToDo: Show a new RentalWindow object as a modal dialog
            //       and pass along the information from the CurrentBike.
            //       After the RentalWindow is closed, update the information in
            //       this window.
            RentalWindow rentalWindow = new RentalWindow(_currentBike);
            rentalWindow.Show();
            
        }

        private void exportItem_Click(object sender, RoutedEventArgs e)
        {
            // ToDo

            string filename = "fiets_" + _currentBike.Id;
            string pathFile = Path.Combine(Environment.GetFolderPath(Environment.SpecialFolder.Desktop), filename);
            StreamWriter streamWriter = File.CreateText(pathFile);
            ReportUtils.CreateReport(_currentBike);
            //  Create a report on the desktop of the current user
            //  report name: e.g. Bike_003.html (use Id property)
            //  Use CreateReport from ReportUtils   
        }

        private void exitItem_Click(object sender, RoutedEventArgs e)
        {
            Environment.Exit(0);
        }
    }
}
