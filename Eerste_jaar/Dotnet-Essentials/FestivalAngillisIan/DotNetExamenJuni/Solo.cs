using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace DotNetExamenJuni
{
    public class Solo : Performer
    {
        public string Type { get; set; }

        public Solo(string newType, string newName, int newReservationNumber, string newStartTime, string newEndTime, int[] supplies, List<string> rider)
            :base(newName, newReservationNumber, newStartTime, newEndTime, supplies, rider)
        {
            this.Type = newType;
        }
    }
}
