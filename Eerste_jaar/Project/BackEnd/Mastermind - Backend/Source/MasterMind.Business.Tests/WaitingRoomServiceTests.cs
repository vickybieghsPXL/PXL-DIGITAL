using Guts.Client.Core;
using Guts.Client.Shared;
using MasterMind.Business.Services;
using MasterMind.Data;
using MasterMind.Data.DomainClasses;
using MasterMind.Data.Repositories;
using MasterMind.TestTools.Builders;
using Moq;
using NUnit.Framework;
using System;
using System.Collections.Generic;
using System.Linq;
using Guts.Client.Shared.TestTools;

namespace MasterMind.Business.Tests
{
    [ProjectComponentTestFixture("1TINProject", "MasterMind", "WaitingRoomService", @"MasterMind.Business\Services\WaitingRoomService.cs")]
    public class WaitingRoomServiceTests
    {
        private WaitingRoomService _service;
        private Mock<IWaitingRoomRepository> _repositoryMock;

        [SetUp]
        public void SetUp()
        {
            _repositoryMock = new Mock<IWaitingRoomRepository>();
            _service = new WaitingRoomService(_repositoryMock.Object);
        }

        [MonitoredTest("Constructor - Should assign the IWaitingRoomRepository to a private field")]
        public void Constructor_ShouldAssignTheIWaitingRoomRepositoryToAPrivateField()
        {
            //Assert
            if (_service.HasPrivateField<IWaitingRoomRepository>())
            {
                IWaitingRoomRepository waitingRoomRepositoryFieldValue = _service.GetPrivateFieldValue<IWaitingRoomRepository>();
                Assert.That(waitingRoomRepositoryFieldValue, Is.EqualTo(_repositoryMock.Object), "The constructor parameter 'waitingRoomRepository' is not assigned to the private field.");
            }
            else
            {
                Assert.Fail("Cannot find a private field (instance variable) of type 'IWaitingRoomRepository'.");
            }
        }

        [MonitoredTest("CreateRoom - Should add waiting room containing the user and game settings")]
        public void CreateRoom_ShouldAddAWaitingRoomContainingTheUserAndGameSettings()
        {
            //Arrange
            var model = new WaitingRoomCreationModelBuilder().Build();
            var creator = new UserBuilder().WithId().Build();

            WaitingRoom createdWaitingRoom = null;
            _repositoryMock.Setup(repo => repo.Add(It.IsAny<WaitingRoom>())).Returns((WaitingRoom room) =>
                {
                    room.Id = Guid.NewGuid();
                    createdWaitingRoom = room;
                    return room;
                });
            _repositoryMock.Setup(repo => repo.GetAll()).Returns(new List<WaitingRoom>());

            //Act
            var result = _service.CreateRoom(model, creator);

            //Assert
            _repositoryMock.Verify(repo => repo.Add(It.Is((WaitingRoom room) => room.Name == model.Name && room.CreatorUserId == creator.Id)),
                Times.Once, "The 'Add' method of the WaitingRoomRepository is not called correctly. " +
                            "The room must have the correct name and CreatorUserId set.");
            Assert.That(result, Is.SameAs(createdWaitingRoom), () => "The room created by the repository is not returned.");
            Assert.That(result.GameSettings, Is.SameAs(model.GameSettings), () => "The game settings in the returned room are not the same as the game settings in the creation model.");
            Assert.That(result.Users, Has.One.SameAs(creator), () => "The creator of the room can not be found in the Users list in the returned room.");
        }

        [MonitoredTest("CreateRoom - Should check the uniqueness of the room name")]
        public void CreateRoom_ShouldCheckUniquenessOfRoomName()
        {
            //Arrange
            var model = new WaitingRoomCreationModelBuilder().Build();
            var user = new UserBuilder().WithId().Build();

            _repositoryMock.Setup(repo => repo.Add(It.IsAny<WaitingRoom>())).Returns((WaitingRoom room) =>
            {
                room.Id = Guid.NewGuid();
                return room;
            });

            var existingRooms = new List<WaitingRoom>
            {
                new WaitingRoomBuilder().WithId().Build(),
                new WaitingRoomBuilder().WithId().WithName(model.Name).Build(), //duplicate name
                new WaitingRoomBuilder().WithId().Build()
            };
            _repositoryMock.Setup(repo => repo.GetAll()).Returns(existingRooms);

            //Act + Assert
            Assert.That(() => _service.CreateRoom(model, user), Throws.InstanceOf<ApplicationException>(),
                () => "When there is already a room with the same name an ApplicationException should be thrown.");

            _repositoryMock.Verify(repo => repo.GetAll(), Times.Once,
                "To check uniqueness the GetAll method of the repository should be used.");
            _repositoryMock.Verify(repo => repo.Add(It.IsAny<WaitingRoom>()), Times.Never,
                "When there is already a room with the same name the Add method of the repository should never be called.");
        }

