#!/usr/bin/python
from datetime import datetime
from paste import httpserver
import bottle, sys
import json, requests, re
import time, threading
from collections import OrderedDict

#this is the web application. It hosts a Web server on which the map app runs
from bottle import route, run, template, post, static_file, request, response
#import requests, json
from pymongo import MongoClient

client = MongoClient()
db = client.raw_data



class EnableCors(object):
    name = 'enable_cors'
    api = 2

    def apply(self, fn, context):
        def _enable_cors(*args, **kwargs):
            # set CORS headers
            response.headers['Access-Control-Allow-Origin'] = '*'
            response.headers['Access-Control-Allow-Methods'] = 'GET, POST, PUT, OPTIONS'
            response.headers['Access-Control-Allow-Headers'] = 'Origin, Accept, Content-Type, X-Requested-With, X-CSRF-Token'

            if bottle.request.method != 'OPTIONS':
                # actual request; reply with the actual response
                return fn(*args, **kwargs)

        return _enable_cors


@route('/css/bootstrap.css')
def bootstrap():
	return static_file("bootstrap.css", root="./css")

@route('/css/lists.css')
def bootstrap():
	return static_file("lists.css", root="./css")

@route('/css/iThing.css')
def bootstrap():
	return static_file("iThing.css", root="./css")

@route('/css/logo.png')
def bootstrap():
	return static_file("logo.png", root="./css")

@route('/css/districts.jpg')
def bootstrap():
	return static_file("districts.jpg", root="./css")

@route('/lib/bootstrap.js')
def js():
	return static_file("bootstrap.js", root="./lib")

@route('/lib/slider.js')
def js():
	return static_file("slider.js", root="./lib")

@route('/lib/tablesorter.js')
def js():
	return static_file("tablesorter.js", root="./lib")

@route('/lib/staticHistogramData.js')
def js():
	return static_file("staticHistogramData.js", root="./lib")

@route('/lib/bootbox.js')
def js():
	return static_file("bootbox.js", root="./lib")

@route('/pictures/bar_chart.jpg')
def foo():
	return static_file("bar_chart.jpg", root="./pictures")

@route('/pictures/area_chart.png')
def foo():
	return static_file("area_chart.png", root="./pictures")

@route('/pictures/scatter.PNG')
def foo():
	return static_file("scatter.PNG", root="./pictures")

@route('/pictures/example_histogram.PNG')
def foo():
	return static_file("example_histogram.PNG", root="./pictures")


#this function makes the data that will be passed to the template
def make_list(query, max_size):
	l = []
	cursor = db.raw_data.find(query)
	if max_size != None:
		for document in cursor[0:max_size]:
			l.append({ 'lattitude': document['latitude'], 'longitude': document['longitude'], 'crime': document['crime'], 'weapon': document['weapon'], 'date': document['date'], 'time': document['time'], 'district': document['district'], 'neighborhood': document['neighborhood'] })
	else:
		for document in cursor:
				l.append({ 'lattitude': document['latitude'], 'longitude': document['longitude'], 'crime': document['crime'], 'weapon': document['weapon'], 'date': document['date'], 'time': document['time'], 'district': document['district'], 'neighborhood': document['neighborhood'] })
	return l

view_dict = {'map': 'display:block', 'chart': 'display:none', 'table':'display:none'}

@route('/')
def hello():
	#pull data for testing
	l = make_list(None, 5000)
	with open("histogramdata", "r") as input:
		histogram = [(i[0], i[1]) for i in map(lambda a: a.strip().split(' '), input.readlines())]
	#histogram = build_histogram(None, 10000)
	f = list((l, view_dict, histogram))
	return template('index', bottleData = f)

