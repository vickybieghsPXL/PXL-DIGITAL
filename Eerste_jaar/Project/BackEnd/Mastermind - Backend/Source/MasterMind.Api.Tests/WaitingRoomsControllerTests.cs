using MasterMind.Api.Controllers;
using MasterMind.Business.Models;
using MasterMind.Business.Services;
using MasterMind.Data;
using MasterMind.Data.DomainClasses;
using Microsoft.AspNetCore.Http;
using Microsoft.AspNetCore.Identity;
using Microsoft.AspNetCore.Mvc;
using Microsoft.Extensions.Logging;
using Moq;
using NUnit.Framework;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Security.Claims;
using Guts.Client.Core;
using Guts.Client.Shared;
using MasterMind.TestTools.Builders;

namespace MasterMind.Api.Tests
{
    delegate void TryJoinOrLeaveRoomCallback(Guid roomId, User user, out string reason);

    [ProjectComponentTestFixture("1TINProject", "MasterMind", "WaitingRoomsCtlr", @"MasterMind.Api\Controllers\WaitingRoomsController.cs")]
    public class WaitingRoomsControllerTests
    {
        private Mock<IWaitingRoomService> _waitingRoomServiceMock;
        private Mock<UserManager<User>> _userManagerMock;
        private WaitingRoomsController _controller;
        private ClaimsPrincipal _userClaimsPrincipal;

        [SetUp]
        public void SetUp()
        {
            _waitingRoomServiceMock = new Mock<IWaitingRoomService>();

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

            _controller = new WaitingRoomsController(_waitingRoomServiceMock.Object, _userManagerMock.Object);

            _userClaimsPrincipal = new ClaimsPrincipal(new ClaimsIdentity(new List<Claim>()));
            var context = new ControllerContext { HttpContext = new DefaultHttpContext() };
            context.HttpContext.User = _userClaimsPrincipal;
            _controller.ControllerContext = context;
        }

        [MonitoredTest("GetAvailableWaitingRooms - Should return available rooms from service")]
        public void GetAvailableWaitingRooms_ShouldReturnAvailableRoomsFromService()
        {
            //Arrange
            var allAvailableRooms = new List<WaitingRoom>
            {
                new WaitingRoomBuilder().WithId().Build(),
                new WaitingRoomBuilder().WithId().Build()
            };
            _waitingRoomServiceMock.Setup(service => service.GetAllAvailableRooms()).Returns(allAvailableRooms);

            //Act
            var result = _controller.GetAvailableWaitingRooms() as OkObjectResult;

            //Assert
            Assert.That(result, Is.Not.Null, () => "An instance of 'OkObjectResult' should be returned.");
            _waitingRoomServiceMock.Verify(service => service.GetAllAvailableRooms(), Times.Once,
                "The 'GetAllAvailableRooms' method of the service is not invoked properly.");
            Assert.That(result.Value, Is.SameAs(allAvailableRooms), () => "The 'OkObjectResult' does not hold the collection of available waiting rooms.");
        }

        [MonitoredTest("StartNewWaitingRoom - Should create a waiting room and return it")]
        public void StartNewWaitingRoom_ShouldCreateAWaitingRoomAndReturnIt()
        {
            //Arrange
            var existingUser = new UserBuilder().WithId().Build();
            _userManagerMock.Setup(manager => manager.GetUserAsync(It.IsAny<ClaimsPrincipal>()))
                .ReturnsAsync(existingUser);

            WaitingRoom createdRoom = new WaitingRoomBuilder().WithId().Build();
            _waitingRoomServiceMock.Setup(service => service.CreateRoom(It.IsAny<WaitingRoomCreationModel>(), It.IsAny<User>())).Returns(createdRoom);

            var model = new WaitingRoomCreationModelBuilder().Build();

            //Act
            var result = _controller.StartNewWaitingRoom(model).Result as CreatedAtActionResult;

            //Assert
            Assert.That(result, Is.Not.Null, () => "An instance of 'CreatedAtActionResult' should be returned.");
            _userManagerMock.Verify(manager => manager.GetUserAsync(_userClaimsPrincipal), Times.Once,
                "The current user is not retrieved using the current claims principal.");
            _waitingRoomServiceMock.Verify(service => service.CreateRoom(model, existingUser), Times.Once,
                "The 'CreateRoom' method of the service is not invoked properly.");
            Assert.That(result.ActionName, Is.EqualTo("GetWaitingRoom"), () => "The 'CreatedAtActionResult' does not refer to the right action.");
            Assert.That(result.RouteValues["id"], Is.EqualTo(createdRoom.Id), () => "The 'CreatedAtActionResult' does not refer to the right waiting room id.");
            Assert.That(result.Value, Is.EqualTo(createdRoom), () => "The 'CreatedAtActionResult' does not hold the correct waiting room object.");
        }

