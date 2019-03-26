import pandas as pd
TITLE_TSV_COLUMNS = ['tconst','titleType', 'primaryTitle', 'isAdult', 'releaseYear', 'endYear','runtimeMinutes','genres']
PRIMARY_KEY_COLUMNS = ['titleType', 'primaryTitle']
TITLE_COLUMN_NAME = ['titleType', 'primaryTitle', 'releaseYear' ,'isAdult'] #correct
TITLE_GENRES = ['titleType', 'primaryTitle','genres'] # correct 
TITLE_RATINGS = PRIMARY_KEY_COLUMNS + ['averageRating','numVotes'] #correct 
MOVIE_COLUMN_NAME = ['titleType', 'primaryTitle', 'runtimeMinutes'] #correct 
VIDEOGAME_COLUMN_NAME = ['titleType', 'primaryTitle' ,'runtimeMinutes'] # correct 
TV_EPISODE_COLUMN_NAME = ['titleType', 'primaryTitle', 'runtimeMinutes'] # correct
TV_SERIES_COLUMN_NAME = ['titleType', 'primaryTitle', 'endYear','runtimeMinutes'] # correct

file = open('sql/populate_all.sql','w') 
file.close()
data = pd.read_csv('title.basics.tsv',sep='\t')
data = data.sample(10000)
temp = data[['tconst','titleType', 'primaryTitle', 'isAdult', 'startYear', 'endYear','runtimeMinutes','genres']]
temp.dropna(inplace=True)
temp = temp.drop_duplicates(subset=PRIMARY_KEY_COLUMNS)
temp.columns = TITLE_TSV_COLUMNS
#create a duplicate title.basic with just 10000 shuffled entries
temp.to_csv('master_titles.tsv',sep='\t',index=False)
master = temp
#drop the duplciates
temp = temp.drop_duplicates(subset=PRIMARY_KEY_COLUMNS)
# generate the title table
temp = temp[['tconst']+ TITLE_COLUMN_NAME]
temp = temp.drop_duplicates(subset=PRIMARY_KEY_COLUMNS)
generateSqlAndTsvFile(temp,TITLE_COLUMN_NAME, 'title' )

# generate ratings table
#data = pd.read_csv('title_ketan.tsv',sep='\t') # master data only
temp = master
temp = temp[['tconst']+PRIMARY_KEY_COLUMNS]
temp = temp.drop_duplicates(subset=PRIMARY_KEY_COLUMNS)

ratings = pd.read_csv('title.ratings.tsv',sep='\t')
temp = temp.merge(ratings,how = 'inner', on='tconst')
generateSqlAndTsvFile(temp,TITLE_RATINGS, 'titleRatings')

#genres 
temp = master
temp = temp[['tconst']+TITLE_GENRES]
temp = temp.drop_duplicates(subset=PRIMARY_KEY_COLUMNS)

temp = pd.DataFrame(temp.genres.str.split(',').tolist(), index=[temp.tconst,temp.titleType,temp.primaryTitle]).stack()
temp = temp.reset_index()[['tconst','titleType','primaryTitle',0]]
temp.columns = [['tconst','titleType','primaryTitle','genres']]
temp = temp.drop_duplicates(subset=PRIMARY_KEY_COLUMNS+['genres'])
generateSqlAndTsvFile(temp,TITLE_GENRES, 'titleGenres')

temp = master
temp = temp[temp.titleType.isin(['tvEpisode'])]
temp = temp[['tconst'] + TV_EPISODE_COLUMN_NAME ]
temp = temp.drop_duplicates(subset=PRIMARY_KEY_COLUMNS)
#TV_EPISODE_COLUMN_NAME = ['titleType', 'primaryTitle','releaseYear', 'runtimeMinutes'] # correct
temp = temp.drop_duplicates(subset=TV_EPISODE_COLUMN_NAME)

generateSqlAndTsvFile(temp,TV_EPISODE_COLUMN_NAME, 'tvEpisode')

