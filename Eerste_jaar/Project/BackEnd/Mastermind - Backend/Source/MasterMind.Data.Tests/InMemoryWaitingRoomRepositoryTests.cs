using Guts.Client.Shared.TestTools;
using MasterMind.Data.DomainClasses;
using MasterMind.Data.Repositories;
using MasterMind.TestTools.Builders;
using NUnit.Framework;
using System;
using System.Collections.Concurrent;
using System.Linq;
using Guts.Client.Core;
using Guts.Client.Shared;

namespace MasterMind.Data.Tests
{
    [ProjectComponentTestFixture("1TINProject", "MasterMind", "WaitingRoomRepo", @"MasterMind.Data\Repositories\InMemoryWaitingRoomRepository.cs")]
    public class InMemoryWaitingRoomRepositoryTests
    {
        private InMemoryWaitingRoomRepository _repo;
        private ConcurrentDictionary<Guid, WaitingRoom> _internalDictionary;

        [SetUp]
        public void SetUp()
        {
            _repo = new InMemoryWaitingRoomRepository();
            if (_repo.HasPrivateField<ConcurrentDictionary<Guid, WaitingRoom>>())
            {
                _internalDictionary = _repo.GetPrivateFieldValue<ConcurrentDictionary<Guid, WaitingRoom>>();
            }
        }

        [MonitoredTest("Should use a ConcurrentDictionary for internal storage")]
        public void ShouldUseAConcurrentDictionaryForInternalStorage()
        {
            AssertHasInternalDictionary();
        }

        [MonitoredTest("Add - Should assign an Id to the room and return the saved room")]
        public void Add_ShouldAssignAnIdToTheRoomAndReturnTheSavedRoom()
        {
            //Arrange
            var newRoom = new WaitingRoomBuilder().Build();

            //Act
            var result = _repo.Add(newRoom);

            //Assert
            Assert.That(result.Id, Is.Not.EqualTo(Guid.Empty));
            Assert.That(result, Is.SameAs(newRoom));
        }

        [MonitoredTest("Add - Should add the room to the dictionary")]
        public void Add_ShouldAddTheRoomToTheDictionary()
        {
            AssertHasInternalDictionary();

            //Arrange
            var newRoom = new WaitingRoomBuilder().Build();

            //Act
            _repo.Add(newRoom);

            //Assert
            Assert.That(_internalDictionary.Count, Is.EqualTo(1), "Cannot find the room in the dictionary.");
            Assert.That(_internalDictionary.Values.Contains(newRoom), Is.True,
                "The room added in the dictionary should be the same object that was passed in as parameter.");
        }

        [MonitoredTest("GetAll - Should return all added rooms")]
        public void GetAll_ShouldReturnAllAddedRooms()
        {
            AssertHasInternalDictionary();

            //Arrange
            var numberOfRooms = new Random().Next(3, 10);
            AddExistingRoomsToInternalDictionary(numberOfRooms);

            //Act
            var result = _repo.GetAll();

            //Assert
            Assert.That(result, Has.Count.EqualTo(numberOfRooms));
            Assert.That(result.All(room => _internalDictionary.Any(kv => kv.Key == room.Id && kv.Value.Name == room.Name)), Is.True, () => "Not all rooms in the internal dictionary are returned.");
        }

        [MonitoredTest("GetById - Should return an existing room")]
        public void GetById_ShouldReturnAnExistingRoom()
        {
            AssertHasInternalDictionary();

            //Arrange
            var existingRoom = AddExistingRoomToInternalDictionary();

            //Act
            var result = _repo.GetById(existingRoom.Id);

            //Assert
            Assert.That(result, Is.SameAs(result));
        }

        [MonitoredTest("GetById - Should throw DataNotFoundException when the room does not exist")]
        public void GetById_ShouldThrowDataNotFoundExceptionWhenTheRoomDoesNotExist()
        {
            //Arrange
            var numberOfRooms = new Random().Next(3, 10);
            for (int i = 0; i < numberOfRooms; i++)
            {
                AddExistingRoomToInternalDictionary();
            }

            //Act + Assert
            Assert.That(() => _repo.GetById(Guid.NewGuid()), Throws.TypeOf<DataNotFoundException>());
        }

        [MonitoredTest("DeleteById - Should remove the room with matching Id")]
        public void DeleteById_ShouldRemoveTheRoomWithMatchingId()
        {
            AssertHasInternalDictionary();

            //Arrange
            AddExistingRoomsToInternalDictionary(new Random().Next(1, 5));
            var roomToDelete = AddExistingRoomToInternalDictionary();
            AddExistingRoomsToInternalDictionary(new Random().Next(1, 5));

            //Act
            _repo.DeleteById(roomToDelete.Id);

            //Assert
            Assert.That(_internalDictionary.Values.All(room => room.Id != roomToDelete.Id), Is.True);
        }

        [MonitoredTest("DeleteById - Should do nothing if the room does not exist")]
        public void DeleteById_ShouldDoNothingIfTheRoomDoesNotExist()
        {
            AssertHasInternalDictionary();

            //Arrange
            var numberOfRooms = new Random().Next(3, 10);
            AddExistingRoomsToInternalDictionary(numberOfRooms);

            //Act
            _repo.DeleteById(Guid.NewGuid());

            //Assert
            Assert.That(_internalDictionary.Count, Is.EqualTo(numberOfRooms));
        }

        private void AssertHasInternalDictionary()
        {
            Assert.That(_internalDictionary, Is.Not.Null);
            Assert.That(_internalDictionary.Count, Is.Zero);
        }

        private WaitingRoom AddExistingRoomToInternalDictionary()
        {
            var room = new WaitingRoomBuilder().WithId().Build();
            _internalDictionary.TryAdd(room.Id, room);
            return room;
        }

        private void AddExistingRoomsToInternalDictionary(int numberOfRooms)
        {
            for (int i = 0; i < numberOfRooms; i++)
            {
                AddExistingRoomToInternalDictionary();
            }
        }
    }
}
