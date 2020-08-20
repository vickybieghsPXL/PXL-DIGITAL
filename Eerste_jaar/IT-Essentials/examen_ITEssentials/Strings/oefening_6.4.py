woord1 = input("Geef woord 1: ")
woord1 += "****"
woord2 = "++++"
woord2 += input("Geef woord 2:")


print(woord1[0:4].upper() + woord2[-1:-5:-1].lower())