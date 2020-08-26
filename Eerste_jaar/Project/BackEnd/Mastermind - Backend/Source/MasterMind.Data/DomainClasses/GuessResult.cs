using System.Collections.Generic;
using System.Linq;

namespace MasterMind.Data.DomainClasses
{
    public class GuessResult
    {
        private int _correctColorAndPositionAmount;
        private int _correctColorAmount;

        public string[] Colors { get; set; }

        public virtual int CorrectColorAndPositionAmount => _correctColorAndPositionAmount; //must be virtual for some automated test to work!

        public virtual int CorrectColorAmount => _correctColorAmount; //must be virtual for some automated test to work!

        public GuessResult(string[] colors)
        {
            Colors = colors;

        }

        public void Verify(string[] codeToGuess)
        {
            
            bool[] usedPlace = new bool[codeToGuess.Length];
            for (int i = 0; i < codeToGuess.Length; i++)
            {
                if (Colors[i] == codeToGuess[i])
                {
                    _correctColorAndPositionAmount++;
                }
                else
                {
                    for (int j = 0; j < codeToGuess.Length; j++)
                    {
                        if (codeToGuess[j] != Colors[j] && Colors[i] == codeToGuess[j] && !usedPlace[j])
                        {
                            _correctColorAmount++;
                            usedPlace[j] = true;
                            break;

                        }
                    } 
                }
            }
        }
    }
}