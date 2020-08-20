using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace DotNetExamenJuni
{
    class FestivalException:ApplicationException
    {
        public FestivalException(string message) : base(message)
        {
           
        }
    }
}
