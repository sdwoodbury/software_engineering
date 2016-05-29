#!/usr/bin/python

import threading
import pymongo
from pymongo import MongoClient
import requests, json, re
from datetime import datetime
client = MongoClient()
db = client.raw_data

#functions for use in program
#returns [year,month,day] as ints
def date_stripper(input):
	stripped = re.findall(r'\d+-\d+-\d+', input)
	date_list = stripped[0].split('-')
	return map(int, date_list)

#returns [hour,minute,second] as ints
def time_stripper(input):
	stripped = input.split(':')
	return map(int, stripped)


def update():
	#update database and then sleep for a day

	print "running thread"
	r = requests.get('https://data.baltimorecity.gov/api/views/wsfq-mvij/rows.json?accessType=DOWNLOAD')
	data = r.json()['data']
	for item in data:
		date = date_stripper(item[8])
		time = time_stripper(item[9])
		day = datetime(date[0], date[1], date[2]).weekday()
		if len(time) != 3:
			time = [None]*3
		try:
			db.raw_data.insert({'_id': item[0],'year': date[0], 'month': date[1], 'weekday': day, 'hour': time[0], 'crime': item[12], 'weapon': item[13], 'date': item[8][0:10], 'time': item[9], 'district': item[15],'neighborhood': item[16], 'latitude': item[17][1],'longitude': item[17][2]})
				#print "inserted item"
		except IndexError as  e:
			print "data item skipped"
		except pymongo.errors.DuplicateKeyError as e:
			print "duplicate key not inserted"
	print "done with thread"
update()
#t = threading.Timer(3600 * 24, update)
#t.start()
