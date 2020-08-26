using MasterMind.Data.DomainClasses;
using System;
using System.Linq;
using MasterMind.Data.Repositories;
using System.Collections.Generic;

namespace MasterMind.Business.Services
{
    public class GameService : IGameService
    {
        private IWaitingRoomService WaitingRoomService;
        private IGameRepository GameRepository;

        public GameService(IWaitingRoomService waitingRoomService, IGameRepository gameRepository)
        {
            WaitingRoomService = waitingRoomService;
            GameRepository = gameRepository;
        }

        public IGame StartGameForRoom(Guid roomId)
        {
            WaitingRoom room = WaitingRoomService.GetRoomById(roomId);
            
            IList<User> users = room.Users;

            IList<IPlayer> players = new List<IPlayer>();
            foreach (User u in users)
            {
                players.Add((IPlayer)u);
            }

            Game game = new Game(room.GameSettings, players);

            if (game.Players.Count() < 2)
            {
                throw new ApplicationException();
            }

            GameRepository.Add(game);

            WaitingRoomService.GetRoomById(roomId).GameId = game.Id;

            return game;
        }

        public IGame GetGameById(Guid id)
        {
            return GameRepository.GetById(id);
        }

        public CanGuessResult CanGuessCode(Guid gameId, IPlayer player, int roundNumber)
        {
            IGame g = GameRepository.GetById(gameId);
            return g.CanGuessCode(player, roundNumber);
        }

        public GuessResult GuessCode(Guid gameId, string[] colors, IPlayer player)
        {
            IGame g = GameRepository.GetById(gameId);
            if (g.CanGuessCode(player, g.CurrentRound) == CanGuessResult.Ok)
            {
                return g.GuessCode(colors, player);
            }
            else
            {
                throw new ApplicationException();
            }
            
        }            

        public GameStatus GetGameStatus(Guid gameId)
        {
            IGame g = GameRepository.GetById(gameId);
            return g.GetStatus();
        }
    }
}