        [MonitoredTest("StartNewWaitingRoom - Should return a BadRequestObjectResult when the room name is too short")]
        public void StartNewWaitingRoom_ShouldReturnBadRequestWhenRoomNameIsTooShort()
        {
            //Arrange
            var model = new WaitingRoomCreationModelBuilder().WithName("aa").Build();
            _controller.ModelState.AddModelError("InvalidLength", "Room name must be at least 3 characters long");

            var existingUser = new User();
            _userManagerMock.Setup(manager => manager.GetUserAsync(It.IsAny<ClaimsPrincipal>()))
                .ReturnsAsync(existingUser);

            WaitingRoom createdRoom = new WaitingRoomBuilder().Build();
            _waitingRoomServiceMock.Setup(service => service.CreateRoom(It.IsAny<WaitingRoomCreationModel>(), It.IsAny<User>())).Returns(createdRoom);

            //Act
            var result = _controller.StartNewWaitingRoom(model).Result as BadRequestObjectResult;

            //Assert
            Assert.That(result, Is.Not.Null, () => "An instance of BadRequestObjectResult should be returned.");
            _userManagerMock.Verify(manager => manager.GetUserAsync(It.IsAny<ClaimsPrincipal>()), Times.Never,
                "The user should not be retrieved when the request is bad.");
            _waitingRoomServiceMock.Verify(service => service.CreateRoom(It.IsAny<WaitingRoomCreationModel>(), It.IsAny<User>()), Times.Never,
                "The room should not be created when the request is bad.");
        }

        [MonitoredTest("StartNewWaitingRoom - Should return a BadRequestResult when game settings are missing")]
        public void StartNewWaitingRoom_ShouldReturnBadRequestWhenGameSettingsAreMissing()
        {
            //Arrange
            var model = new WaitingRoomCreationModelBuilder().Build();
            model.GameSettings = null;
            _controller.ModelState.AddModelError("GameSettingsRequired", "GameSettings is required.");

            var existingUser = new User();
            _userManagerMock.Setup(manager => manager.GetUserAsync(It.IsAny<ClaimsPrincipal>()))
                .ReturnsAsync(existingUser);

            WaitingRoom createdRoom = new WaitingRoomBuilder().Build();
            _waitingRoomServiceMock.Setup(service => service.CreateRoom(It.IsAny<WaitingRoomCreationModel>(), It.IsAny<User>())).Returns(createdRoom);

            //Act
            var result = _controller.StartNewWaitingRoom(model).Result as BadRequestObjectResult;

            //Assert
            Assert.That(result, Is.Not.Null, () => "An instance of BadRequestObjectResult should be returned.");
            _userManagerMock.Verify(manager => manager.GetUserAsync(It.IsAny<ClaimsPrincipal>()), Times.Never,
                "The user should not be retrieved when the request is bad.");
            _waitingRoomServiceMock.Verify(service => service.CreateRoom(It.IsAny<WaitingRoomCreationModel>(), It.IsAny<User>()), Times.Never,
                "The room should not be created when the request is bad.");
        }

