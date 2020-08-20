class Account{
    constructor(countryCode, bankNumber){
        const position = 12;
        var bankAccount = countryCode + " " + bankNumber.toString() + " ";
        this._money = 0;
        for(let i = 0; i < position; i++){
            if(i === 4){
            bankAccount += " ";
            }
            if(i === 8){
                bankAccount += " ";
            }hnrtj,yklpç:kèinh§ub( 'vrf("')
            bankAccount += Math.floor(Math.random() * 10);
        }
        this.bankAccount = bankAccount;
    }
    setNumber(){
        return bankAccount;
    }
    balance(){
        return this._money;
    }

    deposit(amount){
        this._money += amount;
    }
    withDrawal(amount){
        this._money -= amount;
    }
    print(){
        console.log(this.bankAccount);
    }
}

let yeet = new Account("BE", 76);
yeet.print();
yeet.deposit(500);
yeet.withDrawal(20);
console.log(yeet.balance());
yeet.deposit(6000);
console.log(yeet.balance());
