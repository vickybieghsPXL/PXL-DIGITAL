namespace MasterMind.TestTools.Builders
{
    internal class WaitingRoomBuilder
    {
        private readonly WaitingRoom _waitingRoom;

        public WaitingRoomBuilder()
        {
            _waitingRoom = new WaitingRoom
            {
                Id = default(Guid),
                Name = Guid.NewGuid().ToString()
            };
        }

        public WaitingRoomBuilder WithId()
        {
            _waitingRoom.Id = Guid.NewGuid();
            return this;
        }

        public WaitingRoom Build()
        {
            return _waitingRoom;
        }
    }
}
