class Account {
    constructor(landcode, banknummer, code, saldo){
        this.landcode = landcode;
        this.banknummer = banknummer;
        this.code = code;
        this.saldo = saldo;
    }

    print(){
        let controle = parseInt(this.code) % 97;
        let rekening = this.landcode + this.banknummer + this.code + controle;
        return rekening;
    }

    stortGeld(bedrag){
        this.saldo += bedrag;
        console.log(this.print() + "\n" + "Er is €" + bedrag + " bij op de rekening gezet. \n" + "€" + this.saldo);
    }

    verwijderGeld(bedrag){
        this.saldo -= bedrag;

        if (this.saldo < 0){
            console.log("Je bankrekening staat negatief! " + this.saldo + "euro.");
        } else {
            console.log(this.print() + "\n" + "Er is €" + bedrag + " afgehaald \n" + "€" + this.saldo);
        }
    }
}

let account1 = new Account('BE', '76', '0012587909', 500);

console.log(account1.print());

account1.stortGeld(1000);

account1.verwijderGeld(500);