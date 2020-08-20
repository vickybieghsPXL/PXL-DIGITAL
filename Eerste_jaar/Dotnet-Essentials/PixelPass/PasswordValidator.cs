using System;

namespace PixelPass
{
    public class PasswordValidator
    {
        private const int MinimumLength = 5;
        private const int AverageLength = 10;

        private const string alfabetSmallCaps = "abcdefghijklmnopqrstuvwxyz";
        private const string alfabetUpperCaps = "ABCEDFGHIJKLMNOPQRSTUVWXYZ";
        private const string digits = "0123456789";

        public static Strength CalculateStrength(string password)
        {
            if (password.Length < MinimumLength|| !password.Contains(alfabetUpperCaps) || !password.Contains(digits))
            {
                return Strength.Weak;
            }
            else if(password.Length > MinimumLength && password.Contains(alfabetUpperCaps) && password.Contains(alfabetSmallCaps) {
                return Strength.Average;
            }
            else
            {
                return Strength.Strong;
            }
        }
    }

    public enum Strength
    {
        Weak,
        Average,
        Strong
    }
}