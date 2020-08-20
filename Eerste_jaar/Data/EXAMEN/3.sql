UPDATE spectators 
SET spectator_name = 'Alaerts'
WHERE (spectator_name = UPPER('ALLAERT') or spectator_name = UPPER('ALAERTS')) and spectator_firstname <> upper('JADE');

