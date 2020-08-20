n = int(input("Hoeveel chars wil je ingeven? "))
som = 0
for i in range(n):
    char = input("Geef een karakter: ")
    if char >= "A" and char <= "Z":
        print("Hoofdletter")
    elif char >= "a" and char <= "z":
        print("Kleine letter")
    elif char >= "0" and char <= "9":
        som += int(char)
        print("cijfer")
    else:
        print("Onbekend")