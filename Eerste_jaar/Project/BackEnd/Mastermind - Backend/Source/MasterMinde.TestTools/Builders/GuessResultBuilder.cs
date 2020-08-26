using System;
using MasterMind.Data.DomainClasses;

namespace MasterMind.TestTools.Builders
{
    public class GuessResultBuilder
    {
        private readonly GuessResult _guessResult;

        public GuessResultBuilder()
        {
            string[] colors = {Guid.NewGuid().ToString(),
                Guid.NewGuid().ToString(),
                Guid.NewGuid().ToString(),
                Guid.NewGuid().ToString()
            };
            _guessResult = new GuessResult(colors);
        }

        public GuessResultBuilder WithColors(string[] colors)
        {
            _guessResult.Colors = colors;
            return this;
        }

        public GuessResult Build()
        {
            return _guessResult;
        }
    }
}