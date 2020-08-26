var registrationPage = require('../../page-objects/registration.page');
var loginPage = require('../../page-objects/login.page');
var lobbyPage = require('../../page-objects/lobby.page');
var waitingRoomPage = require('../../page-objects/waiting-room.page');
var constants = require('../../constants');

describe('Scenario 1:', function () {
    it('should be possible for two players to register, login, create/join a game and start the game', function () {
        browser.ignoreSynchronization = true;
        var browser2 = browser.forkNewDriverInstance();
        browser2.ignoreSynchronization = true;

        registrationPage.registerPlayer(browser, constants.NICKNAME, constants.EMAIL, constants.PASSWORD).then(() => {
            browser.driver.sleep(1000);
        });
        loginPage.login(browser, constants.EMAIL, constants.PASSWORD).then(() => {
            browser.driver.sleep(1000);
        });
        lobbyPage.setNewRoomName(browser, 'MightyMasters');
        lobbyPage.createRoom(browser).then(() => {
            browser.driver.sleep(1000);
        });
        //expect(waitingRoomPage.startButton(browser).isDisplayed()).toBeFalsy();

        registrationPage.registerPlayer(browser2, 'amy', 'amy@student.pxl.be', 'Test1234!').then(() => {
            browser2.driver.sleep(1000);
        });

        loginPage.login(browser2, 'amy@student.pxl.be', 'Test1234!').then(() => {
                browser2.driver.sleep(5000);
                lobbyPage.joinFirstRoom(browser2);
                browser.driver.sleep(3000);
                browser2.driver.sleep(3000);
            }
        );

        expect(waitingRoomPage.numberOfPlayers(browser).getText()).toBe('2/4');
        expect(waitingRoomPage.startButton(browser).isDisplayed()).toBeTruthy();
        waitingRoomPage.startGame(browser).then(() => {
            browser.driver.sleep(1000);
            browser2.driver.sleep(1000);
        });
    });
});