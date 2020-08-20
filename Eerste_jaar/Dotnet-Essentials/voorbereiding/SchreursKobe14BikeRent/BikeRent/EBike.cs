namespace BikeRent
{
    public class EBike : BikeBase
    {
        public int BatteryCapacity { get; set; }
        public override int KmPerMaintenanceCycle => 7500;
    }
}
