lengte = int(input("Geef een lengte: "))
hoogte = int(input("Geef een hoogte: "))
teken = input("Geef een teken: ")

# for hoogte_ in range(hoogte):
#     for lengte_ in range(lengte):
#         print(teken, end=" ")
#     print()

for i in range(hoogte):
    if i == 0 or i == (hoogte - 1):
        for j in range(lengte):
            print("*   ", end="")
    else:
        print("*   ", end="")
        for k in range(lengte - 2):
            print("    ", end="")
        print("*   ", end="")
    print()

