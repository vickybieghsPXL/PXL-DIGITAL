def bereken_pi(aantal_reeksen):
    switch = 1
    tussen_haken = 0
    for i in range(1, aantal_reeksen * 2, 2):
        tussen_haken += switch * (1 / i)
        switch = -switch
    print(4 * tussen_haken)


bereken_pi(10000)