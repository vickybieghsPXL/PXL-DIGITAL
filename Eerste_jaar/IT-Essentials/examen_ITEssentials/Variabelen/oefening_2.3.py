def bereken_bmi(lengte, gewicht):
    return gewicht / (lengte ** 2)


lengte = float(input("Geef je lengte in meters: "))
gewicht = float(input("Geef je gewicht in kg: "))

print(bereken_bmi(lengte, gewicht))
