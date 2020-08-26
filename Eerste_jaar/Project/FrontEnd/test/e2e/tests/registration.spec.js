var registrationPage = require('../page-objects/registration.page');
var loginPage = require('../page-objects/login.page');
var constants = require('../constants');

describe('Registration:', function() {
    describe('When clicking on the register button', function() {
        browser.ignoreSynchronization = true;

        it('should show an error message when no nickname given', function() {
            registrationPage.toRegistrationPage(browser);
            registrationPage.setEmail(browser, 'victor@student.pxl.be');
            registrationPage.setPassword(browser, 'Test123!');
            registrationPage.submit(browser).then(() => {
                browser.driver.sleep(1000);
                registrationPage.validate(browser);
            });
        });

        it('should show an error message when no email given', function() {
            registrationPage.toRegistrationPage(browser);
            registrationPage.setNickname(browser,'victor');
            registrationPage.setPassword(browser, 'Test123!');
            registrationPage.submit(browser).then(() => {
                browser.driver.sleep(1000);
                registrationPage.validate(browser);
            });
        });

        it('should show an error message when no password given', function() {
            registrationPage.toRegistrationPage(browser);
            registrationPage.setNickname(browser, 'victor');
            registrationPage.setEmail(browser,'victor@student.pxl.be');
            registrationPage.submit(browser).then(() => {
                browser.driver.sleep(1000);
                registrationPage.validate(browser);
            });
        });

        it('should show an error messsage when the email does not contain pxl.be', function() {
            registrationPage.toRegistrationPage(browser);
            registrationPage.setNickname(browser, 'victor');
            registrationPage.setEmail(browser, 'victor@gmail.com');
            registrationPage.setPassword(browser, 'Test123!');
            registrationPage.submit(browser).then(() => {
                browser.driver.sleep(1000);
                registrationPage.validate(browser);
                expect(registrationPage.errorMessage(browser).isDisplayed()).toBeTruthy()
            });
        });

        it('should show an error message when the password has no symbol', function() {
            registrationPage.toRegistrationPage(browser);
            registrationPage.setNickname(browser, 'victor');
            registrationPage.setEmail(browser,'victor@student.pxl.be');
            registrationPage.setPassword(browser,'Test123');
            registrationPage.submit(browser).then(() => {
                browser.driver.sleep(1000);
                registrationPage.validate(browser);
                expect(registrationPage.errorMessage(browser).isDisplayed()).toBeTruthy();
            });
        });

        it('should show an error message when the password has no number', function() {
            registrationPage.toRegistrationPage(browser);
            registrationPage.setNickname(browser, 'victor');
            registrationPage.setEmail(browser, 'victor@student.pxl.be');
            registrationPage.setPassword(browser, 'VictorTest!');
            registrationPage.submit(browser).then(() => {
                browser.driver.sleep(1000);
                registrationPage.validate(browser);
                expect(registrationPage.errorMessage(browser).isDisplayed()).toBeTruthy();
            });
        });

        it('should show an error message when the password has no lower case character', function() {
            registrationPage.toRegistrationPage(browser);
            registrationPage.setNickname(browser,'victor');
            registrationPage.setEmail(browser, 'victor@student.pxl.be');
            registrationPage.setPassword(browser, 'VICTORTEST123!');
            registrationPage.submit(browser).then(() => {
                browser.driver.sleep(1000);
                registrationPage.validate(browser);
                expect(registrationPage.errorMessage(browser).isDisplayed()).toBeTruthy();
            });
        });

        it('should show an error message when the password has no upper case character', function() {
            registrationPage.toRegistrationPage(browser);
            registrationPage.setNickname(browser,'victor');
            registrationPage.setEmail(browser,'victor@student.pxl.be');
            registrationPage.setPassword(browser,'victortest123!');
            registrationPage.submit(browser).then(() => {
                browser.driver.sleep(1000);
                registrationPage.validate(browser);
                expect(registrationPage.errorMessage(browser).isDisplayed()).toBeTruthy();
            });
        });

        it('should show an error message when the password has less than 6 characters', function() {
            registrationPage.toRegistrationPage(browser);
            registrationPage.setNickname(browser,'victor');
            registrationPage.setEmail(browser,'victor@student.pxl.be');
            registrationPage.setPassword(browser,'Vt12!');
            registrationPage.submit(browser).then(() => {
                browser.driver.sleep(1000);
                registrationPage.validate(browser);
                expect(registrationPage.errorMessage(browser).isDisplayed()).toBeTruthy();
            });
        });

        it('should display login page if tests was successfull', function() {
            registrationPage.toRegistrationPage(browser);
            registrationPage.setNickname(browser,'dirk');
            registrationPage.setEmail(browser,'dirk@student.pxl.be');
            registrationPage.setPassword(browser,'Test123!');
            registrationPage.submit(browser).then(function() {
                browser.driver.sleep(1000);
                loginPage.validate(browser);
            });
        });


       /* it('should show an error message when duplicate nickname', function() {
            registrationPage.toRegistrationPage(browser);
            registrationPage.setNickname(browser,'niels');
            registrationPage.setEmail(browser,'niels@student.pxl.be');
            registrationPage.setPassword(browser,'Test123!');
            registrationPage.submit(browser);
            browser.driver.sleep(1000);
            registrationPage.toRegistrationPage(browser);
            registrationPage.setNickname(browser,'niels');
            registrationPage.setEmail(browser,'nick@student.pxl.be');
            registrationPage.setPassword(browser,'Test123!');
            registrationPage.submit(browser).then(() => {
                browser.driver.sleep(1000);
                registrationPage.validate(browser);
                expect(registrationPage.errorMessage(browser).isDisplayed()).toBeTruthy();
            });
        }); */

        it('should show an error message when duplicate email', function() {
            registrationPage.toRegistrationPage(browser);
            registrationPage.setNickname(browser,'amber');
            registrationPage.setEmail(browser,'amber@student.pxl.be');
            registrationPage.setPassword(browser,'Test123!');
            registrationPage.submit(browser);
            browser.driver.sleep(1000);
            registrationPage.toRegistrationPage(browser);
            registrationPage.setNickname(browser,'anne');
            registrationPage.setEmail(browser,'amber@student.pxl.be');
            registrationPage.setPassword(browser,'Test123!');
            registrationPage.submit(browser).then(() => {
                browser.driver.sleep(1000);
                registrationPage.validate(browser);
                expect(registrationPage.errorMessage(browser).isDisplayed()).toBeTruthy();
            });
        });
    });
});