        [MonitoredTest("GetRoomById - Should call the repository an return its result")]
        public void GetRoomById_ShouldCallRepositoryAndReturnItsResult()
        {
            //Arrange
            var existingRoom = new WaitingRoomBuilder().WithId().Build();
            _repositoryMock.Setup(repo => repo.GetById(It.IsAny<Guid>())).Returns(existingRoom);

            //Act
            var result = _service.GetRoomById(existingRoom.Id);

            //Assert
            Assert.That(result, Is.SameAs(existingRoom),
                () => "The room returned by the service should be the room returned by the repository.");
            _repositoryMock.Verify(repo => repo.GetById(existingRoom.Id), Times.Once,
                "The GetById method of the repository is not called with the correct id.");
        }

        [MonitoredTest("GetAllAvailableRooms - Should retrieve al the rooms from the repository and filter out the ones that are not full")]
        public void GetAllAvailableRooms_ShouldRetrieveAllRoomsFromRepositoryAndFilterOutTheOnesThatAreNotFull()
        {
            //Arrange
            var emptyRoom = new WaitingRoomBuilder().WithId().WithNumberOfUsers(0).Build();
            var fullRoom = new WaitingRoomBuilder().WithId().WithMaximumNumberOfUsers().Build();
            var oneUserRoom = new WaitingRoomBuilder().WithId().WithNumberOfUsers(1).Build();
            var allRooms = new List<WaitingRoom>
            {
                emptyRoom,
                fullRoom,
                oneUserRoom
            };
            _repositoryMock.Setup(repo => repo.GetAll()).Returns(allRooms);

            //Act
            var result = _service.GetAllAvailableRooms();

            //Assert
            _repositoryMock.Verify(repo => repo.GetAll(), Times.Once, "The GetAll method of the repository is not called.");
            Assert.That(result, Has.Count.GreaterThan(0), () => "No rooms are returned.");
            Assert.That(result, Has.One.SameAs(emptyRoom), () => "An empty room is not returned.");
            Assert.That(result, Has.One.SameAs(oneUserRoom), () => "A room with one user is not returned.");
            Assert.That(result, Has.None.SameAs(fullRoom), () => "A full room is not filtered out.");
        }

        [MonitoredTest("TryJoinRoom - Should return true when there is room for the user")]
        public void TryJoinRoom_ShouldReturnTrueWhenThereIsRoomForTheUser()
        {
            //Arrange
            var existingRoom = new WaitingRoomBuilder().WithId().Build();
            var user = new UserBuilder().WithId().Build();

            _repositoryMock.Setup(repo => repo.GetById(It.IsAny<Guid>())).Returns(existingRoom);

            //Act
            var result = _service.TryJoinRoom(existingRoom.Id, user, out string failureReason);

            //Assert
            _repositoryMock.Verify(repo => repo.GetById(existingRoom.Id), Times.Once,
                "The GetById method of the repository is not called correctly.");
            Assert.That(result, Is.True);
            Assert.That(failureReason, Is.Null.Or.Empty,
                () => "The failureReason should be empty when the user can join.");
            Assert.That(existingRoom.Users, Has.Count.EqualTo(2),
                () => "The room does not have the correct amount of users after the join.");
            Assert.That(existingRoom.Users.Any(u => u.Id == user.Id), Is.True,
                () => "The user that joined cannot be found in the users of the room after the join.");
        }

        [MonitoredTest("TryJoinRoom - Should return false when the room does not exist")]
        public void TryJoinRoom_ShouldReturnFalseWhenTheRoomDoesNotExist()
        {
            //Arrange
            var nonExistingRoom = new WaitingRoomBuilder().WithId().Build();
            var user = new UserBuilder().WithId().Build();

            _repositoryMock.Setup(repo => repo.GetById(It.IsAny<Guid>())).Throws<DataNotFoundException>();

            //Act
            var result = _service.TryJoinRoom(nonExistingRoom.Id, user, out string failureReason);

            //Assert
            _repositoryMock.Verify(repo => repo.GetById(nonExistingRoom.Id), Times.Once,
                "The GetById method of the repository is not called correctly.");
            Assert.That(result, Is.False);
            Assert.That(failureReason, Is.Not.Empty,
                () => "The failureReason should not empty when room does not exist.");
        }

        [MonitoredTest("TryJoinRoom - Should return false when the room is full")]
        public void TryJoinRoom_ShouldReturnFalseWhenTheRoomIsFull()
        {
            //Arrange
            var existingRoom = new WaitingRoomBuilder().WithId().WithMaximumNumberOfUsers().Build();
            var user = new UserBuilder().WithId().Build();

            _repositoryMock.Setup(repo => repo.GetById(It.IsAny<Guid>())).Returns(existingRoom);

            //Act
            var result = _service.TryJoinRoom(existingRoom.Id, user, out string failureReason);

            //Assert
            Assert.That(result, Is.False);
            Assert.That(failureReason, Is.Not.Empty,
                () => "The failureReason should not empty when room is full.");
        }

