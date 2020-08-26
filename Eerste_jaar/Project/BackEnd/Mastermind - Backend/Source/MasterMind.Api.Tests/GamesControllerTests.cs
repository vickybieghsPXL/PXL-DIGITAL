using MasterMind.Api.Controllers;
using MasterMind.Business.Services;
using MasterMind.Data;
using MasterMind.Data.DomainClasses;
using MasterMind.TestTools.Builders;
using Microsoft.AspNetCore.Http;
using Microsoft.AspNetCore.Identity;
using Microsoft.AspNetCore.Mvc;
using Microsoft.Extensions.Logging;
using Moq;
using NUnit.Framework;
using System;
using System.Collections.Generic;
using System.Security.Claims;
using Guts.Client.Core;
using Guts.Client.Shared;

namespace MasterMind.Api.Tests
{
    [ProjectComponentTestFixture("1TINProject", "MasterMind", "GamesCtlr", @"MasterMind.Api\Controllers\GamesController.cs")]
    public class GamesControllerTests
    {
        private Mock<IGameService> _gameServiceMock;
        private Mock<UserManager<User>> _userManagerMock;
        private GamesController _controller;
        private ClaimsPrincipal _userClaimsPrincipal;

        [SetUp]
        public void SetUp()
        {
            _gameServiceMock = new Mock<IGameService>();

            var userStoreMock = new Mock<IUserStore<User>>();
            var passwordHasherMock = new Mock<IPasswordHasher<User>>();
            var lookupNormalizerMock = new Mock<ILookupNormalizer>();
            var errorsMock = new Mock<IdentityErrorDescriber>();
            var loggerMock = new Mock<ILogger<UserManager<User>>>();
            _userManagerMock = new Mock<UserManager<User>>(
                userStoreMock.Object,
                null,
                passwordHasherMock.Object,
                null,
                null,
                lookupNormalizerMock.Object,
                errorsMock.Object,
                null,
                loggerMock.Object);

            _controller = new GamesController(_gameServiceMock.Object, _userManagerMock.Object);

            _userClaimsPrincipal = new ClaimsPrincipal(new ClaimsIdentity(new List<Claim>()));
            var context = new ControllerContext { HttpContext = new DefaultHttpContext() };
            context.HttpContext.User = _userClaimsPrincipal;
            _controller.ControllerContext = context;
        }

        [MonitoredTest("StartNewGame - Should create a game for a valid roomId and return it")]
        public void StartNewGame_ShouldCreateAGameForAValidRoomIdAndReturnIt()
        {
            //Arrange
            var existingRoomId = Guid.NewGuid();
            var createdGame = new GameBuilder().WithId().Build();
            _gameServiceMock.Setup(service => service.StartGameForRoom(It.IsAny<Guid>())).Returns(createdGame);


            //Act
            var result = _controller.StartNewGame(existingRoomId) as CreatedAtActionResult;

            //Assert
            Assert.That(result, Is.Not.Null, () => "An instance of 'CreatedAtActionResult' should be returned.");


            _gameServiceMock.Verify(service => service.StartGameForRoom(existingRoomId), Times.Once,
                "The 'StartGameForRoom' method of the service is not invoked properly.");
            Assert.That(result.ActionName, Is.EqualTo("GetGame"), () => "The 'CreatedAtActionResult' does not refer to the right action.");
            Assert.That(result.RouteValues["id"], Is.EqualTo(createdGame.Id), () => "The 'CreatedAtActionResult' does not refer to the right game room id.");
            Assert.That(result.Value, Is.EqualTo(createdGame), () => "The 'CreatedAtActionResult' does not hold the correct game room object.");
        }

        [MonitoredTest("StartNewGame - Should return a BadRequestObjectResult when the room does not exist")]
        public void StartNewGame_ShouldReturnBadRequestWhenTheRoomDoesNotExist()
        {
            //Arrange
            var nonExistingRoomId = Guid.NewGuid();
            _gameServiceMock.Setup(service => service.StartGameForRoom(It.IsAny<Guid>())).Throws<DataNotFoundException>();

            //Act
            var result = _controller.StartNewGame(nonExistingRoomId) as BadRequestObjectResult;

            //Assert
            Assert.That(result, Is.Not.Null, () => "An instance of BadRequestObjectResult should be returned.");
            _gameServiceMock.Verify(service => service.StartGameForRoom(nonExistingRoomId), Times.Once,
                "The 'StartGameForRoom' method of the service is not invoked properly.");
        }

