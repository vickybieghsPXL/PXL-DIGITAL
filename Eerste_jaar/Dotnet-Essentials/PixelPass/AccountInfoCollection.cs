using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using System.Windows.Controls;
using System.Windows;
using System.Windows.Media;
using System.Windows.Shapes;
using System.IO;
using Microsoft.Win32;
using System.Windows.Media.Imaging;
using System.Windows.Threading;

namespace PixelPass
{
    public class AccountInfoCollection : IAccountInfoCollection
    {
        public string Name { get; set; }
        public List<AccountInfo> AccountInfos { get; set; }
    }
}
