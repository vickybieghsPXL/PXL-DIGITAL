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
            bool containsDigit = false;
            for(int i = 0; i < password.Length&&containsDigit==false; i++)
            {
                if(int.TryParse(Convert.ToString(password[i]), out int test))
                {
                    containsDigit = true;
                }
            }
            // niet op tijd gelukt voor cijferTest, al de rest werkt wel.
            if (password.Length < 5 || password.ToLower() == password || password.ToUpper() == password || int.TryParse(password, out int getal))
            {
                return Strength.Weak;
            }
            else if (password.Length >= 5 && (password.ToLower() != password || password.ToUpper() != password || containsDigit))
            {
                return Strength.Average;
            }
            else if (password.Length >= 10 && password.ToUpper() != password && password.ToLower() != password && containsDigit)
            {
                return Strength.Strong;
            }
            else
            {
                return Strength.Average; //Kon hier niets juist returnen, ik kon niet met else werken voor Strong omdat ik anders geen controle zou doen.
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