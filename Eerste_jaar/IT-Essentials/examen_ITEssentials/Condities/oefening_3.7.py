examen1 = int(input("Hoeveel scoorde de student op 20: "))
examen2 = int(input("Hoeveel scoorde de student op 20: "))
examen3 = int(input("Hoeveel scoorde de student op 20: "))

gem = (examen1 + examen2 + examen3) / 60

if gem < 0.6:
    print("Onvoldoende")
elif gem < 0.7:
    print("Voldoende")
elif gem < 0.8:
    print("Onderscheiding")
elif gem < 0.9:
    print("Grote onderscheiding")
else:
    print("Gespiekt?")