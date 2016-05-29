#!/usr/bin/python

from pymongo import MongoClient

def lt(l, r):
	a = map(lambda x: int(x), l.split(' ')[0].split('-'))
	b = map(lambda x: int(x), r.split(' ')[0].split('-'))
	
	if a[0] < b[0]:
		return 1
	if a[0] > b[0]:
		return 0
	
	if a[1] < b[1]:
		return 1
	if a[1] > b[1]:
		return 0

	if a[2] < b[2]:
		return 1

	return 0

#http://interactivepython.org/runestone/static/pythonds/SortSearch/TheMergeSort.html
def mergeSort(alist):
	if len(alist)>1:
		mid = len(alist)//2
		lefthalf = alist[:mid]
		righthalf = alist[mid:]

 		mergeSort(lefthalf)
		mergeSort(righthalf)

		i=0
		j=0
		k=0
		while i < len(lefthalf) and j < len(righthalf):
			if lt(lefthalf[i],  righthalf[j]) == 0:
				alist[k]=lefthalf[i]
				i=i+1
			else:
				alist[k]=righthalf[j]
				j=j+1
			k=k+1

		while i < len(lefthalf):
			alist[k]=lefthalf[i]
			i=i+1
			k=k+1

		while j < len(righthalf):
			alist[k]=righthalf[j]
			j=j+1
			k=k+1


client = MongoClient()
db = client.raw_data

dates = db.raw_data.distinct('date')


l = []
query = {}
inner_query = {}
for x in dates:
	inner_query['$in'] = [x]
	query['date'] = inner_query
	y = len([z for z in db.raw_data.find(query)])
	l.append( list( (x, y) ))


l = map((lambda a: a.strip()), l)

mergeSort(l)
with open("histogramdata", 'w') as output:
	output.write('\n'.join(l) )

client.close()

