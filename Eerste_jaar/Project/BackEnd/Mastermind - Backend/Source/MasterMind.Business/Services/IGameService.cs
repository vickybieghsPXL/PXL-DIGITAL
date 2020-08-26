using System;
using MasterMind.Data.DomainClasses;

namespace MasterMind.Business.Services
{
    public interface IGameService
    {
        IGame StartGameForRoom(Guid roomId);
        IGame GetGameById(Guid id);
        CanGuessResult CanGuessCode(Guid gameId, IPlayer player, int roundNumber);
        GuessResult GuessCode(Guid gameId, string[] colors, IPlayer player);
        GameStatus GetGameStatus(Guid gameId);
    }
}