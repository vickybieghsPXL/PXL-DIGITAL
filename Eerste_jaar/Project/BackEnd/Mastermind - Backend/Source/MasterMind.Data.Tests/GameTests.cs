using Guts.Client.Shared.TestTools;
using MasterMind.Data.DomainClasses;
using MasterMind.TestTools.Builders;
using NUnit.Framework;
using System;
using System.Collections.Generic;
using System.Threading;
using Guts.Client.Core;
using Guts.Client.Shared;

namespace MasterMind.Data.Tests
{
    [ProjectComponentTestFixture("1TINProject", "MasterMind", "Game", @"MasterMind.Data\DomainClasses\Game.cs")]
    public class GameTests
    {
        private Random _random;

        [SetUp]
        public void Setup()
        {
            _random = new Random();
        }

        [MonitoredTest("Constructor - Should initialize a Game object"), Order(1)]
        public void Constructor_ShouldInitializeAGameObject()
        {
            //Arrange
            var players = new List<IPlayer>
            {
                new UserBuilder().WithId().Build(),
                new UserBuilder().WithId().Build()
            };
            var codeLength = _random.Next(2, 9);
            var settings = new GameSettings { AmountOfColors = codeLength, CodeLength = codeLength };

            //Act 
            var game = new Game(settings, players);

            //Assert
            Assert.That(game.Settings, Is.SameAs(settings), () => "The 'Settings' property of the game is not set correctly.");
            Assert.That(game.Players, Is.SameAs(players), () => "The 'Players' property of the game is not set correctly.");

            Assert.That(game.CurrentRound, Is.EqualTo(1), () => "The 'CurrentRound' of the game should start at 1.");

            Assert.That(game.PossibleColors, Is.Not.Null, () => "The 'PossibleColors' array should be initialized.");
            Assert.That(game.PossibleColors.Length, Is.EqualTo(settings.AmountOfColors),
                () => "The length of the 'PossibleColors' array should be the same as the 'AmountOfColors' setting.");
            Assert.That(game.PossibleColors, Is.Unique,
                () => "The 'PossibleColors' array should contain all different colors.");
            Assert.That(game.PossibleColors, Has.None.Empty,
                () => "The 'PossibleColors' array cannot contain empty strings.");
        }

        [MonitoredTest("Constructor - Should correctly generate a code to guess when duplicate colors are not allowed"), Order(2)]
        public void Constructor_ShouldCorrectlyGenerateACodeToGuessWhenDuplicateColorsAreNotAllowed()
        {
            var codeLength = _random.Next(2, 9);
            ConstructAGame(codeLength, 1, out string[] codeToGuess);

            Assert.That(codeToGuess.Length, Is.EqualTo(codeLength),
                () => "The length of the code should be equal to the 'CodeLength' setting.");
            Assert.That(codeToGuess, Is.Unique,
                () => "The colors in the generated code should all be different.");
        }

        [MonitoredTest("Constructor - Should generate random codes"), Order(3)]
        public void Constructor_ShouldGenerateRandomCodes()
        {
            var codeLength = 8;
            ConstructAGame(codeLength, 1, out string[] firstCodeToGuess);
            Thread.Sleep(10);
            ConstructAGame(codeLength, 1, out string[] secondCodeToGuess);

            bool areTheSame = true;
            for (var index = 0; index < firstCodeToGuess.Length; index++)
            {
                var color1 = firstCodeToGuess[index];
                var color2 = secondCodeToGuess[index];
                if (color1 != color2)
                {
                    areTheSame = false;
                }
            }
            Assert.That(areTheSame, Is.False,
                () => "When 2 'Game' objects are constucted, they generate the same code.");

        }

        [MonitoredTest("CanGuessCode - Should return MustWaitOnOthers when there are players that have made less guesses"), Order(4)]
        public void CanGuessCode_ShouldReturnMustWaitOnOthersWhenThereArePlayersThatHaveMadeLessGuesses()
        {
            //Arrange
            var player = new UserBuilder().WithId().Build();
            var otherPlayer = new UserBuilder().WithId().Build();
            var game = CreateTwoPlayerGame(player, otherPlayer);

            //2 guesses for our player
            AddGuessesForPlayer(game, player, 2);

            //1 guess for the other player
            AddGuessesForPlayer(game, otherPlayer, 1);

            //Act
            var result = game.CanGuessCode(player, game.CurrentRound);

            //Assert
            Assert.That(result, Is.EqualTo(CanGuessResult.MustWaitOnOthers));
        }