        [MonitoredTest("TryJoinRoom - Should return false when the user is already in the room")]
        public void TryJoinRoom_ShouldReturnFalseWhenTheUserIsAlreadyInTheRoom()
        {
            //Arrange
            var existingRoom = new WaitingRoomBuilder().WithId().Build();
            var user = existingRoom.Users.First();

            _repositoryMock.Setup(repo => repo.GetById(It.IsAny<Guid>())).Returns(existingRoom);

            //Act
            var result = _service.TryJoinRoom(existingRoom.Id, user, out string failureReason);

            //Assert
            Assert.That(result, Is.False);
            Assert.That(failureReason, Is.Not.Empty,
                () => "The failureReason should not empty when the user is already in the room.");
            Assert.That(existingRoom.Users, Has.Count.EqualTo(1),
                () => "The amount of users in the room should stay the same when the user is already in the room.");
        }

        [MonitoredTest("TryLeaveRoom - Should return true when the user is in the room")]
        public void TryLeaveRoom_ShouldReturnTrueWhenTheUserIsInTheRoom()
        {
            //Arrange      
            var user = new UserBuilder().WithId().Build();
            var existingRoom = new WaitingRoomBuilder()
                .WithId()
                .WithNumberOfUsers(1)
                .WithUser(user)
                .Build();

            _repositoryMock.Setup(repo => repo.GetById(It.IsAny<Guid>())).Returns(existingRoom);

            //Act
            var result = _service.TryLeaveRoom(existingRoom.Id, user, out string failureReason);

            //Assert
            _repositoryMock.Verify(repo => repo.GetById(existingRoom.Id), Times.Once,
                "The GetById method of the repository is not called correctly.");
            Assert.That(result, Is.True);
            Assert.That(failureReason, Is.Null.Or.Empty,
                () => "The failureReason should be empty when the user can be removed.");
            Assert.That(existingRoom.Users, Has.Count.EqualTo(1),
                () => "The amount of users in the room is not correct.");
            Assert.That(existingRoom.Users.All(u => u.Id != user.Id), Is.True, 
                () => "The user can still be found in the room.");
            _repositoryMock.Verify(repo => repo.DeleteById(It.IsAny<Guid>()), Times.Never, 
                "The room should not be deleted when there is still another user in the room.");
        }

        [MonitoredTest("TryLeaveRoom - Should return false when the room does not exist")]
        public void TryLeaveRoom_ShouldReturnFalseWhenTheRoomDoesNotExist()
        {
            //Arrange
            var nonExistingRoom = new WaitingRoomBuilder().WithNumberOfUsers(1).WithId().Build();
            var user = new UserBuilder().WithId().Build();

            _repositoryMock.Setup(repo => repo.GetById(It.IsAny<Guid>())).Throws<DataNotFoundException>();

            //Act
            var result = _service.TryLeaveRoom(nonExistingRoom.Id, user, out string failureReason);

            //Assert
            _repositoryMock.Verify(repo => repo.GetById(nonExistingRoom.Id), Times.Once,
                "The GetById method of the repository is not called correctly.");
            Assert.That(result, Is.False);
            Assert.That(failureReason, Is.Not.Empty, 
                () => "The failureReason should not empty when room does not exist.");
            _repositoryMock.Verify(repo => repo.DeleteById(It.IsAny<Guid>()), Times.Never,
                "The room should not be deleted when there is still another user in the room.");
        }

        [MonitoredTest("TryLeaveRoom - Should return false when the user is not linked to the room")]
        public void TryLeaveRoom_ShouldReturnFalseWhenTheUserIsNotLinkedToTheRoom()
        {
            //Arrange
            var existingRoom = new WaitingRoomBuilder().WithId().Build();
            var user = new UserBuilder().WithId().Build();

            _repositoryMock.Setup(repo => repo.GetById(It.IsAny<Guid>())).Returns(existingRoom);

            //Act
            var result = _service.TryLeaveRoom(existingRoom.Id, user, out string failureReason);

            //Assert
            Assert.That(result, Is.False);
            Assert.That(failureReason, Is.Not.Empty,
                () => "The failureReason should not empty when the user is not linked to the room.");
            Assert.That(existingRoom.Users, Has.Count.EqualTo(1), 
                "The amount of users in the room should stay the same.");
            _repositoryMock.Verify(repo => repo.DeleteById(It.IsAny<Guid>()), Times.Never,
                "The room should not be deleted when there is still another user in the room.");
        }

        [MonitoredTest("TryLeaveRoom - Should delete the room when the creator leaves")]
        public void TryLeaveRoom_ShouldDeleteTheRoomWhenTheCreatorLeaves()
        {
            //Arrange
            var existingRoom = new WaitingRoomBuilder().WithId().WithNumberOfUsers(2).Build();
            var creator = existingRoom.Users.First(u => u.Id == existingRoom.CreatorUserId);

            _repositoryMock.Setup(repo => repo.GetById(It.IsAny<Guid>())).Returns(existingRoom);

            //Act
            var result = _service.TryLeaveRoom(existingRoom.Id, creator, out string failureReason);

            //Assert
            Assert.That(result, Is.True);
            Assert.That(failureReason, Is.Null.Or.Empty,
                () => "The failureReason should be empty when the user can leave.");
            _repositoryMock.Verify(repo => repo.DeleteById(existingRoom.Id), Times.Once, 
                "The DeleteById method of the repository is not called correctly.");
        }
    }
}