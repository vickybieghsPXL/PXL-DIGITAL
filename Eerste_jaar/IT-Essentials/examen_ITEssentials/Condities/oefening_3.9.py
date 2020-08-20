getal1 = int(input("Getal 1: "))
getal2 = int(input("Getal 2: "))
bewerkingscode = int(input("Geef de bewerkingscode: "))

if bewerkingscode == 1:
    print(getal1 + getal2)
elif bewerkingscode == 2:
    print(getal1 - getal2)
elif bewerkingscode == 3:
    print(getal1 * getal2)
elif bewerkingscode == 4:
    print(getal1 ** 2)
elif bewerkingscode == 5:
    print(getal2 ** 2)
else:
    print("Foutieve code")
