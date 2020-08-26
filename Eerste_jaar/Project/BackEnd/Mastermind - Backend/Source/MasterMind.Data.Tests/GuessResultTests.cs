using System;
using Guts.Client.Core;
using Guts.Client.Shared;
using MasterMind.Data.DomainClasses;
using NUnit.Framework;

namespace MasterMind.Data.Tests
{
    [ProjectComponentTestFixture("1TINProject", "MasterMind", "GuessResult", @"MasterMind.Data\DomainClasses\GuessResult.cs")]
    public class GuessResultTests
    {
        [MonitoredTest("Constructor - Should initialize a GuessResult object"), Order(1)]
        public void Constructor_ShouldInitializeAGuessResultObject()
        {
            //Arrange
            string[] colors = {
                Guid.NewGuid().ToString(),
                Guid.NewGuid().ToString(),
                Guid.NewGuid().ToString(),
                Guid.NewGuid().ToString()
            };

            //Act 
            var guessResult = new GuessResult(colors);

            //Assert
            Assert.That(guessResult.Colors, Is.SameAs(colors), () => "The 'Colors' property is not set correctly.");
            Assert.That(guessResult.CorrectColorAndPositionAmount, Is.EqualTo(0),
                () => "After construction the 'CorrectColorAndPositionAmount' should be zero.");
            Assert.That(guessResult.CorrectColorAmount, Is.EqualTo(0),
                () => "After construction the 'CorrectColorAmount' should be zero.");
        }

        [MonitoredTest("Verify (without duplicate colors)")]
        [TestCase("red,blue", "red,blue", 2, 0)]
        [TestCase("red,blue", "blue,red", 0, 2)]
        [TestCase("red,blue", "green,yellow", 0, 0)]
        [TestCase("red,blue,green", "green,blue,yellow", 1, 1)]
        public void Verify_ForCodeWithoutDuplicateColors(string codeToGuess, string guessedCode,
            int expectedCorrectColorAndPositionAmount, int expectedCorrectColorAmount)
        {
            //Arrange
            var guessResult = new GuessResult(guessedCode.Split(','));

            //Act
            guessResult.Verify(codeToGuess.Split(','));

            //Assert
            Assert.That(guessResult.CorrectColorAndPositionAmount, Is.EqualTo(expectedCorrectColorAndPositionAmount),
                () => "Invalid 'CorrectColorAndPositionAmount'");
            Assert.That(guessResult.CorrectColorAmount, Is.EqualTo(expectedCorrectColorAmount),
                () => "Invalid 'CorrectColorAmount'");
        }

        [MonitoredTest("Verify (with duplicate colors)")]
        [TestCase("red,red", "red,green", 1, 0)]
        [TestCase("red,red,blue,blue", "red,red,red,blue", 3, 0)]
        [TestCase("blue,blue,red,red", "red,red,red,yellow", 1, 1)]
        [TestCase("blue,red,red,red", "red,yellow,red,blue", 1, 2)]
        public void Verify_ForCodeWithDuplicateColors(string codeToGuess, string guessedCode,
            int expectedCorrectColorAndPositionAmount, int expectedCorrectColorAmount)
        {
            //Arrange
            var guessResult = new GuessResult(guessedCode.Split(','));

            //Act
            guessResult.Verify(codeToGuess.Split(','));

            //Assert
            Assert.That(guessResult.CorrectColorAndPositionAmount, Is.EqualTo(expectedCorrectColorAndPositionAmount),
                () => "Invalid 'CorrectColorAndPositionAmount'");
            Assert.That(guessResult.CorrectColorAmount, Is.EqualTo(expectedCorrectColorAmount),
                () => "Invalid 'CorrectColorAmount'");
        }
    }
}