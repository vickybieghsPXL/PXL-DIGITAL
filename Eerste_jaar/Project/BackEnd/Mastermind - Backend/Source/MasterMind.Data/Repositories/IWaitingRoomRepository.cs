using System;
using System.Collections.Generic;
using MasterMind.Data.DomainClasses;

namespace MasterMind.Data.Repositories
{
    public interface IWaitingRoomRepository
    {
        WaitingRoom Add(WaitingRoom newWaitingRoom);
        WaitingRoom GetById(Guid id);
        ICollection<WaitingRoom> GetAll();
        void DeleteById(Guid id);
    }
}
