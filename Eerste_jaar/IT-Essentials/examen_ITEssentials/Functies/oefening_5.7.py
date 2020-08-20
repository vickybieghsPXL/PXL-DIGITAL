def bereken_boete(aantal_boeken, aantal_dagen):
    return aantal_boeken * aantal_dagen * 0.07


aantal_brieven = 0

naam = input("Geef de naam van de bibgebruiker: ")
while naam != "xx":
    aantal_boeken = int(input("Hoeveel aantal boeken: "))
    aantal_dagen = int(input("Hoeveel dagen is de gebruiker al te laat: "))
    boete = bereken_boete(aantal_dagen, aantal_boeken)
    if aantal_dagen >= 45:
        aantal_brieven +=1
        boete += 0.84
    print("Boete: {}".format(boete))
    naam = input("Geef de naam van de bibgebruiker: ")
print("De bib moet {} aantal brieven opstun.".format(aantal_brieven))