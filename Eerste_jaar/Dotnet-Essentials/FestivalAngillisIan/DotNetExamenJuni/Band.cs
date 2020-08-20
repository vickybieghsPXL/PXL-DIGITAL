using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace DotNetExamenJuni
{
    public class Band : Performer
    {
        public int MemberCount { get; set; }

        public Band(int newMemberCount, string newName, int newReservationNumber, string newStartTime, string newEndTime, int[] supplies, List<string> rider)
            :base(newName, newReservationNumber, newStartTime, newEndTime, supplies, rider)
        {
            this.MemberCount = newMemberCount;
        }
    }
}