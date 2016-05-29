# software_engineering
this project was created by stuart woodbury, ryan brandt, michael kelbaum, and christopher paul during the spring 2016 semester
of software engineering for umbc.

To properly run this application the following commands must be run:

sudo apt-get install git
#install mongo
#    (instructions below)
                 http://docs.mongodb.org/manual/tutorial/install-mongodb-on-ubuntu
sudo apt-get install python-setuptools
sudo easy_install pip
sudo pip install paste
sudo pip install requests
sudo pip install pymongo
sudo mkdir /data
sudo mkdir /data/db
sudo mongod (in one terminal)

sudo ./updater.py
sudo ./driver.py
#then go to localhost in browser


	Here is the mapping of list indexes to relevant data:
		Index:			Info:
		--------------------------------------
		8			date
		9			time
		12			crime
		13			weapon
		15			district
		16			neighborhood
		17			another list: index 1 = lattitude, index 2 = longitude


List of Technologies Used:
	Python 2.7
	Bottle
	Mongodb
	Pymongo
	Google Maps API
	Jquery
