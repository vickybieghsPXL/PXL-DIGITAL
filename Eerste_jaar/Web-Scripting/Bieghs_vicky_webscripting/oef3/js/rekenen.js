// naam: Bieghs vicky

// hint: if( ! /^\d+$/.test(ingave) )


window.addEventListener("load", handleLoad);

function handleLoad () {
	let button_start_rekenen = document.getElementById("button_start_rekenen");
	button_start_rekenen.addEventListener("click",handleClick );
}


function handleClick () {
	let input = document.getElementById("input_aantal").value;
	if(! /^\d+$/.test(input)){
		let error = document.createElement("p");
		error.innerText = "misse ingave voor aantal";
		document.getElementById("vermenigvuldigingen").append(error);
	}
	let solutionList = [];
	for(let i = 0; i < input; i++){
		let hr = document.createElement("hr");
		document.getElementById("vermenigvuldigingen").append(hr);
		let div = document.createElement("div");
		let number1 = Math.floor(Math.random() * 10);
		let number2 = Math.floor(Math.random() * 10);
		div.innerText = number1 + " * " + number2 + " = ";
		let input = document.createElement("input");
		input.type="text";
		div.appendChild(input);
		hr.append(div);
		handleKeyupInput(input);
		solutionList.push(number1 * number2);
	}
	
}

function handleKeyupInput(event){

}