crimes_list=['AGG. ASSAULT', 'ARSON', 'ASSAULT BY THREAT', 'AUTO THEFT', 'BURGLARY', 'COMMON ASSAULT', 'HOMICIDE', 'LARCENY', 'LARCENY FROM AUTO', 'RAPE', 'ROBBERY - CARJACKING', 'ROBBERY - COMMERCIAL', 'ROBBERY - RESIDENCE', 'ROBBERY - STREET', 'SHOOTING']
neighborhood_list=[ 'Abell', 'Allendale', 'Arcadia', 'Arlington', 'Armistead Gardens', 'Ashburton', 'Baltimore Highlands', 'Barclay', 'Barre Circle', 'Bayview', 'Beechfield', 'Belair-Edison', 'Belair-Parkside', 'Bellona-Gittings', 'Belvedere', 'Berea', 'Better Waverly', 'Beverly Hills', 'Biddle Street', 'Blythewood', 'Bolton Hill', 'Boyd-Booth', 'Brewers Hill', 'Bridgeview/Greenlawn', 'Broadway East', 'Broening Manor', 'Brooklyn', 'Burleith-Leighton', "Butcher's Hill", 'CARE', 'Callaway-Garrison', 'Cameron Village', 'Canton', 'Canton Industrial Area', 'Carroll - Camden Industrial Area', 'Carroll Park', 'Carroll-South Hilton', 'Carrollton Ridge', 'Cedarcroft', 'Cedmont', 'Cedonia', 'Central Forest Park', 'Central Park Heights', 'Charles North', 'Charles Village', 'Cherry Hill', 'Cheswolde', 'Chinquapin Park', 'Clifton Park', 'Coldspring', 'Coldstream Homestead Montebello', 'Concerned Citizens Of Forest Park', 'Coppin Heights/Ash-Co-East', 'Cross Country', 'Cross Keys', 'Curtis Bay', 'Curtis Bay Industrial Area', 'Cylburn', 'Darley Park', 'Dickeyville', 'Dolfield', 'Dorchester', 'Downtown', 'Downtown West', 'Druid Heights', 'Druid Hill Park', 'Dunbar-Broadway', 'Dundalk Marine Terminal', 'East Arlington', 'East Baltimore Midway', 'Easterwood', 'Eastwood', 'Edgewood', 'Edmondson Village', 'Ednor Gardens-Lakeside', 'Ellwood Park/Monument', 'Evergreen', 'Evergreen Lawn', 'Evesham Park', 'Fairfield Area', 'Fairmont', 'Fallstaff', 'Federal Hill', 'Fells Point', 'Forest Park', 'Forest Park Golf Course', 'Four By Four', 'Frankford', 'Franklin Square', 'Franklintown', 'Franklintown Road', 'Garwyn Oaks', 'Gay Street', 'Glen', 'Glen Oaks', 'Glenham-Belhar', 'Graceland Park', 'Greektown', 'Greenmount Cemetery', 'Greenmount West', 'Greenspring', 'Grove Park', 'Guilford', 'Gwynns Falls', 'Gwynns Falls/Leakin Park', 'Hamilton Hills', 'Hampden', 'Hanlon-Longwood', 'Harlem Park', 'Harwood', 'Hawkins Point', 'Heritage Crossing', 'Herring Run Park', 'Highlandtown', 'Hillen', 'Hoes Heights', 'Holabird Industrial Park', 'Hollins Market', 'Homeland', 'Hopkins Bayview', 'Howard Park', 'Hunting Ridge', 'Idlewood', 'Inner Harbor', 'Irvington', 'Johns Hopkins Homewood', 'Johnston Square', 'Jones Falls Area', 'Jonestown', 'Kenilworth Park', 'Kernewood', 'Keswick', 'Kresson', 'Lake Evesham', 'Lake Walker', 'Lakeland', 'Langston Hughes', 'Lauraville', 'Levindale', 'Liberty Square', 'Little Italy', 'Loch Raven', 'Locust Point', 'Locust Point Industrial Area', 'Lower Edmondson Village', 'Lower Herring Run Park', 'Loyola/Notre Dame', 'Lucille Park', 'Madison Park', 'Madison-Eastend', 'Mayfield', 'McElderry Park', 'Medfield', 'Medford', 'Mid-Govans', 'Mid-Town Belvedere', 'Middle Branch/Reedbird Parks', 'Middle East', 'Midtown-Edmondson', 'Millhill', 'Milton-Montford', 'Mondawmin', 'Montebello', 'Moravia-Walther', 'Morgan Park', 'Morgan State University', 'Morrell Park', 'Mosher', 'Mount Holly', 'Mount Vernon', 'Mount Washington', 'Mount Winans', 'Mt Pleasant Park', 'New Northwood', 'New Southwest/Mount Clare', 'North Harford Road', 'North Roland Park/Poplar Hill', 'Northwest Community Action', "O'Donnell Heights", 'Oakenshawe', 'Oaklee', 'Old Goucher', 'Oldtown', 'Oliver', 'Orangeville', 'Orangeville Industrial Area', 'Orchard Ridge', 'Original Northwood', 'Otterbein', 'Overlea', 'Panway/Braddish Avenue', 'Park Circle', 'Parklane', 'Parkside', 'Parkview/Woodbrook', 'Patterson Park', 'Patterson Park Neighborhood', 'Patterson Place', 'Pen Lucy', 'Penn North', 'Penn-Fallsway', 'Penrose/Fayette Street Outreach', 'Perkins Homes', 'Perring Loch', 'Pimlico Good Neighbors', 'Pleasant View Gardens', 'Poppleton', 'Port Covington', 'Pulaski Industrial Area', 'Purnell', 'Radnor-Winston', 'Ramblewood', 'Reisterstown Station', 'Remington', 'Reservoir Hill', 'Richnor Springs', "Ridgely's Delight", 'Riverside', 'Rognel Heights', 'Roland Park', 'Rosebank', 'Rosemont', 'Rosemont East', 'Rosemont Homeowners/Tenants', 'Sabina-Mattfeldt', 'Saint Agnes', 'Saint Helena', 'Saint Josephs', 'Saint Paul', 'Sandtown-Winchester', 'Seton Business Park', 'Seton Hill', 'Sharp-Leadenhall', 'Shipley Hill', 'South Baltimore', 'South Clifton Park', 'Spring Garden Industrial Area', 'Stadium Area', 'Stonewood-Pentwood-Winston', 'Taylor Heights', 'Ten Hills', 'The Orchards', 'Towanda-Grantley', 'Tremont', 'Tuscany-Canterbury', 'Union Square', 'University Of Maryland', 'Uplands', 'Upper Fells Point', 'Upton', 'Villages Of Homeland', 'Violetville', 'Wakefield', 'Walbrook', 'Waltherson', 'Washington Hill', 'Washington Village/Pigtown', 'Waverly', 'West Arlington', 'West Forest Park', 'West Hills', 'Westfield', 'Westgate', 'Westport', 'Wilhelm Park', 'Wilson Park', 'Winchester', 'Windsor Hills', 'Winston-Govans', 'Woodberry', 'Woodbourne Heights', 'Woodbourne-McCabe', 'Woodmere', 'Wrenlane', 'Wyman Park', 'Wyndhurst', 'Yale Heights', 'York-Homeland']

