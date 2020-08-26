namespace MasterMind.Data.DomainClasses
{
    public class GameSettings
    {
        public int CodeLength { get; set; }
        public int AmountOfColors { get; set; }
        public bool DuplicateColorsAllowed { get; set; }
        public int MaximumAmountOfGuesses { get; set; }
        public int AmountOfRounds { get; set; }
        public GameMode Mode { get; set; }

        public GameSettings()
        {
            CodeLength = 4;
            AmountOfColors = 8;
            DuplicateColorsAllowed = false;
            MaximumAmountOfGuesses = 12;
            AmountOfRounds = 1;
            Mode = GameMode.Default;
        }
    }
}