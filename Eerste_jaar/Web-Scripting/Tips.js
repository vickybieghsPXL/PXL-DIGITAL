/* Inline if */
{
    let age = 19;
    let usertype = age < 18 ? 'minor' : 'adult';
    console.log(usertype);
}

/* functions */
{
    /* binding */
    const square = function (side) {
        return side * side;
    };
    // const : you cannot edit it, let: you can edit it
    console.log(square(2));

    /* verkorte versie */
    const rectangle = (x, y) => {return x * y;};

    // TIP : extra argumenten worden genegeerd
    // TIP : minder argumenten --> crasht NIET

    /* recursie */

    function power(base, exp){
        if(exp === 0){
            return 1;
        }
        return base * power(base, exp - 1);
    }

    console.log(power(2,2));
}

/* Arrays */
{
    let numbers = [1,2,3];
    let empty = [];

    /* loops */
    for (let item of numbers){
        console.log(item);
    }

    numbers.shift(); // verwijdert 1ste element
    numbers.unshift(1); // voegt iets te vooraan
    numbers.slice(1,3); // nummers van index 1 tot 3
    numbers.slice(1); //nummers van index 1 tot het einde
    numbers.concat(1); // iets toevoegen
    numbers.concat([1,2]); //meerdere dingen toevoegen

    /* spread / rest */

    function sum(... numbers){          // plaats parameters in de array number
        let sum = 0;
        for (let number of numbers){
            sum += number;
        }
        return sum;
    }

    sum(1,2,3,3,3,3,3);
    let nummers = [1,2,3,4];
    sum(... nummers); //pakt de array uit en zet deze als parameter
}

/* objecten */
{
    let person = {
        name: "hey",
        lastname: "test"
    };
    console.log(person.name);
    console.log(person); // stringify -> normal use JSON.parse
    console.log(JSON.stringify(person));

    /* object literals */
    person = {
        name: "Bugra",
        age: 19,
        print : function() {
            console.log(this.name + " | " + this.age);
        },
        print2(){
            console.log(this.name + " | " + this.age);
        }
    };
    person.print();
    person.print2();


    /* Maps (dictionaries) */
    let ages = new Map();
    ages.set("Bugra", 19); //Bugra is de key, 19 is de value
    console.log(ages.get("Bugra"));
    console.log(ages.has("Elyesa")); //false, deze key bestaat niet
}

/* classes */
{
    class human //extends idk
    {
        constructor(name){
            this._name = name;
        }
        get name(){return this._name;}
        set name(name){
            this._name = name;
        }
        speak(){
            console.log(`Hey mafa im ${this.name}`);
        }
    }
    let bugra = new human("bugra");
    bugra.speak();
    console.log(bugra.name);
    bugra.name = "test";
    console.log(bugra instanceof human); // true
}

/* DOM events */
{
    /*
    blur
    click
    copy
    cut
    focus
    keydown
    load
    mousedown
    mouseenter
    mouseleave
    mousemove
    mouseover
    mouseout
    mouseup
    submit

     */
}

/* Promises */
{
    function willGetNewPhone(){
        let isMomHappy = true;
        return new Promise(
            function (resolve, reject) {

                if (isMomHappy) {
                    let phone = {brand: "Apple", model: "XS MAX"};
                    resolve(phone);
                }
                else {
                    reject("Mom is not happy");
                }

            }
        );
    }


    willGetNewPhone()
        .then((result)=>{
            console.log(result);
        })
        .catch((error)=>{
            console.log(error.message);
        })
}

/* string x aantal keren uitprinten */
{
    console.log("#".repeat(1000000));
}

/* Fetch */
{
    /*
    GET = informatie halen
    POST = toevoegen
    POST = toevoegen of wijzigen
    DELETE = ... delete
     */

    /* GET */
    let url = "http://localhost:3000/"; // + resource
    fetch(url)

        // dit deel blijft meestal hetzelfde
        .then((response)=>{
            if(response.status === 200){
                return response.json();
            }
            else{
                throw `error with status ${response.status}`;
            }
        })

        .then((result)=>{
            console.log(result);
        })

        .catch((error)=>{
            console.log(error);
        });

    /* POST */
    let url2 = "http://localhost:3000/"; // + resource
    let object = {name: "bugra", age: 19};

    fetch(url2,
        {
            method: "POST",
            body: JSON.stringify(object), //het object dat je moet sturen
            headers:{
                'Accept':'application/json',
                'Content-Type':'application/json'
            }
        })

        .then((response)=>{
            if(response.status === 200){
                return response.json();
            }
            else{
                throw `error with status ${response.status}`;
            }
        })

        .then((result)=>{
            console.log(result);
        })

        .catch((error)=>{
            console.log(error);
        });
}
