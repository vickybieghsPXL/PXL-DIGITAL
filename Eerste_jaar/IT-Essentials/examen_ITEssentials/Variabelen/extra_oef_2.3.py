from math import pi

diameter_inches = float(input("Geef het aantal inches van de diameter van je wiel: "))
aantal_m = float(input("Hoeveel m wil je afleggen: "))

omtrek = diameter_inches * pi
afgelegde_weg_in_m = omtrek * 0.0254

nodige_omwentelingen = aantal_m / afgelegde_weg_in_m

print("Nodige aantal omwentelling {}".format(nodige_omwentelingen))