weapons_list = ['FIREARM', 'HANDS', 'KNIFE', 'OTHER', '']
district_list = ['CENTRAL', 'NORTHERN', 'SOUTHERN', 'WESTERN', 'EASTERN', 'NORTHEASTERN', 'SOUTHEASTERN', 'NORTHWESTERN', 'SOUTHWESTERN']

month_list = ['January', 'February', 'March', 'April', 'May', 'June', 'July', 'August', 'September', 'October', 'November', 'December']
day_list = ['Monday', 'Tuesday', 'Wednesday', 'Thursday', 'Friday', 'Saturday', 'Sunday']

@route('/ajax', method='POST')
def disp():
	print "in ajax call method in bottle"
	#x = request.forms.get('field_name')
	values_list = []
	inner_query = {}
	inner_querytwo = {}
	inner_querythree = {}
	inner_queryfour = {}
	inner_queryfive = {}
	inner_querysix = {}

	paramDateMin = datetime.fromtimestamp(int(request.forms.get('min'))/1000.0)
	paramDateMax = datetime.fromtimestamp(int(request.forms.get('max'))/1000.0)
	print "paramDateMin = " + str(paramDateMin)[0:10] + " paramDateMax = " + str(paramDateMax)[0:10]

	y = request.forms.get('crime_all')
	if y != None:
		inner_query['$in'] = crimes_list
	else:
		for i in crimes_list:
			y = request.forms.get(i)
			if y != None:
				values_list.append(i)
		inner_query['$in'] = values_list

	y = request.forms.get('neighborhood_all')
	if y != None:
		inner_querytwo['$in'] = neighborhood_list
	else:
		values_list = []
		for i in neighborhood_list:
			y = request.forms.get(i)
			if y != None:
				values_list.append(i)
		inner_querytwo['$in'] = values_list

	y = request.forms.get('weapon_all')
	z = request.forms.get('weapon_none')
	if y != None:
		inner_querythree['$in'] = weapons_list
	elif z != None:
		inner_querythree['$in'] = [None]
	else:
		values_list = []
		for i in weapons_list:
			y = request.forms.get(i)
			if y != None:
				values_list.append(i)
		inner_querythree['$in'] = values_list

	y = request.forms.get('district_all')
	if y != None:
		inner_queryfour['$in'] = district_list
	else:
		values_list = []
		for i in district_list:
			y = request.forms.get(i)
			if y != None:
				values_list.append(i)
		inner_queryfour['$in'] = values_list

	y = request.forms.get('month_all')
	if y != None:
		inner_queryfive['$in'] = [x for x in range(1, 13)]#month_list
	else:
		values_list = []
		for i in range(0, 12):#month_list:
			y = request.forms.get(month_list[i])
			if y != None:
				values_list.append(i + 1)
		inner_queryfive['$in'] = values_list

	y = request.forms.get('day_all')
	if y != None:
		inner_querysix['$in'] = [x for x in range(0, 7)]#day_list
	else:
		values_list = []
		for i in range(0, 7):#day_list:
			y = request.forms.get(day_list[i])
			if y != None:
				values_list.append(i)
		inner_querysix['$in'] = values_list

	print type(datetime.fromtimestamp(int(request.forms.get('min'))/1000.0))

	#this is what a valid query looks like in mongo:
	#db.raw_data.find({$and: [{'crime': {$in: ['AUTO THEFT']}}, {'year': {$gte: 2010}}, {'year': {$lte: 2016}}]})

	crime_query = {'crime': inner_query}
	neighborhood_query = {'neighborhood': inner_querytwo}
	weapons_query = {'weapon' : inner_querythree}
	district_query = {'district' : inner_queryfour}
	month_query = {'month' : inner_queryfive}
	day_query = {'weekday' : inner_querysix}

	gte_y = {'year': {'$gte' : paramDateMin.year} }
	lte_y = {'year': {'$lte' : paramDateMax.year} }

	#need an if statement -- >if weapon field is set to ignore the weapon, don't append weapons_query.
	x = list(( gte_y, lte_y, crime_query, neighborhood_query, district_query, month_query, day_query))

	y = request.forms.get('weapon_ignore')
	print y
	if y != '1':
		x.append(weapons_query)
	#if(inner_querythree['$in'] != []):
	#	x.append(weapons_query)

	query = {'$and' :  x}

	print query

	l = make_list(query, None)
	print len(l)

	#filter by date
	finalList = [item for item in l if \
	datetime(int(item['date'][0:4]),int(item['date'][5:7]),int(item['date'][8:10])) >= paramDateMin \
	and datetime(int(item['date'][0:4]),int(item['date'][5:7]),int(item['date'][8:10])) <= paramDateMax ]

	show = request.get_cookie('view');
	response.content_type = 'application/json'
	for (key, value) in view_dict.iteritems():
		view_dict[key] = 'display:none'
	view_dict[show] = 'display:block'
	data = list((finalList, view_dict))

	if l == []:
		print "empty list"

	print "done with ajax call\n"
	return json.dumps(data)


application = bottle.default_app()
application.install(EnableCors())

try:
	httpserver.serve(application, host='0.0.0.0',  port=80, use_threadpool=True, threadpool_workers=100)
except KeyboardInterrupt:
	httpserver.stop()
client.close()