        [MonitoredTest("StartNewWaitingRoom - Should return a BadRequestObjectResult when the waitingroom service throws an ApplicationException")]
        public void StartNewWaitingRoom_ShouldReturnBadRequestWhenServiceThrowsApplicationException()
        {
            //Arrange
            var model = new WaitingRoomCreationModelBuilder().Build();

            var existingUser = new User();
            _userManagerMock.Setup(manager => manager.GetUserAsync(It.IsAny<ClaimsPrincipal>()))
                .ReturnsAsync(existingUser);

            var errorMessage = Guid.NewGuid().ToString();
            _waitingRoomServiceMock
                .Setup(service => service.CreateRoom(It.IsAny<WaitingRoomCreationModel>(), It.IsAny<User>()))
                .Throws(new ApplicationException(errorMessage));

            //Act
            var result = _controller.StartNewWaitingRoom(model).Result as BadRequestObjectResult;

            //Assert
            Assert.That(result, Is.Not.Null, () => "An instance of BadRequestObjectResult should be returned.");
            AssertHasErrorMessage(result, errorMessage);
        }

        [MonitoredTest("GetWaitingRoom - Should return an existing room from the waitingroom service")]
        public void GetWaitingRoom_ShouldReturnExistingRoomFromService()
        {
            //Arrange
            var existingRoom = new WaitingRoomBuilder().WithId().Build();
            _waitingRoomServiceMock.Setup(service => service.GetRoomById(It.IsAny<Guid>())).Returns(existingRoom);

            //Act
            var result = _controller.GetWaitingRoom(existingRoom.Id) as OkObjectResult;

            //Assert
            Assert.That(result, Is.Not.Null, () => "An instance of 'OkObjectResult' should be returned.");
            _waitingRoomServiceMock.Verify(service => service.GetRoomById(existingRoom.Id), Times.Once,
                "The 'GetRoomById' method of the service is not invoked properly.");
            Assert.That(result.Value, Is.SameAs(existingRoom), () => "The 'OkObjectResult' does not hold the retrieved waiting room.");
        }

        [MonitoredTest("GetWaitingRoom - Should return a NotFoundResult if the room does not exist")]
        public void GetWaitingRoom_ShouldReturnNotFoundIfTheRoomDoesNotExist()
        {
            //Arrange
            var nonExistingRoom = new WaitingRoomBuilder().WithId().Build();
            _waitingRoomServiceMock.Setup(service => service.GetRoomById(It.IsAny<Guid>())).Throws<DataNotFoundException>();

            //Act
            var result = _controller.GetWaitingRoom(nonExistingRoom.Id) as NotFoundResult;

            //Assert
            Assert.That(result, Is.Not.Null, () => "An instance of 'NotFoundResult' should be returned.");
            _waitingRoomServiceMock.Verify(service => service.GetRoomById(nonExistingRoom.Id), Times.Once,
                "The 'GetRoomById' method of the service is not invoked properly.");
        }

        [MonitoredTest("JoinWaitingRoom - Should return an OkResult if the join succeeds")]
        public void JoinWaitingRoom_ShouldReturnOkResultIfJoinSucceeds()
        {
            //Arrange
            var existingUser = new UserBuilder().WithId().Build();
            _userManagerMock.Setup(manager => manager.GetUserAsync(It.IsAny<ClaimsPrincipal>()))
                .ReturnsAsync(existingUser);

            var existingRoom = new WaitingRoomBuilder().WithId().Build();
            string failureReason;
            _waitingRoomServiceMock.Setup(service => service.TryJoinRoom(It.IsAny<Guid>(), It.IsAny<User>(), out failureReason)).Returns(true);

            //Act
            var result = _controller.JoinWaitingRoom(existingRoom.Id).Result as OkResult;

            //Assert
            Assert.That(result, Is.Not.Null, () => "An instance of 'OkResult' should be returned.");
            _waitingRoomServiceMock.Verify(service => service.TryJoinRoom(existingRoom.Id, existingUser, out failureReason), Times.Once,
                "The 'TryJoinRoom' method of the service is not invoked properly.");
        }

