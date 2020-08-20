naam = input("Geef de naam: ")
while naam != "xx" and naam != "XX":
    percentage = int(input("Hoeveel percent heeft de student gehaald? "))
    while percentage < 0 or percentage > 100:
        percentage = int(input("Hoeveel percent heeft de student gehaald? "))
    if percentage < 60:
        print("Onvoldoende")
    elif percentage < 70:
        print("Voldoende")
    elif percentage < 80:
        print("Onderscheiding")
    elif percentage < 85:
        print("Grote onderscheiding")
    else:
        print("Grootste onderscheiding")
    naam = input("Geef de naam: ")