        [MonitoredTest("StartNewGame - Should return a BadRequestObjectResult when the service throws an ApplicationException")]
        public void StartNewGame_ShouldReturnBadRequestWhenTheServiceThrowsAnApplicationException()
        {
            //Arrange
            var existingRoomId = Guid.NewGuid();
            _gameServiceMock.Setup(service => service.StartGameForRoom(It.IsAny<Guid>())).Throws<ApplicationException>();

            //Act
            var result = _controller.StartNewGame(existingRoomId) as BadRequestObjectResult;

            //Assert
            Assert.That(result, Is.Not.Null, () => "An instance of BadRequestObjectResult should be returned.");
            _gameServiceMock.Verify(service => service.StartGameForRoom(existingRoomId), Times.Once,
                "The 'StartGameForRoom' method of the service is not invoked properly.");
        }

        [MonitoredTest("GetGame - Should return an existing game from the service")]
        public void GetGame_ShouldReturnExistingGameFromService()
        {
            //Arrange
            var existingGame = new GameBuilder().WithId().Build();
            _gameServiceMock.Setup(service => service.GetGameById(It.IsAny<Guid>())).Returns(existingGame);

            //Act
            var result = _controller.GetGame(existingGame.Id) as OkObjectResult;

            //Assert
            Assert.That(result, Is.Not.Null, () => "An instance of 'OkObjectResult' should be returned.");
            _gameServiceMock.Verify(service => service.GetGameById(existingGame.Id), Times.Once,
                "The 'GetGameById' method of the service is not invoked properly.");
            Assert.That(result.Value, Is.SameAs(existingGame), () => "The 'OkObjectResult' does not hold the retrieved game.");
        }

        [MonitoredTest("GetGame - Should return a NotFoundResult when the game does not exist")]
        public void GetGame_ShouldReturnNotFoundWhenTheGameDoesNotExist()
        {
            //Arrange
            var noneExistingGameId = Guid.NewGuid();
            _gameServiceMock.Setup(service => service.GetGameById(It.IsAny<Guid>())).Throws<DataNotFoundException>();

            //Act
            var result = _controller.GetGame(noneExistingGameId) as NotFoundResult;

            //Assert
            Assert.That(result, Is.Not.Null, () => "An instance of NotFoundResult should be returned.");
            _gameServiceMock.Verify(service => service.GetGameById(noneExistingGameId), Times.Once,
                "The 'GetGameById' method of the service is not invoked properly.");
        }

        [MonitoredTest("CanGuessCode - Should return Ok when the current user can do a guess")]
        public void CanGuessCode_ShouldReturnOkWhenTheCurrentUserCanDoAGuess()
        {
            //Arrange
            var existingUser = new UserBuilder().WithId().Build();
            var roundNumber = new Random().Next(1, int.MaxValue);
            _userManagerMock.Setup(manager => manager.GetUserAsync(It.IsAny<ClaimsPrincipal>()))
                .ReturnsAsync(existingUser);

            _gameServiceMock.Setup(service => service.CanGuessCode(It.IsAny<Guid>(), It.IsAny<IPlayer>(), It.IsAny<int>()))
                .Returns(CanGuessResult.Ok);
            var existingGameId = Guid.NewGuid();

            //Act
            var result = _controller.CanGuessCode(existingGameId, roundNumber).Result as OkObjectResult;

            //Assert
            _userManagerMock.Verify(manager => manager.GetUserAsync(_userClaimsPrincipal), Times.Once,
                "The current user is not retrieved using the current claims principal.");
            Assert.That(result, Is.Not.Null, () => "An instance of OkObjectResult should be returned.");
            Assert.That(result.Value, Is.EqualTo(CanGuessResult.Ok), () => "The value of the OkObjectResult should be 'CanGuessResult.Ok'.");
            _gameServiceMock.Verify(service => service.CanGuessCode(existingGameId, existingUser, roundNumber), Times.Once,
                "The 'CanGuessCode' method of the service is not called correctly.");
        }

