using Guts.Client.Shared;
using Guts.Client.Shared.TestTools;
using MasterMind.Business.Services;
using MasterMind.Data.DomainClasses;
using MasterMind.Data.Repositories;
using MasterMind.TestTools.Builders;
using Moq;
using NUnit.Framework;
using System;
using Guts.Client.Core;

namespace MasterMind.Business.Tests
{
    [ProjectComponentTestFixture("1TINProject", "MasterMind", "GameService", @"MasterMind.Business\Services\GameService.cs")]
    public class GameServiceTests
    {
        private GameService _service;
        private Mock<IWaitingRoomService> _waitingRoomServiceMock;
        private Mock<IGameRepository> _gameRepositoryMock;

        [SetUp]
        public void SetUp()
        {
            _waitingRoomServiceMock = new Mock<IWaitingRoomService>();
            _gameRepositoryMock = new Mock<IGameRepository>();
            _service = new GameService(_waitingRoomServiceMock.Object, _gameRepositoryMock.Object);
        }

        [MonitoredTest("Constructor - Should assign the IWaitingRoomService to a private field")]
        public void Constructor_ShouldAssignTheIWaitingRoomServiceToAPrivateField()
        {
            //Assert
            if (_service.HasPrivateField<IWaitingRoomService>())
            {
                IWaitingRoomService waitingRoomServiceFieldValue = _service.GetPrivateFieldValue<IWaitingRoomService>();
                Assert.That(waitingRoomServiceFieldValue, Is.EqualTo(_waitingRoomServiceMock.Object), "The constructor parameter 'waitingRoomService' is not assigned to the private field.");
            }
            else
            {
                Assert.Fail("Cannot find a private field (instance variable) of type 'IWaitingRoomRepository'.");
            }
        }

        [MonitoredTest("Constructor - Should assign the IGameRepository to a private field")]
        public void Constructor_ShouldAssignTheIGameRepositoryToAPrivateField()
        {
            //Assert
            if (_service.HasPrivateField<IGameRepository>())
            {
                IGameRepository gameRepositoryFieldValue = _service.GetPrivateFieldValue<IGameRepository>();
                Assert.That(gameRepositoryFieldValue, Is.EqualTo(_gameRepositoryMock.Object), "The constructor parameter 'gameRepository' is not assigned to the private field.");
            }
            else
            {
                Assert.Fail("Cannot find a private field (instance variable) of type 'IGameRepository'.");
            }
        }

        [MonitoredTest("StartGameForRoom - Should retrieve the room, create a game from it and save it")]
        public void StartGameForRoom_ShouldRetrieveTheRoomCreateAGameFromItAndSaveIt()
        {
            //Arrange
            var existingRoom = new WaitingRoomBuilder().WithId().WithNumberOfUsers(2).Build();

            _waitingRoomServiceMock.Setup(service => service.GetRoomById(It.IsAny<Guid>())).Returns(existingRoom);
            _gameRepositoryMock.Setup(repo => repo.Add(It.IsAny<IGame>())).Returns((IGame game) =>
            {
                game.Id = Guid.NewGuid();
                return game;
            });

            //Act
            var result = _service.StartGameForRoom(existingRoom.Id);

            //Assert
            Assert.That(result, Is.Not.Null,
                () => "No object of typee 'IGame' is returned.");
            Assert.That(result.Settings, Is.SameAs(existingRoom.GameSettings),
                () => "The 'Settings' of the game should be the same object as the 'GameSettings' of the room.");
            Assert.That(result.Players, Has.Count.GreaterThanOrEqualTo(existingRoom.Users.Count),
                () => "The number of players in the game should be at least be equal to the numbers of users in the room " +
                      "(and optionally some extra AI players).");
            _gameRepositoryMock.Verify(repo => repo.Add(result), Times.Once,
                "The 'Add' method of the repository should be called with the created game object.");
            Assert.That(existingRoom.GameId, Is.EqualTo(result.Id),
                () => "After the game is added to the reposoitory, the 'Id' of the game should be set for the waiting room " +
                      "(so that others now there is already a game for that room).");

        }

        [MonitoredTest("StartGameForRoom - Should throw an ApplicationException when there are less than two users in the room")]
        public void StartGameForRoom_ShouldThrowAnApplicationExceptionWhenThereAreLessThanTwoUsersInTheRoom()
        {
            //Arrange
            var existingRoom = new WaitingRoomBuilder().WithId().WithNumberOfUsers(1).Build();
            _waitingRoomServiceMock.Setup(service => service.GetRoomById(It.IsAny<Guid>())).Returns(existingRoom);

            //Act + Assert
            Assert.That(() => _service.StartGameForRoom(existingRoom.Id), Throws.InstanceOf<ApplicationException>());

            _gameRepositoryMock.Verify(repo => repo.Add(It.IsAny<IGame>()), Times.Never,
                "The 'Add' method of the repository should not be called.");
        }

        [MonitoredTest("GetGameById - Should call the repository and pass through the result")]
        public void GetGameById_ShouldCallTheRepositoryAndPassThroughTheResult()
        {
            //Arrange
            var existingGame = new GameBuilder().WithId().Build();
            _gameRepositoryMock.Setup(repo => repo.GetById(It.IsAny<Guid>())).Returns(existingGame);

            //Act
            var result = _service.GetGameById(existingGame.Id);

            //Assert
            _gameRepositoryMock.Verify(repo => repo.GetById(existingGame.Id), Times.Once,
                "The 'GetById' method of the repository is not called correctly.");
            Assert.That(result, Is.SameAs(existingGame),
                () => "The game returned is not the same game object that is returned by the repository.");
        }

