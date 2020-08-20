using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace DotNetExamenJuni
{
    public abstract class Performer
    {
        //instance variables and properties
        public string Name { get; set; }
        public int ReservationNumber { get; set; }
        public TimeSpan StartTime { get; set; }
        public TimeSpan EndTime { get; set; }
        public int[] TechnicalSupplies { get; set; }
        public List<string> Rider { get; set; }

        public Performer(string newName, int newReservationNumber, string newStartTime, string newEndTime, int[] supplies, List<string> rider)
        {
            this.Name = newName;
            this.ReservationNumber = newReservationNumber;
            this.StartTime = ConvertStringToTimeSpan(newStartTime);
            this.EndTime = ConvertStringToTimeSpan(newEndTime);
            this.TechnicalSupplies = supplies;
            this.Rider = rider;
        }

        //Public methodes
        public override string ToString()
        {
            return AddZerosToTime(Convert.ToString(StartTime.Hours)) + ":" + AddZerosToTime(Convert.ToString(StartTime.Minutes)) + "-" + AddZerosToTime(Convert.ToString(EndTime.Hours)) + ":" + AddZerosToTime(Convert.ToString(EndTime.Minutes)) + "  " + Name;
        }

        //Private methods
        private string AddZerosToTime(string time)
        {
            if(time.Length == 1)
            {
                return "0" + time;
            }
            else
            {
                return time;
            }
        }

        private TimeSpan ConvertStringToTimeSpan(string time)
        {
            string[] temp = time.Split(':');

            return new TimeSpan(Convert.ToInt32(temp[0]), Convert.ToInt32(temp[1]), 0);
        }
    }
}
