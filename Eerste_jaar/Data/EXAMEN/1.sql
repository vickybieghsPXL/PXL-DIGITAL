select a.actor_id, actor_name || ' ' ||actor_firstname as "ACTOR", p.theatre_performance, date_time
from actors a inner join performance_actors p
on a.actor_id = p.actor_id
inner join performance_dates d on p.theatre_performance = d.theatre_performance 
where a.actor_id = &nummer and p.season = '2017 - 2018';

select sport_id, TO_CHAR(starttime, 'HH12:MI' ) as "BEGIN", TO_CHAR(endtime, 'HH12:MI') as "EIND", INITCAP(TO_CHAR(endtime, 'DAY')) as "WEEKDAG" from activities 
where sport_id like '20/AF%'
order by sport_id;