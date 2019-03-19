import pandas as pd 

data = pd.read_csv('title.basics.tsv',sep='\t')

personKnownForTitles = data[['tconst','genres']]

frame = pd.concat([pd.Series(row['tconst'], row['genres'].split(','))              
                    for _, row in personKnownForTitles.iterrows()])

frame.to_csv('title_genres.tsv', sep='\t')
