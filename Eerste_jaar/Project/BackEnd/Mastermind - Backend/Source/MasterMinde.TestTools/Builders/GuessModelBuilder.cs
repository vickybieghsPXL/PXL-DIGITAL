using System;
using MasterMind.Api.Models;

namespace MasterMind.TestTools.Builders
{
    public class GuessModelBuilder
    {
        private readonly GuessModel _model;

        public GuessModelBuilder()
        {
            string[] colors = {Guid.NewGuid().ToString(),
                Guid.NewGuid().ToString(),
                Guid.NewGuid().ToString(),
                Guid.NewGuid().ToString()
            };
            _model = new GuessModel{
                Colors = colors

            };
        }

        public GuessModelBuilder WithNumberOfColors(int numberOfColors)
        {
            _model.Colors = new string[numberOfColors];
            for (int i = 0; i < numberOfColors; i++)
            {
                _model.Colors[i] = Guid.NewGuid().ToString();
            }
            return this;
        }

        public GuessModel Build()
        {
            return _model;
        }
    }
}