        [MonitoredTest("CanGuessCode - Should return MustWaitOnOthers when the current user must wait on guesses of others")]
        public void CanGuessCode_ShouldReturnMustWaitOnOthersWhenTheCurrentUserMustWaitOnGuessesOfOthers()
        {
            //Arrange
            var existingUser = new UserBuilder().WithId().Build();
            var roundNumber = new Random().Next(1, int.MaxValue);
            _userManagerMock.Setup(manager => manager.GetUserAsync(It.IsAny<ClaimsPrincipal>()))
                .ReturnsAsync(existingUser);

            _gameServiceMock.Setup(service => service.CanGuessCode(It.IsAny<Guid>(), It.IsAny<IPlayer>(), It.IsAny<int>()))
                .Returns(CanGuessResult.MustWaitOnOthers);
            var existingGameId = Guid.NewGuid();

            //Act
            var result = _controller.CanGuessCode(existingGameId, roundNumber).Result as OkObjectResult;

            //Assert
            _userManagerMock.Verify(manager => manager.GetUserAsync(_userClaimsPrincipal), Times.Once,
                "The current user is not retrieved using the current claims principal.");
            Assert.That(result, Is.Not.Null, () => "An instance of OkObjectResult should be returned.");
            Assert.That(result.Value, Is.EqualTo(CanGuessResult.MustWaitOnOthers), 
                () => "The value of the OkObjectResult should be 'CanGuessResult.MustWaitOnOthers'.");
            _gameServiceMock.Verify(service => service.CanGuessCode(existingGameId, existingUser, roundNumber), Times.Once,
                "The 'CanGuessCode' method of the service is not called correctly.");
        }

        [MonitoredTest("CanGuessCode - Should return a BadRequestObjectResult when the service throws a DataNotFoundException")]
        public void CanGuessCode_ShouldReturnABadRequestWhenTheServiceThrowsADataNotFoundException()
        {
            //Arrange
            var existingUser = new UserBuilder().WithId().Build();
            var roundNumber = new Random().Next(1, int.MaxValue);
            _userManagerMock.Setup(manager => manager.GetUserAsync(It.IsAny<ClaimsPrincipal>()))
                .ReturnsAsync(existingUser);

            _gameServiceMock.Setup(service => service.CanGuessCode(It.IsAny<Guid>(), It.IsAny<IPlayer>(), It.IsAny<int>()))
                .Throws<DataNotFoundException>();
            var nonExistingGameId = Guid.NewGuid();

            //Act
            var result = _controller.CanGuessCode(nonExistingGameId, roundNumber).Result as BadRequestObjectResult;

            //Assert
            Assert.That(result, Is.Not.Null, () => "An instance of BadRequestObjectResult should be returned.");
            _gameServiceMock.Verify(service => service.CanGuessCode(nonExistingGameId, existingUser, roundNumber), Times.Once,
                "The 'CanGuessCode' method of the service is not called correctly.");
        }

        [MonitoredTest("GuessCode - Should return a GuessResult object")]
        public void GuessCode_ShouldReturnAGuessResultOjbect()
        {
            //Arrange
            var existingUser = new UserBuilder().WithId().Build();
            _userManagerMock.Setup(manager => manager.GetUserAsync(It.IsAny<ClaimsPrincipal>()))
                .ReturnsAsync(existingUser);

            var guessResult = new GuessResultBuilder().Build();
            _gameServiceMock.Setup(service => service.GuessCode(It.IsAny<Guid>(), It.IsAny<string[]>(), It.IsAny<IPlayer>()))
                .Returns(guessResult);
            var existingGameId = Guid.NewGuid();

            var model = new GuessModelBuilder().Build();

            //Act
            var result = _controller.GuessCode(existingGameId, model).Result as OkObjectResult;

            //Assert
            _userManagerMock.Verify(manager => manager.GetUserAsync(_userClaimsPrincipal), Times.Once,
                "The current user is not retrieved using the current claims principal.");
            Assert.That(result, Is.Not.Null, () => "An instance of OkObjectResult should be returned.");
            Assert.That(result.Value, Is.EqualTo(guessResult), () => "The value of the OkObjectResult should be the object returned by the service.");
            _gameServiceMock.Verify(service => service.GuessCode(existingGameId, model.Colors, existingUser), Times.Once,
                "The 'GuessCode' method of the service is not called correctly.");
        }