        [MonitoredTest("CanGuessCode - Should should return Ok when other players have equal or more guesses"), Order(5)]
        public void CanGuessCode_ShouldReturnOkWhenOtherPlayersHaveEqualOrMoreGuesses()
        {
            //Arrange
            var player = new UserBuilder().WithId().Build();
            var otherPlayer = new UserBuilder().WithId().Build();
            var game = CreateTwoPlayerGame(player, otherPlayer);

            //2 guesses for our player
            AddGuessesForPlayer(game, player, 2);

            //2 guesses for the other player
            AddGuessesForPlayer(game, otherPlayer, 2);

            //Act
            var result = game.CanGuessCode(player, game.CurrentRound);

            //Assert
            Assert.That(result, Is.EqualTo(CanGuessResult.Ok));
        }

        [MonitoredTest("CanGuessCode - Should return NotAllowedDueToGameStatus when the game is in the next round"), Order(6)]
        public void CanGuessCode_ShouldReturnNotAllowedDueToGameStatusWhenTheGameIsInTheNextRound()
        {
            //Arrange
            var player = new UserBuilder().WithId().Build();
            var game = CreateTwoPlayerGame(player);

            //Act
            var result = game.CanGuessCode(player, game.CurrentRound - 1);

            //Assert
            Assert.That(result, Is.EqualTo(CanGuessResult.NotAllowedDueToGameStatus));
        }

        [MonitoredTest("CanGuessCode - Should return RoundNotStarted when the round is not started yet"), Order(7)]
        public void CanGuessCode_ShouldReturnRoundNotStartedWhenTheRoundIsNotStartedYet()
        {
            //Arrange
            var player = new UserBuilder().WithId().Build();
            var game = CreateTwoPlayerGame(player);

            //Act
            var result = game.CanGuessCode(player, game.CurrentRound + 1);

            //Assert
            Assert.That(result, Is.EqualTo(CanGuessResult.RoundNotStarted));
        }

        [MonitoredTest("CanGuessCode - Should return MaximumReached when the player has made the maximum amount of guesses for the round"), Order(8)]
        public void CanGuessCode_ShouldReturnMaximumReachedWhenThePlayerHasMadeTheMaximumAmountOfGuessesForTheRound()
        {
            //Arrange
            var player = new UserBuilder().WithId().Build();
            var game = CreateTwoPlayerGame(player);

            AddGuessesForPlayer(game, player, game.Settings.MaximumAmountOfGuesses);

            //Act
            var result = game.CanGuessCode(player, game.CurrentRound);

            //Assert
            Assert.That(result, Is.EqualTo(CanGuessResult.MaximumReached));
        }

        [MonitoredTest("GuessCode - Should create a verified GuessResult"), Order(9)]
        public void GuessCode_ShouldCreateAVerifiedGuessResult()
        {
            //Arrange
            var game = ConstructAGame(4, 1, out string[] codeToGuess);
            var player = game.Players[0];

            //Act
            var guessResult = game.GuessCode(codeToGuess, player);

            //Assert
            Assert.That(guessResult, Is.Not.Null);
            Assert.That(guessResult.Colors, Is.EquivalentTo(codeToGuess),
                () => "The 'Colors' of the 'GuessResult' should be the colors that were guessed.");
            Assert.That(guessResult.CorrectColorAndPositionAmount, Is.GreaterThan(0),
                () => "The returned 'GuessResult' is not verified " +
                      "('CorrectColorAndPositionAmount' should be greater than zero if the correct code is guessed).");
        }

        [MonitoredTest("GuessCode - Should start a new round when a player guessed the code and there is a next round"), Order(10)]
        public void GuessCode_ShouldStartANewRoundWhenAPlayerGuessedTheCodeAndThereIsANextRound()
        {
            //Arrange
            var game = ConstructAGame(4, 2, out string[] codeToGuess);
            var player = game.Players[0];

            //Act
            game.GuessCode(codeToGuess, player);

            //Assert
            Assert.That(game.CurrentRound, Is.EqualTo(2), 
                () => "The 'CurrentRound' should be 2 when the code is guessed in round 1 of a 2-round game."); 
        }

