Select M.TitleName, G.Genre from movie M, Titlegenres G where M.TitleName = G.TitleName and G.Genre like 'Comedy';

Select B.S_TitleName, sum(R.NumVotes) from belongs B, Titleratings R, tvepisode E where B.E_TitleName = E.TitleName and E.TitleName = R.TitleName group by B.S_TitleName;

Select A.alternate_title from titleAlternateName A, Title T where T.TitleName = A.TitleName and A.region = 'India';

Select R.TitleName, D.PersonName, R.AverageRatings from Titleratings R, director D, title_director TD where TD.TitleName = R.TitleName and D.PersonName = TD.PersonName and R.AverageRatings > all (Select TR.AverageRatings from Titleratings TR, director DR, title_director TDR where TR.TitleName = TDR.TitleName and DR.PersonName = TDR.PersonName and DR.PersonName = 'Aaron Kodz');