        [MonitoredTest("GuessCode - Should return a BadRequestObjectResult when the service throws a DataNotFoundException")]
        public void GuessCode_ShouldReturnABadRequestWhenTheServiceThrowsADataNotFoundException()
        {
            //Arrange
            var existingUser = new UserBuilder().WithId().Build();
            _userManagerMock.Setup(manager => manager.GetUserAsync(It.IsAny<ClaimsPrincipal>()))
                .ReturnsAsync(existingUser);

            _gameServiceMock.Setup(service => service.GuessCode(It.IsAny<Guid>(), It.IsAny<string[]>(), It.IsAny<IPlayer>()))
                .Throws<DataNotFoundException>();
            var nonExistingGameId = Guid.NewGuid();

            var model = new GuessModelBuilder().Build();

            //Act
            var result = _controller.GuessCode(nonExistingGameId, model).Result as BadRequestObjectResult;

            //Assert
            Assert.That(result, Is.Not.Null, () => "An instance of BadRequestObjectResult should be returned.");
            _gameServiceMock.Verify(service => service.GuessCode(nonExistingGameId, model.Colors, existingUser), Times.Once,
                "The 'GuessCode' method of the service is not called correctly.");
        }

        [MonitoredTest("GuessCode - Should return a BadRequestObjectResult when the service throws an ApplicationException")]
        public void GuessCode_ShouldReturnABadRequestWhenTheServiceThrowsAnApplicationException()
        {
            //Arrange
            var existingUser = new UserBuilder().WithId().Build();
            _userManagerMock.Setup(manager => manager.GetUserAsync(It.IsAny<ClaimsPrincipal>()))
                .ReturnsAsync(existingUser);

            _gameServiceMock.Setup(service => service.GuessCode(It.IsAny<Guid>(), It.IsAny<string[]>(), It.IsAny<IPlayer>()))
                .Throws<ApplicationException>();
            var nonExistingGameId = Guid.NewGuid();

            var model = new GuessModelBuilder().Build();

            //Act
            var result = _controller.GuessCode(nonExistingGameId, model).Result as BadRequestObjectResult;

            //Assert
            Assert.That(result, Is.Not.Null, () => "An instance of BadRequestObjectResult should be returned.");
            _gameServiceMock.Verify(service => service.GuessCode(nonExistingGameId, model.Colors, existingUser), Times.Once,
                "The 'GuessCode' method of the service is not called correctly.");
        }

        [MonitoredTest("GetGameStatus - Should return the GameStatus form the service")]
        public void GetGameStatus_ShouldReturnGameStatusFromService()
        {
            //Arrange
            var existingGameId = Guid.NewGuid();
            var existingGameStatus = new GameStatus();

            _gameServiceMock.Setup(service => service.GetGameStatus(It.IsAny<Guid>())).Returns(existingGameStatus);

            //Act
            var result = _controller.GetGameStatus(existingGameId) as OkObjectResult;

            //Assert
            Assert.That(result, Is.Not.Null, () => "An instance of OkObjectResult should be returned.");

            _gameServiceMock.Verify(service => service.GetGameStatus(existingGameId), Times.Once,
                "The 'GetGameStatus' method of the service is not called correctly.");

            var gameStatus = result.Value as GameStatus;
            Assert.That(gameStatus, Is.Not.Null, () => "The value of the 'OkObjectResult' should be an instance of 'GameStatus'.");
            Assert.That(gameStatus, Is.SameAs(existingGameStatus),
                () => "The object returned by the 'GetGameStatus' method of the service should be the value of the 'OkObjectResult'.");
        }

        [MonitoredTest("GetGameStatus - Should return a BadRequestObjectResult when the service throws a DataNotFoundException")]
        public void GetGameStatus_ShouldReturnBadRequestIfTheServiceThrowsADataNotFoundException()
        {
            //Arrange
            var existingGameId = Guid.NewGuid();

            _gameServiceMock.Setup(service => service.GetGameStatus(It.IsAny<Guid>())).Throws<DataNotFoundException>();

            //Act
            var result = _controller.GetGameStatus(existingGameId) as BadRequestObjectResult;

            //Assert
            Assert.That(result, Is.Not.Null, () => "An instance of BadRequestObjectResult should be returned.");
        }
    }
}