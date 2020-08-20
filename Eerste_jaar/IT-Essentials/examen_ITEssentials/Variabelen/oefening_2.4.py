def convert_to_fahrenheit(celcius):
    return (9 / 5) * celcius + 32

celcius = float(input("Geef het aantal graden celcius: "))
print(convert_to_fahrenheit(celcius))
