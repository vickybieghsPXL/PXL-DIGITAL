using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace PixelPass
{
    public class AccountInfoCollection : IAccountInfoCollection 
    {
		public string Name { get; set; }
		public List<AccountInfo> AccountInfos { get; }
		public AccountInfoCollection()
		{
			this.AccountInfos = new List<AccountInfo>();
		}
	}
}
