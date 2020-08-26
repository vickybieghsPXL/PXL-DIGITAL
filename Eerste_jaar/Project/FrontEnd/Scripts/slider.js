var slider = document.getElementById("slider1");
var output = document.getElementById("slider-value");
output.innerHTML = slider.value;


slider.oninput = function() {
    output.innerHTML = this.value;
}