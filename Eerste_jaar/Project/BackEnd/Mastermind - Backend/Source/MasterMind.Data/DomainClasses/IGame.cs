using System;
using System.Collections.Generic;

namespace MasterMind.Data.DomainClasses
{
    public interface IGame
    {
        /// <summary>
        /// Identifier of the game.
        /// </summary>
        Guid Id { get; set; }

        /// <summary>
        /// Settings that determine the game rules and game flow.
        /// </summary>
        GameSettings Settings { get; set; }

        /// <summary>
        /// List of players that participate in the game.
        /// </summary>
        IList<IPlayer> Players { get; }

        /// <summary>
        /// Array that contains the colors that can be used in the code.
        /// Each color is represented as a HEX value (e.g.: #FF0000). 
        /// You can find some colors on https://html-color.codes/color-charts.
        /// The length of this array should be equal to the AmountOfColors property of the Settings.
        /// </summary>
        string[] PossibleColors { get; }

        /// <summary>
        /// The number of the round that is currently in progress (starts at 1).
        /// </summary>
        int CurrentRound { get; }

        /// <summary>
        /// Checks if it is allowed for a player to do a guess for a certain round.
        /// </summary>
        CanGuessResult CanGuessCode(IPlayer player, int roundNumber);

        /// <summary>
        /// Verifies and registers a guess for a player in the PlayerHistory dictionary.
        /// </summary>
        /// <param name="colors">
        /// Array that contains the colors that are guessed.
        /// Each color is represented as a HEX value (e.g.: #FF0000).
        /// </param>
        /// <param name="player">
        /// The player that is doing the guess
        /// </param>
        GuessResult GuessCode(string[] colors, IPlayer player);

        /// <summary>
        /// Determines the winner of each round that is over.
        /// Determines the final winner if all rounds are played.
        /// </summary>
        GameStatus GetStatus();
    }
}