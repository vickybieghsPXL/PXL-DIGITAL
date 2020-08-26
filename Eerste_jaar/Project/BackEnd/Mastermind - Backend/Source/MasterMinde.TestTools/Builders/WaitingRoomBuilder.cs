using System;
using MasterMind.Data.DomainClasses;

namespace MasterMind.TestTools.Builders
{
    public class WaitingRoomBuilder
    {
        private readonly WaitingRoom _waitingRoom;

        public WaitingRoomBuilder()
        {
            var creator = new UserBuilder().WithId().Build();
            _waitingRoom = new WaitingRoom(Guid.NewGuid().ToString(), creator, new GameSettings())
            {
                Id = default(Guid)
            };
        }

        public WaitingRoomBuilder WithId()
        {
            _waitingRoom.Id = Guid.NewGuid();
            return this;
        }

        public WaitingRoomBuilder WithName(string name)
        {
            _waitingRoom.Name = name;
            return this;
        }

        public WaitingRoomBuilder WithUser(User user)
        {
            _waitingRoom.Users.Add(user);
            return this;
        }

        public WaitingRoomBuilder WithNumberOfUsers(int numberOfUsers)
        {
            while (_waitingRoom.Users.Count < numberOfUsers)
            {
                _waitingRoom.Users.Add(new UserBuilder().WithId().Build());
            }
            return this;
        }

        public WaitingRoomBuilder WithMaximumNumberOfUsers()
        {
            return WithNumberOfUsers(_waitingRoom.MaximumAmountOfUsers);
        }

        public WaitingRoom Build()
        {
            return _waitingRoom;
        }
    }
}
