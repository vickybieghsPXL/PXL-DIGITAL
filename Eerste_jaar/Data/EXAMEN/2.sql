select p.theatre_performance, count(a.actor_id) as "aantal acteurs"
from actors a inner join performance_actors p on a.actor_id = p.actor_id
where p.season = '2018 - 2019'
having count(a.actor_id) > (select count(a.actor_id)
                           from actors a inner join performance_actors p
                           on a.actor_id = p.actor_id
                           where p.theatre_performance = 'De IT-er' and p.season = '2017 - 2018')
group by p.theatre_performance
order by count(a.actor_id);

select sport_id,  NVL(max_participants, 'Volzet') as "Vrije plaatsen" from activities;

select firstname, lastname from members where national_id_payer = '&&national_id_payer';