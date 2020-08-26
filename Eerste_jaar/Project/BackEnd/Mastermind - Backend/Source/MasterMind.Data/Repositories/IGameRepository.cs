using System;
using MasterMind.Data.DomainClasses;

namespace MasterMind.Data.Repositories
{
    public interface IGameRepository
    {
        IGame Add(IGame newGame);
        IGame GetById(Guid id);
        void DeleteById(Guid id);
    }
}