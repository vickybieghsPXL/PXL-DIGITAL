var constants = require('../constants');

var LoginPage = function() {

    this.toLoginPage = function(browser) {
        browser.get(constants.LOGIN_PAGE_URL);
    };

    this.getElementById = function(browser, id) {
        return browser.driver.findElement(by.id(id));
    };

    this.password = function(browser) {
        return this.getElementById(browser,'password');
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

    this.errorMessage = function(browser) {
        return this.getElementById(browser,'error-message');
    };

    this.title = function(browser) {
        return browser.driver.findElement(by.className('title'));
    };

    this.submit = function(browser) {
        return this.getElementById(browser,'login-button').click();
    };

    this.validate = function(browser) {
        expect(this.title(browser).getText()).toBe('Login');
    };

    this.login = function(browser, email, password) {
        this.toLoginPage(browser);
        this.setEmail(browser, email);
        this.setPassword(browser, password);
        return this.submit(browser);
    };

};
module.exports = new LoginPage();