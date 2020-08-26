using System;
using System.Collections.Concurrent;
using System.Collections.Generic;
using MasterMind.Data.DomainClasses;

namespace MasterMind.Data.Repositories
{
    public class InMemoryGameRepository : IGameRepository
    {
        private ConcurrentDictionary<Guid, IGame> _concurrentDictionary;
                     
        public InMemoryGameRepository()
        {
            _concurrentDictionary = new ConcurrentDictionary<Guid, IGame>();
        }

        public IGame Add(IGame newGame)
        {
            IGame game = newGame;
            Guid gameGuid = Guid.NewGuid();
            newGame.Id = gameGuid;
            _concurrentDictionary.AddOrUpdate(gameGuid, newGame, (i, j) => j);

            return game;
        }

        public IGame GetById(Guid id)
        {
            IGame game = new Game(new GameSettings(), new List<IPlayer>());
            if (_concurrentDictionary.ContainsKey(id))
            {
                return _concurrentDictionary.GetOrAdd(id, game);
            }
            else
            {
                throw new DataNotFoundException();
            }

        }

        public void DeleteById(Guid id)
        {
            IGame game = new Game(new GameSettings(), new List<IPlayer>());
            if (_concurrentDictionary.ContainsKey(id))
            {
                _concurrentDictionary.Remove(id, out game);
            }
        }
    }
}
