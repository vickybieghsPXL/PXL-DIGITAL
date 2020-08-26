using System;
using System.Collections.Concurrent;
using System.Collections.Generic;
using MasterMind.Data.DomainClasses;

namespace MasterMind.Data.Repositories
{
    public class InMemoryWaitingRoomRepository : IWaitingRoomRepository
    {
        private ConcurrentDictionary<Guid, WaitingRoom> _concurrentDictionary;
        public InMemoryWaitingRoomRepository()
        {
            _concurrentDictionary = new ConcurrentDictionary<Guid, WaitingRoom>();
        }

        public WaitingRoom Add(WaitingRoom newWaitingRoom)
        {
            WaitingRoom waitingroom = newWaitingRoom;
            Guid guid = Guid.NewGuid();
            waitingroom.Id = guid;
            _concurrentDictionary.AddOrUpdate(guid, waitingroom, (i, j) => j);
            return waitingroom;
        }

        public WaitingRoom GetById(Guid id)
        {
            WaitingRoom room = new WaitingRoom("", new User(), new GameSettings());
            if (_concurrentDictionary.ContainsKey(id))
            {
                
                return _concurrentDictionary.GetOrAdd(id, room);
            }
            else
            {
                throw new DataNotFoundException();
            }
        }

        public ICollection<WaitingRoom> GetAll()
        {
            List<WaitingRoom> list = new List<WaitingRoom>();
            foreach (var w in _concurrentDictionary) {
                list.Add(w.Value);
            }
            return list;
        }

        public void DeleteById(Guid id)
        {
            WaitingRoom room = new WaitingRoom("", new User(), new GameSettings());
            if (_concurrentDictionary.ContainsKey(id))
            {
                _concurrentDictionary.Remove(id, out room);
            }
        }
    }
}