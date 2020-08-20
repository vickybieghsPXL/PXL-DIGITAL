temp = float(input("Geef de temperatuur: "))
som = 0
hoogste = temp
for i in range(9):
    som += temp
    if temp > hoogste:
        hoogste = temp
    temp = float(input("Geef de temperatuur: "))
print("Hoogste: {} ; Gemiddelde: {}".format(hoogste, som / 10))