temp = master
temp = temp[temp.titleType.isin(['videoGame'])]
temp = temp[['tconst'] + VIDEOGAME_COLUMN_NAME]
temp = temp.drop_duplicates(subset=PRIMARY_KEY_COLUMNS)
#TV_EPISODE_COLUMN_NAME = ['titleType', 'primaryTitle','releaseYear', 'runtimeMinutes'] # correct
temp = temp.drop_duplicates(subset=VIDEOGAME_COLUMN_NAME)

generateSqlAndTsvFile(temp,VIDEOGAME_COLUMN_NAME, 'videoGame' )

temp = master
temp = temp[~temp.titleType.isin(['tvEpisode','videoGame','tvSeries','tvMiniSeries','video' ])]
temp = temp[['tconst'] + MOVIE_COLUMN_NAME]
temp = temp.drop_duplicates(subset=PRIMARY_KEY_COLUMNS)
#TV_EPISODE_COLUMN_NAME = ['titleType', 'primaryTitle','releaseYear', 'runtimeMinutes'] # correct
temp = temp.drop_duplicates(subset=MOVIE_COLUMN_NAME)
generateSqlAndTsvFile(temp,MOVIE_COLUMN_NAME, 'movie' )

temp = master
temp = temp[temp.titleType.isin(['tvSeries','tvMiniSeries'])]
temp = temp[['tconst'] + TV_SERIES_COLUMN_NAME]
temp = temp.drop_duplicates(subset=PRIMARY_KEY_COLUMNS)
temp = temp.drop_duplicates(subset=TV_SERIES_COLUMN_NAME)
generateSqlAndTsvFile(temp,TV_SERIES_COLUMN_NAME, 'tvseries' )

tconst = master[['tconst']]
person = pd.read_csv('title.principals.tsv',sep='\t')
PERSON_PRIMAY_KEY = ['primaryName','birthYear']
p = person[['tconst','nconst']]
x = tconst.merge(p,how = 'inner', on = 'tconst')
data1 = x.merge(person, how='inner', on = ['tconst','nconst'])
data1.drop(['ordering'],axis = 1, inplace=True)
names = pd.read_csv('name.basics.tsv',sep='\t')
names.drop(['primaryProfession','knownForTitles'],inplace = True, axis = 1)
names = names.drop_duplicates(subset = PERSON_PRIMAY_KEY)
t = data1.merge(names, how = 'inner', on = 'nconst') 
t.to_csv('principle_cast.tsv',sep='\t')

person = t 
PERSON_COLUMN_NAME = ['primaryName','birthYear','deathYear']
person = person[['tconst','nconst']+PERSON_COLUMN_NAME]
person = person.drop_duplicates(subset=PERSON_PRIMAY_KEY)
generateSqlAndTsvFile(person,PERSON_COLUMN_NAME, 'person')
#fine

temp = t
temp = temp[~temp.category.isin(['actor','director','writer','self','actress'])]
MISC_COLUMN_NAME = PERSON_PRIMAY_KEY + ['category'] 
temp = temp[['tconst','nconst'] + MISC_COLUMN_NAME  + ['job']]
temp = temp.drop_duplicates(subset=MISC_COLUMN_NAME)
generateSqlAndTsvFile(temp,MISC_COLUMN_NAME,'credit')


temp = t
temp = temp[temp.category.isin(['actor','self','actress'])]
ACTOR_COLUMN_NAME = PERSON_PRIMAY_KEY + ['category'] 
temp = temp[['tconst','nconst'] + ACTOR_COLUMN_NAME  + ['characters']]
temp = temp.drop_duplicates(subset=ACTOR_COLUMN_NAME)
generateSqlAndTsvFile(temp,ACTOR_COLUMN_NAME,'actor')


temp = t
temp = temp[temp.category.isin(['director'])]
DIRECTOR_COLUMN_NAME = PERSON_PRIMAY_KEY + ['job']
temp = temp[['tconst','nconst'] + DIRECTOR_COLUMN_NAME] 
temp = temp.drop_duplicates(subset=DIRECTOR_COLUMN_NAME)
generateSqlAndTsvFile(temp,DIRECTOR_COLUMN_NAME,'director')


