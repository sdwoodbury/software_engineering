#!/usr/bin/python

import os
i = os.fork()

if(i != 0):
	with open("tokill", "w") as out:
		out.write(str(i))
else:
	os.execvp("./driver.py", [''])
