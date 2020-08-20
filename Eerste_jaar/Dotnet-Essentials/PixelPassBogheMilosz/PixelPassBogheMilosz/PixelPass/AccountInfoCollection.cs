using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace PixelPass
{
    public class AccountInfoCollection : IAccountInfoCollection
    {
        public AccountInfoCollection(string name)
        {
            Name = name;
            AccountInfos = new List<AccountInfo>();
        }
        public string Name { get; set; }
        public List<AccountInfo> AccountInfos { get; set; }
    }
}
