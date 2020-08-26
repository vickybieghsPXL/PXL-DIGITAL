var constants = require('../constants.js');
var WaitingRoomPage = function() {

    this.get = function() {
        browser.get(constants.WAITING_ROOM_PAGE);
    };

    this.getElementById = function(browser, id) {
        return browser.driver.findElement(by.id(id));
    };

    this.numberOfPlayers = function(browser) {
        return this.getElementById(browser,'user-amount');
    };

    this.players = function() {
        return this.getElementById('room-users');
    };

    this.room = function() {
        return this.getElementById('room-id');
    };

    this.errorMessage = function() {
        return this.getElementById('error-message');
    };

    this.title = function() {
        return browser.driver.findElement(by.className('title'));
    };

    this.startGame = function(browser) {
        return this.startButton(browser).click();
    };

    this.startButton = function(browser) {
        return browser.driver.findElement(by.id('start-button'));
    };

    this.validate = function() {
        expect(this.title().getText()).toContain('Waiting room');
    };
};
module.exports = new WaitingRoomPage();