var constants = require('../constants.js');
var LobbyPage = function() {

    this.toLobbyPage = function(browser) {
        browser.get(constants.LOBBY_PAGE_URL);
    };

    this.getElementById = function(browser, id) {
        return browser.driver.findElement(by.id(id));
    };

    this.setNewRoomName = function(browser, name) {
        this.getElementById(browser,'name').sendKeys(name);
    };

    this.errorMessage = function(browser) {
        return this.getElementById(browser,'error-message');
    };

    this.createRoom = function(browser) {
        return browser.driver.findElement(by.id('create-button')).click();
    };

    this.joinFirstRoom = function(browser) {
        browser.driver.findElements(by.className('join-link')).then( function(elts) {
            elts[0].click();
        });
    };

    this.validate = function(browser) {
        browser.driver.findElements(by.className('title')).then(function(elts) {
            expect(elts[0].getText()).toContain('waiting room');
        });
    };
};
module.exports = new LobbyPage();