namespace MasterMind.Data.DomainClasses
{
    public class GameStatus
    {
        /// <summary>
        /// Indicates if the game has an overall winner and the game is finished.
        /// </summary>
        public bool GameOver { get; set; }

        /// <summary>
        /// The number of the round that is currently in progress (or over when it is the last round and the game is over).
        /// </summary>
        public int CurrentRoundNumber { get; set; }

        /// <summary>
        /// For each round that is over, this array will contain the winner of that round.
        /// If there are 3 rounds and the 3th round is in progress, this array will contain 2 winners (of round 1 and round 2).
        /// </summary>
        public IPlayer[] RoundWinners { get; set; }

        /// <summary>
        /// The overall winner of the game. 
        /// If the game is not over this will be null.
        /// </summary>
        public IPlayer FinalWinner { get; set; }
    }
}