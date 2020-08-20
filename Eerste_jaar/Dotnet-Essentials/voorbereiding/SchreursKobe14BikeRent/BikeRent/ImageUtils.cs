using System;
using System.Windows.Media.Imaging;

namespace BikeRent
{
    public static class ImageUtils
    {
        public static BitmapImage CreateBitmapImage(string path)
        {
            BitmapImage bitmapImage = new BitmapImage();
            bitmapImage.BeginInit();
            bitmapImage.UriSource = new Uri(path, UriKind.Relative);
            bitmapImage.EndInit();
            return bitmapImage;
        }
    }
}
