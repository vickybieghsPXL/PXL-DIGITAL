from datetime import  datetime


basisprijs = 5
film_jonger_twee_jaar = 1
film_hoge_rating = 2
film_lage_rating = 1
max_prijs = 7

jaar = int(input("Van welk jaar is de film? "))
rating = int(input("Wat is de rating van deze film (1-5): "))
prijs = basisprijs
if datetime.now().year - jaar < 2:
    prijs += film_jonger_twee_jaar

if rating > 3:
    prijs += film_hoge_rating
elif rating > 1:
    prijs += film_lage_rating

if prijs > 7:
    prijs = 7

print(prijs)