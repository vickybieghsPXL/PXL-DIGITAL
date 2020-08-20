SELECT v.vakantie_id, v.van, v.max_aantal_inschrijvingen, COUNT(ik.inschr_id) AANTAL, v.prijs * COUNT(ik.inschr_id) "totale prijs"
FROM inschrijvingen i JOIN vakanties v ON v.vakantie_id = i.vak_id
					JOIN inschrijvingen_kindgegevens ik ON i.inschrijving_id = ik.inschr_id
WHERE v.van > sysdate
GROUP BY v.vakantie_id, v.van, v.max_aantal_inschrijvingen, v.prijs
HAVING COUNT(ik.inschr_id) <> v.max_aantal_inschrijvingen;



--mijn oplossing
select V.VAKANTIE_ID, TO_CHAR(v.VAN, 'DD-MON-YY') VAN, MAX_AANTAL_INSCHRIJVINGEN, COUNT(ik.INSCHR_ID) AANTAL, PRIJS * COUNT(ik.INSCHR_ID) AS "totale prijs" from INSCHRIJVINGEN
join VAKANTIES V on V.VAKANTIE_ID = INSCHRIJVINGEN.VAK_ID join INSCHRIJVINGEN_KINDGEGEVENS IK on INSCHRIJVINGEN.INSCHRIJVING_ID = IK.INSCHR_ID
where v.van > sysdate
GROUP BY v.vakantie_id, v.van, v.max_aantal_inschrijvingen, v.prijs
HAVING COUNT(ik.inschr_id) <= v.max_aantal_inschrijvingen;
