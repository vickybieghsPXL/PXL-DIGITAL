using System;
using System.Collections.Generic;
using System.IO;
using System.Linq;
using System.Threading;

namespace MasterMind.Data.DomainClasses
{
    public class Game : IGame
    {
        private int _currentRound;
        private Dictionary<Guid, int> _guesses;
        private IPlayer _winner;
        private IPlayer[] _Roundwinners; 
        public Guid Id { get; set; }
        public GameSettings Settings { get; set; }
        public IList<IPlayer> Players { get; }
        public string[] PossibleColors { get; }
        public int CurrentRound => _currentRound;
        private string[] _codeToGuess;
        
        /// <summary>
        /// Constructs a Game object and generates a code to guess.
        /// </summary>
        public Game(GameSettings settings, IList<IPlayer> players)
        {
            Settings = settings;
            Players = players;
            _currentRound = 1;

            //init guesses
            _guesses = new Dictionary<Guid, int>();
            InitGuesses();

            //init possible colors
            PossibleColors = new string[settings.AmountOfColors];
            InitPossibleColors(Settings.AmountOfColors);

            _codeToGuess = new string[settings.CodeLength];

            //generate codeToGuess
            GenerateCode(settings.DuplicateColorsAllowed);

            _Roundwinners = new IPlayer[settings.AmountOfRounds];

        }

        private void GenerateCode(bool duplicateColorsAllowed)
        {
            if (duplicateColorsAllowed)
            {
                GenerateCodeWithDuplicateColorsAllowed();
            }
            else
            {
                GenerateCodeWithDuplicateColorsNotAllowed();
            }
        }

        private void GenerateCodeWithDuplicateColorsNotAllowed()
        {
            Random r = new Random();

            bool[] used = new bool[PossibleColors.Length];

            for (int i = 0; i < _codeToGuess.Length; i++)
            {
                int randomIndex = r.Next(PossibleColors.Length);

                while (used[randomIndex])
                {
                    randomIndex = r.Next(PossibleColors.Length);
                }
                used[randomIndex] = true;
                _codeToGuess[i] = PossibleColors[randomIndex];
            }
        }

        private void GenerateCodeWithDuplicateColorsAllowed()
        {
            Random r = new Random();

            for (int i = 0; i < _codeToGuess.Length; i++)
            {
                int randomIndex = r.Next(PossibleColors.Count());
                _codeToGuess[i] = PossibleColors[randomIndex];
            }
        }


        private void InitPossibleColors(int length)
        {
            string[] Colors = { "cyan", "lightblue", "magenta", "purple", "red", "orange", "yellow", "lightgreen" };

            for (int i = 0; i < length; i++)
            {
                PossibleColors[i] = Colors[i];
            }
        }

        private void InitGuesses()
        {
            foreach (IPlayer p in Players)
            {
                _guesses.Add(p.Id, 0);
            }
        }

        private void RemoveGuesses()
        {
            foreach (IPlayer p in Players)
            {
                _guesses[p.Id] = 0;
            }
        }

        public CanGuessResult CanGuessCode(IPlayer player, int roundNumber)
        {
            int min = _guesses.OrderBy(kvp => kvp.Value).First().Value;
            int max = _guesses.OrderBy(kvp => kvp.Value).Last().Value;
            
            if (_guesses[player.Id] == Settings.MaximumAmountOfGuesses)
            {
                return CanGuessResult.MaximumReached;
            }
            
            else if ( _guesses[player.Id] > min && Settings.Mode != GameMode.Fast)
            {
                return CanGuessResult.MustWaitOnOthers;
            }
            else if (roundNumber > _currentRound)
            {
                return CanGuessResult.RoundNotStarted;
            }
            else if (roundNumber < _currentRound)
            {
                return CanGuessResult.NotAllowedDueToGameStatus;
            }
            else if (_guesses[player.Id] <= max)
            {
                return CanGuessResult.Ok;
            }
            else
            {
                return CanGuessResult.RoundNotStarted;
            }
        }

        private bool MaximumGuessesForEveryone() {

            foreach (IPlayer p in Players)
            {
                if (_guesses[p.Id] != Settings.MaximumAmountOfGuesses)
                {
                    return false;
                }
            }
            return true;

        }

        public GuessResult GuessCode(string[] colors, IPlayer player)
        {
            GuessResult g = new GuessResult(colors);
            _guesses[player.Id]++;
            g.Verify(_codeToGuess);

            if (g.CorrectColorAndPositionAmount == Settings.CodeLength || MaximumGuessesForEveryone())
            {
                IPlayer winner;
                if (MaximumGuessesForEveryone())
                {
                    winner = new User
                    {
                        NickName = "Nobody"
                    };

                }
                else
                {
                    winner = player;
                }

                RemoveGuesses();
                _winner = winner;
                _Roundwinners[_currentRound - 1] = winner;
                _currentRound++;
                GenerateCode(Settings.DuplicateColorsAllowed);
            }
            
            return g;
        }

        public GameStatus GetStatus()
        {
            GameStatus status = new GameStatus
            {
                CurrentRoundNumber = _currentRound,
                RoundWinners = _Roundwinners
            };

            if (_winner != null)
            {
                status.FinalWinner = _winner;
                status.GameOver = true;
                _winner = null;
                
            }

            return status;
        }
    }
}
