var constants = require('../constants');

var RegistrationPage = function() {

    this.toRegistrationPage = function(browser) {
        browser.get(constants.REGISTRATION_PAGE_URL);
    };

    this.setNickname = function(browser, nickname) {
        this.nickname(browser).sendKeys(nickname);
    };

    this.getElementById = function(browser, id) {
        return browser.driver.findElement(by.id(id));
    };

    this.nickname = function(browser) {
        return this.getElementById(browser, 'nickname');
    };

    this.setPassword = function(browser, password) {
        this.password(browser).sendKeys(password);
    };

    this.email = function(browser) {
        return this.getElementById(browser,'email');
    };

    this.setEmail = function(browser, email) {
        this.email(browser).sendKeys(email);
    };

    this.password = function(browser) {
        return this.getElementById(browser,'password')
    };

    this.errorMessage = function(browser) {
        return this.getElementById(browser,'error-message');
    };

    this.title = function(browser) {
        return browser.driver.findElement(by.className('title'));
    };

    this.submit = function(browser) {
        return this.getElementById(browser, 'submit-button').click();
    };

    this.validate = function(browser) {
        expect(this.title(browser).getText()).toBe('Registration');
    };

    this.registerPlayer = function(browser, nickname, email, password) {
        this.toRegistrationPage(browser);
        this.setNickname(browser, nickname);
        this.setEmail(browser, email);
        this.setPassword(browser, password);
        return this.submit(browser);
    };
};
module.exports = new RegistrationPage();