        [MonitoredTest("GuessCode - Should start a new round when all players guess the maximum amount of times"), Order(11)]
        public void GuessCode_ShouldStartANewRoundWhenAllPlayersGuessTheMaximumAmountOfTimes()
        {
            //Arrange
            var game = ConstructAGame(4, 2, out string[] codeToGuess);

            //Act
            foreach (var player in game.Players)
            {
                AddGuessesForPlayer(game, player, game.Settings.MaximumAmountOfGuesses);
            }

            //Assert
            Assert.That(game.CurrentRound, Is.EqualTo(2),
                () => "The 'CurrentRound' should be 2 when all players guesses the maximum amount of times in round 1 of a 2-round game.");
        }

        [MonitoredTest("GetStatus - Should return a GameOver status when one of the players has a fully correct GuessResult"), Order(12)]
        public void GetStatus_ShouldReturnAGameOverStatusWhenOneOfThePlayersHasAFullyCorrectGuessResult()
        {
            //Arrange
            var game = ConstructAGame(4, 1, out string[] codeToGuess);

            AddGuessesForPlayer(game, game.Players[0], 2);
            AddGuessesForPlayer(game, game.Players[1], 1);

            game.GuessCode(codeToGuess, game.Players[1]);

            //Act
            var result = game.GetStatus();

            //Assert
            Assert.That(result, Is.Not.Null, () => "The result cannot be null.");
            Assert.That(result.GameOver, Is.True,
                () => "In a one-round game the game should be over when one of the players guesses the code");
            Assert.That(result.FinalWinner, Is.SameAs(game.Players[1]),
                () => "The 'FinalWinner' should contain the player that made the correct guess.");
        }

        [MonitoredTest("GetStatus - Should return a status that is not GameOver when Nobody has a fully correct GuessResult"), Order(13)]
        public void GetStatus_ShouldReturnStatusThatIsNotGameOverWhenNobodyHasAFullyCorrectGuessResult()
        {
            //Arrange
            var game = ConstructAGame(4, 1, out string[] codeToGuess);

            AddGuessesForPlayer(game, game.Players[0], 2);
            AddGuessesForPlayer(game, game.Players[1], 2);

            //Act
            var result = game.GetStatus();

            //Assert
            Assert.That(result, Is.Not.Null, () => "The result cannot be null.");
            Assert.That(result.GameOver, Is.False,
                () => "In a one-round game the game should not be over when nobody has guessed the code and the maximum amount of guesses is not reached");
            Assert.That(result.FinalWinner, Is.Null,
                () => "The 'FinalWinner' should be set to 'null' when nobody has won yet.");
        }

        private Game CreateTwoPlayerGame(IPlayer player)
        {
            return CreateTwoPlayerGame(player, new UserBuilder().WithId().Build());
        }

        private Game CreateTwoPlayerGame(IPlayer player, IPlayer otherPlayer)
        {
            var players = new List<IPlayer>
            {
                player,
                otherPlayer
            };
            var settings = new GameSettings { DuplicateColorsAllowed = false, MaximumAmountOfGuesses = 10 };
            return new Game(settings, players);
        }

        private void AddGuessesForPlayer(Game game, IPlayer player, int amountOfGuesses)
        {
            for (int i = 0; i < amountOfGuesses; i++)
            {
                var colors = new GuessModelBuilder()
                    .WithNumberOfColors(game.Settings.CodeLength)
                    .Build()
                    .Colors;
                game.GuessCode(colors, player);
            }
        }

        private Game ConstructAGame(int codeLength, int amountOfRounds, out string[] codeToGuess)
        {
            var players = new List<IPlayer>
            {
                new UserBuilder().WithId().Build(),
                new UserBuilder().WithId().Build()
            };
            var settings = new GameSettings
            {
                AmountOfColors = codeLength,
                CodeLength = codeLength,
                DuplicateColorsAllowed = false,
                MaximumAmountOfGuesses = 10,
                AmountOfRounds = amountOfRounds
            };
            var game = new Game(settings, players);
            var codeToGuessFieldValue = game.GetPrivateFieldValueByName<string[]>("_codeToGuess");
            Assert.That(codeToGuessFieldValue, Is.Not.Null,
                () => "The 'Game' class should contain a private field of type 'string[]' with the exact name '_codeToGuess'.");
            codeToGuess = codeToGuessFieldValue;
            return game;
        }
    }
}