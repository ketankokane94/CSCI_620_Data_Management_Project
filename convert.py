import pandas as pd 

data = pd.read_csv('title.basics.tsv',sep='\t')
temp = data[['tconst','genres']]
frame = pd.DataFrame(temp.genres.str.split(',').tolist(), index=temp.tconst).stack()
frame = frame.reset_index()[['tconst',0]]
frame.columns = ['tconst','genres']

frame.to_csv('title_genres.tsv', sep='\t')
