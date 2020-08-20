def convert_to_USD(euro, koers):
    return euro * koers


euro = int(input("Geef in hoeveel euro je hebt: "))
koers = float(input("Wat is de huidige koers: "))
print("Je hebt {} USD".format(convert_to_USD(euro, koers)))