        [MonitoredTest("CanGuessCode - Should should retrieve the game and check if the player can do a guess")]
        public void CanGuessCode_ShouldRetrieveTheGameAndCheckIfThePlayerCanDoAGuess()
        {
            //Arrange
            var gameId = Guid.NewGuid();
            var roundNumber = new Random().Next(1, int.MaxValue);
            var gameMock = new Mock<IGame>();
            gameMock.Setup(game => game.CanGuessCode(It.IsAny<IPlayer>(), It.IsAny<int>())).Returns(CanGuessResult.Ok);
            gameMock.SetupGet(game => game.CurrentRound).Returns(1);

            var player = new UserBuilder().WithId().Build();
            _gameRepositoryMock.Setup(repo => repo.GetById(It.IsAny<Guid>())).Returns(gameMock.Object);

            //Act
            var result = _service.CanGuessCode(gameId, player, roundNumber);

            //Assert
            _gameRepositoryMock.Verify(repo => repo.GetById(gameId), Times.Once,
                "The 'GetById' method of the repository is not called correctly.");
            gameMock.Verify(game => game.CanGuessCode(player, roundNumber), Times.Once,
                "The 'CanGuessCode' method of the game object returned by the repository is not called correctly.");
            Assert.That(result, Is.EqualTo(CanGuessResult.Ok),
                () => "The result of the 'CanGuessCode' method of the game object should be returned.");
        }

        [MonitoredTest("GuessCode - Should retrieve the game, check if the player can do a guess and then do the guess")]
        public void GuessCode_ShouldRetrieveTheGameCheckIfThePlayerCanDoAGuessAndDoTheGuess()
        {
            //Arrange
            var gameId = Guid.NewGuid();
            var roundNumber = new Random().Next(1, int.MaxValue);
            var gameMock = new Mock<IGame>();
            gameMock.Setup(game => game.CanGuessCode(It.IsAny<IPlayer>(), It.IsAny<int>())).Returns(CanGuessResult.Ok);
            gameMock.SetupGet(game => game.CurrentRound).Returns(roundNumber);

            var player = new UserBuilder().WithId().Build();
            _gameRepositoryMock.Setup(repo => repo.GetById(It.IsAny<Guid>())).Returns(gameMock.Object);

            var colors = new GuessModelBuilder().Build().Colors;
            var guessResult = new GuessResultBuilder().Build();
            gameMock.Setup(game => game.GuessCode(It.IsAny<string[]>(), It.IsAny<IPlayer>())).Returns(guessResult);

            //Act
            var result = _service.GuessCode(gameId, colors, player);

            //Assert
            _gameRepositoryMock.Verify(repo => repo.GetById(gameId), Times.Once,
                "The 'GetById' method of the repository is not called correctly.");
            gameMock.Verify(game => game.CanGuessCode(player, roundNumber), Times.Once,
                "The 'CanGuessCode' method of the game object returned by the repository is not called correctly.");
            gameMock.Verify(game => game.GuessCode(colors, player), Times.Once,
                "The 'GuessCode' method of the game object returned by the repository is not called correctly.");
            Assert.That(result, Is.SameAs(guessResult),
                () => "The result of the 'GuessCode' method of the game object should be returned.");
        }

        [MonitoredTest("GuessCode - Should throw an ApplicationException when the player cannot do a guess")]
        public void GuessCode_ShouldThrowAnApplicationExceptionWhenThePlayerCannotDoAGuess()
        {
            //Arrange
            var gameId = Guid.NewGuid();
            var roundNumber = new Random().Next(1, int.MaxValue);
            var gameMock = new Mock<IGame>();
            gameMock.Setup(game => game.CanGuessCode(It.IsAny<IPlayer>(), It.IsAny<int>())).Returns(CanGuessResult.MustWaitOnOthers);
            gameMock.SetupGet(game => game.CurrentRound).Returns(roundNumber);

            var player = new UserBuilder().WithId().Build();
            _gameRepositoryMock.Setup(repo => repo.GetById(It.IsAny<Guid>())).Returns(gameMock.Object);

            var colors = new GuessModelBuilder().Build().Colors;

            //Act + Assert
            Assert.That(() => _service.GuessCode(gameId, colors, player), Throws.InstanceOf<ApplicationException>());
            _gameRepositoryMock.Verify(repo => repo.GetById(gameId), Times.Once,
                "The 'GetById' method of the repository is not called correctly.");
            gameMock.Verify(game => game.CanGuessCode(player, roundNumber), Times.Once,
                "The 'CanGuessCode' method of the game object returned by the repository is not called correctly.");
            gameMock.Verify(game => game.GuessCode(It.IsAny<string[]>(), It.IsAny<IPlayer>()), Times.Never,
                "The 'GuessCode' method of the game object returned by the repository should not be called.");
        }

        [MonitoredTest("GetGameStatus - Should retrieve the game and get the status of that game")]
        public void GetGameStatus_ShouldRetrieveTheGameAndGetTheStatusOfThatGame()
        {
            //Arrange
            var gameId = Guid.NewGuid();
            var gameMock = new Mock<IGame>();
            var gameStatus = new GameStatus();
            gameMock.Setup(game => game.GetStatus()).Returns(gameStatus);
            _gameRepositoryMock.Setup(repo => repo.GetById(It.IsAny<Guid>())).Returns(gameMock.Object);

            //Act
            var result = _service.GetGameStatus(gameId);

            //Assert
            _gameRepositoryMock.Verify(repo => repo.GetById(gameId), Times.Once,
                "The 'GetById' method of the repository is not called correctly.");
            gameMock.Verify(game => game.GetStatus(), Times.Once,
                "The 'GetStatus' method of the game object returned by the repository is not called correctly.");
            Assert.That(result, Is.SameAs(gameStatus),
                () => "The result of the 'GetStatus' method of the game object is not returned.");
        }
    }
}