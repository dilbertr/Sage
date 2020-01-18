def encode(s):
	ls=[ord(c) for c in s]
	val=""
	for i in ls:
		if i<10:
			val=val+"00"+str(i)
		if i<100 and i>9:
			val=val+"0"+str(i)
		if i>99:
			val=val+str(i)