temp = t
temp = temp[temp.category.isin(['writer'])]
WRITER_COLUMN_NAME = PERSON_PRIMAY_KEY + ['category']
temp = temp[['tconst','nconst'] + WRITER_COLUMN_NAME +['job']]
temp = temp.drop_duplicates(subset=WRITER_COLUMN_NAME)
generateSqlAndTsvFile(temp,WRITER_COLUMN_NAME,'writer')


title = pd.read_csv('csv/title_ketan.tsv', sep= '\t')
writer = pd.read_csv('csv/writer_ketan.tsv',sep= '\t')
title_writer = title.merge(writer, how='inner', on= 'tconst')
TITLE_WRITER_COLUMN_NAMES = ['titleType', 'primaryTitle','primaryName', 'birthYear','job']
title_writer = title_writer [TITLE_WRITER_COLUMN_NAMES]
title_writer = title_writer.drop_duplicates(subset=TITLE_WRITER_COLUMN_NAMES)
generateSqlAndTsvFile(title_writer, TITLE_WRITER_COLUMN_NAMES, 'WritesFor')

director = pd.read_csv('csv/director_ketan.tsv',sep= '\t')
title_director = title.merge(director, how='inner', on= 'tconst')
TITLE_DIRECTOR_COLUMN_NAMES = ['titleType', 'primaryTitle', 'primaryName', 'birthYear', 'job']
title_director = title_director [TITLE_DIRECTOR_COLUMN_NAMES]
title_director = title_director.drop_duplicates(subset=TITLE_DIRECTOR_COLUMN_NAMES)
generateSqlAndTsvFile(title_director, TITLE_DIRECTOR_COLUMN_NAMES, 'title_director')

title_credit = pd.read_csv('csv/credit_ketan.tsv',sep= '\t')
title_credit = title.merge(title_credit, how='inner', on= 'tconst')
TITLE_CREDIT_COLUMN_NAMES = ['titleType', 'primaryTitle', 'primaryName', 'birthYear', 'category', 'job']
title_credit = title_credit [TITLE_CREDIT_COLUMN_NAMES]
title_credit = title_credit.drop_duplicates(subset=TITLE_CREDIT_COLUMN_NAMES)
generateSqlAndTsvFile(title_credit, TITLE_CREDIT_COLUMN_NAMES, 'title_credit')

actor = pd.read_csv('csv/actor_ketan.tsv',sep= '\t')
title_actor = title.merge(actor, how='inner', on= 'tconst')
TITLE_ACTOR_COLUMN_NAMES = ['titleType', 'primaryTitle', 'primaryName', 'birthYear', 'category','characters']
title_actor = title_actor [TITLE_ACTOR_COLUMN_NAMES]
title_actor = title_actor.drop_duplicates(subset=TITLE_ACTOR_COLUMN_NAMES)
generateSqlAndTsvFile(title_actor, TITLE_ACTOR_COLUMN_NAMES, 'title_actor')


tvepisode = pd.read_csv('csv/tvEpisode_ketan.tsv',sep='\t')

#tvepisode = tvepisode[['tconst'] + PRIMARY_KEY_COLUMNS]

tvseries = pd.read_csv('csv/tvseries_ketan.tsv',sep='\t')

#tvseries = tvseries[['tconst'] + PRIMARY_KEY_COLUMNS]

e = pd.read_csv('title.episode.tsv',sep='\t')

tve = tvepisode.merge(e , how = 'inner', on = 'tconst')

tvee = tve.merge(tvseries, left_on='parentTconst', right_on='tconst', how='inner')
tvee.drop(['tconst_x','tconst_y','parentTconst'],axis = 1, inplace = True)

tvee.columns = ['episodeTitleType', 'episodePrimaryTitle', 'episodeReleaseYear',
       'seasonNumber', 'episodeNumber', 'seriesTitleType', 'seriesPrimaryTitle',
       'endYear','releaseYear']

generateSqlAndTsvFile(tvee,['episodeTitleType', 'episodePrimaryTitle', 'episodeReleaseYear',
       'seasonNumber', 'episodeNumber', 'seriesTitleType', 'seriesPrimaryTitle',
       'endYear','releaseYear'],'belongs')