#1
(Select distinct A.aname, C.eid 
from Aircraft A, Certified C, Employees E 
where E.eid = C.eid and A.aid = C.aid and E.salary > 80000) 
Except 
(Select A.aname, C.eid 
from Aircraft A, Certified C, Employees E 
where E.eid = C.eid and A.aid = C.aid and E.salary <= 80000);

#2
Select E1.eid, max(A.cruisingrange) 
from Aircraft A, Certified C1, Employees E1 
where E1.eid = C1.eid and C1.aid = A.aid and 
E1.eid in (Select distinct E2.eid from Certified C2, Employees E2 where E2.eid = C2.eid group by E2.eid having count(C2.aid) > 3) 
group by E1.eid;

#3
Select distinct E.ename 
from Employees E 
where E.salary < (Select min(F.price) from Flights F where F.from_ = 'Los Angeles' and F.to_ = 'Honolulu' group by F.from_);

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

#10
SELECT DISTINCT E.ename
  FROM Employees as E, Certified as C, Aircraft as A
  WHERE E.eid = C.eid and
        C.aid = A.aid and
        A.cruisingrange > 1000;
			       
#11
SELECT DISTINCT E.ename
  FROM Employees as E, Certified as C, Aircraft as A
  WHERE E.eid = C.eid and
        C.aid = A.aid and
        A.cruisingrange > 1000 and
        C.eid in
        (SELECT COUNT(C.eid)
          FROM Aircraft as A, Certified as C
          WHERE A.cruisingrange > 1000
          GROUP BY C.eid
          HAVING COUNT(C.eid) > 1
         );
			       
#12
SELECT DISTINCT E.ename
  FROM Employees as E, Certified as C, Aircraft as A
  WHERE E.eid = C.eid AND
        C.aid = A.aid AND
        A.cruisingrange > 1000 AND
        A.aname = 'Boeing';

			       
			  
