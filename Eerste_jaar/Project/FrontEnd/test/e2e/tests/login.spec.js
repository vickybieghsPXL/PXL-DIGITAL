var loginPage = require('../page-objects/login.page');
var constants = require('../constants');

describe('Login:', function() {
    describe('When clicking on the login button', function () {
        browser.ignoreSynchronization = true;
        it('should show an error message when no email given', function () {
            loginPage.toLoginPage(browser);
            loginPage.setPassword(browser,'Test123!');
            loginPage.submit(browser).then(() => {
                browser.driver.sleep(1000);
                loginPage.validate(browser);
            });
        });

        it('should show an error message when no password given', function () {
            loginPage.toLoginPage(browser);
            loginPage.setEmail(browser, 'victor@student.pxl.be');
            loginPage.submit(browser).then(() => {
                browser.driver.sleep(1000);
                loginPage.validate(browser);
            });
        });
    });
});