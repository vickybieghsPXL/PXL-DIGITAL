var TestConstants = function() {
    this.HOST = 'http://localhost:63342/mastermind-frontend';
    this.LOGIN_PAGE_URL = this.HOST + 'login.html';
    this.REGISTRATION_PAGE_URL = this.HOST + '/registration.html';
    this.LOBBY_PAGE_URL = this.HOST + '/waitingRooms.html';

    this.NICKNAME = 'victor';
    this.EMAIL = 'victor@student.pxl.be';
    this.PASSWORD = 'Test123!';
};

module.exports = new TestConstants();