#!/usr/bin/python

from pymongo import MongoClient


start = '''<div class="col-md-1" style="margin: 10px; padding: 10px; margin-right:50px;">
					<div class="dropdown">
						<button class="btn btn-sm btn-info dropdown-toggle" type="button" data-toggle="dropdown">'''

middle = '''				<span class="caret"></span></button>
						<ul class="dropdown-menu"> '''


end = '''						</ul>
					</div>
		</div>'''

hours = map(lambda x: str(x), [i for i in range(0, 24)])
with open("temp", "w") as out:
	x = start + "Hour" + middle
	for i in hours:
		x +=( '<li><input type="checkbox" name="%s" value=1 style="padding: 5px; margin: 5px;" id="%s"  onchange="uncheckAllButton(this)">%s</input></li>' % (i, i, i)) 
		x += "\n"
	x += end
	out.write(x)

'''

client = MongoClient()
db = client.raw_data

crimes = [str(x) for x in db.raw_data.distinct('crime')]
neighborhoods = [str(x) for x in db.raw_data.distinct('neighborhood')]
month = ['January', 'February', 'March', 'April', 'May', 'June', 'July', 'August', 'September', 'October', 'November', 'December']
weekday = ['Monday', 'Tuesday', 'Wednesday', 'Thursday', 'Friday', 'Saturday', 'Sunday']
client.close()

print neighborhoods #rint crimes, "\n",  "\n", month, "\n", weekday, "\n"

with open("othercrap.txt", "w") as out:
	pass

crimestr = start + "Crime Type" + middle
for item in neighborhoods:
	with open("othercrap.txt", "a") as out:
		out.write('$("#%s").click(function(){$("#crimeFilters").submit();});\n' %item.lower().replace(' ', '_') ) 

	crimestr +=( '<li><input type="checkbox" name="%s" value=1 style="padding: 5px; margin: 5px;" id="%s">%s</input></li>' % (item, item.lower().replace(' ', '_'), item))
	crimestr += "\n"
crimestr += end
with open("crap.txt","w") as out:
	pass#out.write(crimestr + "\n\n\n\n");

nbstr = start + "Neighborhood" + middle
for item in neighborhoods:
	nbstr +=( '<li><input type="checkbox" name="%s" value=1 style="padding: 5px; margin: 5px;" id="%s">%s</input></li>' % (item, item.lower().replace(' ', '_'), item))
	nbstr += "\n"
nbstr += end

monstr = start + "Month" + middle
for item in month:
	with open("othercrap.txt", "a") as out:
		out.write('$("#%s").click(function(){$("#crimeFilters").submit();});\n' %item.lower().replace(' ', '_') ) 
	monstr +=( '<li><input type="checkbox" name="%s" value=1 style="padding: 5px; margin: 5px;" id="%s">%s</input></li>' % (item, item.lower().replace(' ', '_'), item))
	monstr += "\n"
monstr += end
with open("crap.txt","a") as out:
	out.write(nbstr + "\n\n\n\n");

weekstr = start + "Day" + middle
for item in weekday:
	with open("othercrap.txt", "a") as out:
		pass#out.write('$("#%s").click(function(){$("#crimeFilters").submit();});\n' %item.lower().replace(' ', '_') ) 
	weekstr +=( '<li><input type="checkbox" name="%s" value=1 style="padding: 5px; margin: 5px;" id="%s">%s</input></li>' % (item, item.lower().replace(' ', '_'), item))
	weekstr += "\n"
weekstr += end
with open("crap.txt","a") as out:
	pass#out.write(weekstr + "\n\n\n\n");
'''
