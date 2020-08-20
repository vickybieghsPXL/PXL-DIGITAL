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
			int score = 0;
			int symbolScore = 0;
			bool hasDigit = false, hasUpper = false, hasLower = false;

			if (password.Length < MinimumLength) { return Strength.Weak; }

			for (int i = 0; i < password.Length; i++)
			{
				string letter = password.Substring(i, 1);
				if (alfabetSmallCaps.Contains(letter) && !hasLower)
				{
					hasLower = true;
					symbolScore += 1;
				}
				if (alfabetUpperCaps.Contains(letter) && !hasUpper)
				{
					hasUpper = true;
					symbolScore += 1;
				}
				if (digits.Contains(letter) && !hasDigit)
				{
					hasDigit = true;
					symbolScore += 1;
				}
			}
			if (symbolScore == 1) { return Strength.Weak; }
			else if (password.Length >= MinimumLength && password.Length < AverageLength && symbolScore == 2) { return Strength.Average; }
			else{
				if (password.Length > AverageLength) { return Strength.Strong; } else { return Strength.Average; }
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