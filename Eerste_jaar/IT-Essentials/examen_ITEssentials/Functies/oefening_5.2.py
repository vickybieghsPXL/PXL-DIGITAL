def is_schikkeljaar(jaar):
    if jaar % 4 == 0:
        if jaar % 400 == 0:
            return True
        elif jaar % 100 == 0:
            return False
        return True

jaar = int(input("Geef een jaartal: "))
print(is_schikkeljaar(jaar))