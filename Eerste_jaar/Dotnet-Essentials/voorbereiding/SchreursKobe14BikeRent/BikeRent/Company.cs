using System;
using System.Collections.Generic;

namespace BikeRent
{
    public class Company
    {
        private int _currentBikeIndex;

        public Company()
        {
            Bikes = CreateBikeCatalog();
            CreateRentalTestData();
        }    

        public List<BikeBase> Bikes { get; set; }

        //ToDo: Modify CurrentBike so that it returns the current bike
        public BikeBase CurrentBike
        {
            get { return Bikes[_currentBikeIndex]; }
        }

        //ToDo: change _currentBikeIndex to make the next bike current
        //      If you are at the end of the Bikes list, just start at the beginning.
        public void Next()
        { 
            if(_currentBikeIndex +1 >= Bikes.Count)
            {
                _currentBikeIndex = 0;
            }
            else
            {
                _currentBikeIndex++;
            }
        }
        
        private List<BikeBase> CreateBikeCatalog()
        {
            return new List<BikeBase>()
            {
                new Bike()
                {
                    Id = 1,
                    Brand = "Trek",
                    Type = "Stadsfiets",
                    Description = "Praktische fiets voor kleine verplaatsingen.",
                    Gender = Gender.Male,
                    PricePerDay = 10,
                    TotalDistance = 4500,
                    LastMaintenanceDate = new DateTime(2019, 09, 23)
                },
                new Bike()
                {
                    Id = 2,
                    Brand = "Trek",
                    Type = "Stadsfiets",
                    Description = "Praktische fiets voor kleine verplaatsingen.",
                    Gender = Gender.Female,
                    PricePerDay = 10,
                    TotalDistance = 1500,
                    LastMaintenanceDate = new DateTime(2020, 02, 01)
                },
                new Bike()
                {
                    Id = 3,
                    Brand = "Trek",
                    Type = "Mountain Bike",
                    Description = "Sportieve fiets om alle bospaadjes te verkennen.",
                    Gender = Gender.Male,
                    PricePerDay = 15,
                    TotalDistance = 500,
                    LastMaintenanceDate = new DateTime(2020, 01, 05)
                },
                new Bike()
                {
                    Id = 4,
                    Brand = "Trek",
                    Type = "Koersfiets",
                    Description = "Ideaal voor de coureurs onder u",
                    Gender = Gender.Female,
                    PricePerDay = 15,
                    TotalDistance = 10000,
                    LastMaintenanceDate = DateTime.MinValue
                },
                new Bike()
                {
                    Id = 5,
                    Brand = "Gazelle",
                    Type = "Stadsfiets",
                    Description = "Praktische fiets voor kleine verplaatsingen.",
                    Gender = Gender.Male,
                    PricePerDay = 10,
                    TotalDistance = 8000,
                    LastMaintenanceDate = new DateTime(2020, 03, 24)
                },
                new Bike()
                {
                    Id = 5,
                    Brand = "Gazelle",
                    Type = "Stadsfiets",
                    Description = "Praktische fiets voor kleine verplaatsingen.",
                    Gender = Gender.Female,
                    PricePerDay = 10,
                    TotalDistance = 9500,
                    LastMaintenanceDate = new DateTime(2020, 03, 24)
                },
                new Bike()
                {
                    Id = 6,
                    Brand = "Gazelle",
                    Type = "Stadsfiets",
                    Description = "Praktische fiets voor kleine verplaatsingen.",
                    Gender = Gender.Male,
                    PricePerDay = 10,
                    TotalDistance = 0,
                    LastMaintenanceDate = DateTime.MinValue
                },
                new Bike()
                {
                    Id = 7,
                    Brand = "Gazelle",
                    Type = "Stadsfiets",
                    Description = "Praktische fiets voor kleine verplaatsingen.",
                    Gender = Gender.Female,
                    PricePerDay = 10,
                    TotalDistance = 0,
                    LastMaintenanceDate = DateTime.MinValue
                },
                new Bike()
                {
                    Id = 9,
                    Brand = "Kettler",
                    Type = "Stadsfiets",
                    Description = "Praktische fiets voor kleine verplaatsingen.",
                    Gender = Gender.Male,
                    PricePerDay = 10,
                    TotalDistance = 2500,
                    LastMaintenanceDate = new DateTime(2019, 10, 10)
                },
                new Bike()
                {
                    Id = 10,
                    Brand = "Kettler",
                    Type = "Stadsfiets",
                    Description = "Praktische fiets voor kleine verplaatsingen.",
                    Gender = Gender.Female,
                    PricePerDay = 10,
                    TotalDistance = 7000,
                    LastMaintenanceDate = new DateTime(2019, 11, 8)
                },
                new EBike()
                {
                    Id = 11,
                    Brand = "Kettler",
                    Type = "Stadsfiets",
                    Gender = Gender.Female,
                    Description = "Praktische fiets voor langere verplaatsingen op de vlakke weg.",
                    TotalDistance = 7000,
                    PricePerDay = 20,
                    LastMaintenanceDate = new DateTime(2019, 11, 8),
                    BatteryCapacity = 400
                },
                new EBike()
                {
                    Id = 12,
                    Brand = "Gazelle",
                    Type = "Stadsfiets",
                    Gender = Gender.Male,
                    Description = "Praktische fiets voor langere verplaatsingen op de vlakke weg.",
                    TotalDistance = 8000,
                    PricePerDay = 20,
                    LastMaintenanceDate = new DateTime(2020, 01, 30),
                    BatteryCapacity = 500
                }
            };
        }

        private void CreateRentalTestData()
        {
            Bikes[2].Rent(new DateTime(2020, 3, 2), 7, "Marc Van Ranst");
            Bikes[2].Return(535);

            Bikes[2].Rent(new DateTime(2020, 3, 10), 3, "Steven Van Gucht");
            Bikes[2].Return(341.5);

            Bikes[2].Rent(new DateTime(2020, 3, 15), 10, "Koen Wauters");
            Bikes[2].Return(788);

            Bikes[1].Rent(new DateTime(2020, 6, 28), 5, "Erika Vlieghe");
        }
    }
}
