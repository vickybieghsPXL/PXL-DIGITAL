using System;

namespace BikeRent
{
    public class Bike : BikeBase
    {
        public override int KmPerMaintenanceCycle => 10000;
    }
}
