from math import pi

diameter_inches = float(input("Geef het aantal inches van de diameter van je wiel: "))

print("Diameter: {} inches".format(diameter_inches))
print("Afgelegde weg van een omwentelling {}".format(diameter_inches * pi))
print("Afgelegde weg in m per omwentelling {}".format(diameter_inches * pi * 0.025))