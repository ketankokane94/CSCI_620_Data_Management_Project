SELECT M.titlename, 
       G.genre 
FROM   movie M, 
       titlegenres G 
WHERE  M.titlename = G.titlename 
       AND G.genre LIKE 'Comedy'; 

SELECT B.s_titlename, 
       Sum(R.numvotes) 
FROM   belongs B, 
       titleratings R, 
       tvepisode E 
WHERE  B.e_titlename = E.titlename 
       AND E.titlename = R.titlename 
GROUP  BY B.s_titlename; 

SELECT A.alternate_title 
FROM   titlealternatename A, 
       title T 
WHERE  T.titlename = A.titlename 
       AND A.region = 'India'; 

SELECT R.titlename, 
       D.personname, 
       R.averageratings 
FROM   titleratings R, 
       director D, 
       title_director TD 
WHERE  TD.titlename = R.titlename 
       AND D.personname = TD.personname 
       AND R.averageratings > ALL (SELECT TR.averageratings 
                                   FROM   titleratings TR, 
                                          director DR, 
                                          title_director TDR 
                                   WHERE  TR.titlename = TDR.titlename 
                                          AND DR.personname = TDR.personname 
                                          AND DR.personname = 'Aaron Kodz'); 
