using System;
using Guts.Client.Core;
using Guts.Client.Shared;
using MasterMind.Data.DomainClasses;
using MasterMind.TestTools.Builders;
using NUnit.Framework;

namespace MasterMind.Data.Tests
{
    [ProjectComponentTestFixture("1TINProject", "MasterMind", "WaitingRoom", @"MasterMind.Data\DomainClasses\WaitingRoom.cs")]
    public class WaitingRoomTests
    {
        [MonitoredTest("Constructor - Should set Name, Creator and GameSettings")]
        public void Constructor_ShouldSetNameCreatorAndGameSettings()
        {
            //Arrange
            var name = Guid.NewGuid().ToString();
            var creator = new UserBuilder().WithId().Build();
            var settings = new GameSettings();

            //Act 
            var room = new WaitingRoom(name, creator, settings);

            //Assert
            Assert.That(room.Name, Is.EqualTo(name), () => "The name of the room is not set correctly.");
            Assert.That(room.Users, Is.Not.Null, () => "The room should have one user (the creator).");
            Assert.That(room.Users, Has.Count.EqualTo(1), () => "The room should have one user (the creator).");
            Assert.That(room.CreatorUserId, Is.EqualTo(creator.Id), () => "The 'CreatorUserId' of the room is not set correctly.");
            Assert.That(room.GameSettings, Is.SameAs(settings), () => "The 'GameSettings' property of the room is not set correctly.");
        }
    }
}