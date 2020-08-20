brutoloon = float(input("Geef je brutoloon: "))
vakantiegeld = brutoloon * 0.05

if vakantiegeld >= 350:
    jaarlijkse_bijdrage = 350 * 0.08
else:
    jaarlijkse_bijdrage = vakantiegeld * 0.08

print(brutoloon)
print(vakantiegeld)
print(jaarlijkse_bijdrage)