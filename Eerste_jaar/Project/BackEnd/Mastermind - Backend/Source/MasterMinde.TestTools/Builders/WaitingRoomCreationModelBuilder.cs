using System;
using MasterMind.Business.Models;
using MasterMind.Data.DomainClasses;

namespace MasterMind.TestTools.Builders
{
    public class WaitingRoomCreationModelBuilder
    {
        private readonly WaitingRoomCreationModel _model;

        public WaitingRoomCreationModelBuilder()
        {
            _model = new WaitingRoomCreationModel
            {
                Name = Guid.NewGuid().ToString(),
                GameSettings = new GameSettings()
            };
        }

        public WaitingRoomCreationModelBuilder WithName(string name)
        {
            _model.Name = name;
            return this;
        }

        public WaitingRoomCreationModel Build()
        {
            return _model;
        }  
    }
}
