


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


#7
select distinct(E.ename)
from employees as E, certified as C, aircraft as A
where E.eid = C.eid and C.aid = A.aid and
	A.aid in (select aid from aircraft where cruisingrange > 3000 and not aname = 'Boeing');

#8
select ABS(AVG(P.salary) - AVG(E.salary))
from employees as P, employees as E, certified as C
where P.eid = C.eid ;

#9
select distinct(E.ename), E.salary
from employees as E, certified as C
where not E.eid = C.eid and E.salary > (select AVG(salary) from employees as P, certified as C where P.eid = C.eid );

