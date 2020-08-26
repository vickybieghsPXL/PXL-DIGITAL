using System;
using System.Collections.Generic;
using MasterMind.Data.DomainClasses;

namespace MasterMind.TestTools.Builders
{
    public class GameBuilder
    {
        private readonly Game _game;

        public GameBuilder()
        {
            _game = new Game(new GameSettings(), new List<IPlayer>());
        }

        public GameBuilder WithId()
        {
            _game.Id = Guid.NewGuid();
            return this;
        }

        public Game Build()
        {
            return _game;
        }
    }
}