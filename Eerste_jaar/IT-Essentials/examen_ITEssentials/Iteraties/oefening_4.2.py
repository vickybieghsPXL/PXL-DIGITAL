getal = int(input("Geef een geheel getal: "))
for i in range(20):
    print("{:2} x {} = {:3}".format(i + 1, getal, (i + 1) * getal))