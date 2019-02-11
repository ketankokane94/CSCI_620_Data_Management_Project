


#4
select a.aname as 'aircraft name',avg( e.salary) as ' average pilot salary' 
from aircraft a 
inner join certified c on c.aid = a.aid
inner join employees e on e.eid = c.eid
where a.cruisingrange > 1000
group by a.aname;

#5
select distinct e.ename
from employees e 
inner join certified c on c.eid = e.eid
inner join aircraft a on c.aid = a.aid and a.aname = 'Boeing';


#6
select  *
from aircraft a
inner join certified c on c.aid = a.aid
where a.cruisingrange >= (select distance from flights where from_ = 'Detroit' and to_ = 'Baliuag');

# changed the location from log angeles to Detroit and chicago to Baliuag