        [MonitoredTest("JoinWaitingRoom - Should return a BadRequest if the join fails")]
        public void JoinWaitingRoom_ShouldReturnBadRequestIfJoinFails()
        {
            //Arrange
            var existingUser = new UserBuilder().WithId().Build();
            _userManagerMock.Setup(manager => manager.GetUserAsync(It.IsAny<ClaimsPrincipal>()))
                .ReturnsAsync(existingUser);

            var existingRoom = new WaitingRoomBuilder().WithId().Build();
            string failureReason = Guid.NewGuid().ToString();

            _waitingRoomServiceMock.Setup(service => service.TryJoinRoom(It.IsAny<Guid>(), It.IsAny<User>(), out failureReason))
                .Callback(new TryJoinOrLeaveRoomCallback((Guid id, User user, out string reason) =>
                {
                    reason = failureReason;
                }))
                .Returns(false);

            //Act
            var result = _controller.JoinWaitingRoom(existingRoom.Id).Result as BadRequestObjectResult;

            //Assert
            Assert.That(result, Is.Not.Null, () => "An instance of 'BadRequestObjectResult' should be returned.");
            _waitingRoomServiceMock.Verify(service => service.TryJoinRoom(existingRoom.Id, existingUser, out failureReason), Times.Once,
                "The 'TryJoinRoom' method of the service is not invoked properly.");
            AssertHasErrorMessage(result, failureReason);
        }

        [MonitoredTest("LeaveWaitingRoom - Should return an OkResult if leaving succeeds")]
        public void LeaveWaitingRoom_ShouldReturnOkResultIfLeaveSucceeds()
        {
            //Arrange
            var existingUser = new UserBuilder().WithId().Build();
            _userManagerMock.Setup(manager => manager.GetUserAsync(It.IsAny<ClaimsPrincipal>()))
                .ReturnsAsync(existingUser);

            var existingRoom = new WaitingRoomBuilder().WithId().Build();
            string failureReason;
            _waitingRoomServiceMock.Setup(service => service.TryLeaveRoom(It.IsAny<Guid>(), It.IsAny<User>(), out failureReason)).Returns(true);

            //Act
            var result = _controller.LeaveWaitingRoom(existingRoom.Id).Result as OkResult;

            //Assert
            Assert.That(result, Is.Not.Null, () => "An instance of 'OkResult' should be returned.");
            _waitingRoomServiceMock.Verify(service => service.TryLeaveRoom(existingRoom.Id, existingUser, out failureReason), Times.Once,
                "The 'TryLeaveRoom' method of the service is not invoked properly.");
        }

        [MonitoredTest("LeaveWaitingRoom - Should return a BadRequestObjectResult if leaving fails")]
        public void LeaveWaitingRoom_ShouldReturnBadRequestIfLeaveFails()
        {
            //Arrange
            var existingUser = new UserBuilder().WithId().Build();
            _userManagerMock.Setup(manager => manager.GetUserAsync(It.IsAny<ClaimsPrincipal>()))
                .ReturnsAsync(existingUser);

            var existingRoom = new WaitingRoomBuilder().WithId().Build();
            string failureReason = Guid.NewGuid().ToString();

            _waitingRoomServiceMock.Setup(service => service.TryLeaveRoom(It.IsAny<Guid>(), It.IsAny<User>(), out failureReason))
                .Callback(new TryJoinOrLeaveRoomCallback((Guid id, User user, out string reason) =>
                {
                    reason = failureReason;
                }))
                .Returns(false);

            //Act
            var result = _controller.LeaveWaitingRoom(existingRoom.Id).Result as BadRequestObjectResult;

            //Assert
            Assert.That(result, Is.Not.Null, () => "An instance of 'BadRequestObjectResult' should be returned.");
            _waitingRoomServiceMock.Verify(service => service.TryLeaveRoom(existingRoom.Id, existingUser, out failureReason), Times.Once,
                "The 'TryLeaveRoom' method of the service is not invoked properly.");
            AssertHasErrorMessage(result, failureReason);
        }

        private static void AssertHasErrorMessage(BadRequestObjectResult badRequestResult, string errorMessage)
        {
            var errorObject = badRequestResult.Value as SerializableError;
            Assert.That(errorObject, Is.Not.Null, () => "The object in the result should represent de ModelState dictionary.");
            var containsMessage = errorObject.Values.OfType<string[]>()
                .Any(messages => messages.Any(m => m == errorMessage));
            Assert.That(containsMessage, Is.True,
                () => "The ModelState dictionary should contain the correct error message.");
        }
    }
}
