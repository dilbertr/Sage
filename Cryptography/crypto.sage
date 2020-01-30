def all_primitive_roots(n):
	roots=[]
	g=primitive_root(n)
	for i in range(n):
		if gcd(i,n-1)==1:
			roots.append(g^i%n)
	roots.sort()
	return roots
def dlog(g,h,n):
	#uses baby step giant step algorithm
	G=Integers(n)
	BabySteps={}
	for i in range(floor(sqrt(n))):
		BabySteps[G(g^i)]=i
	for i in range(n):
		if G(h*g^(-i*floor(sqrt(n)))) in BabySteps.keys():
			value=G(h*g^(-i*floor(sqrt(n))))
			return G((BabySteps[value]+i*floor(sqrt(n))))
#RSA
def rsa_private_key_known(p,q,e):
	G=Integers((p-1)*(q-1))
	return G(e^(-1))
def rsa_private_key_break(n,e):
	p=factor(n)[0][0]
	q=factor(n)[1][0]
	return rsa_private_key_known(p,q,e)
def rsa_public_key(p,q,e):
	return [p*q,e]
def rsa_encrypt(n,e,m):
	return m^e%n
def rsa_decrypt(n,d,c):
	G=Integers(n)
	return G(c)^G(d)
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
	return int(val)
def decode(n):
	s=str(n)
	if len(s)%3==2:
		s="0"+s
	if len(s)%3==1:
		s="00"+s
	list=[s[i:i+3] for i in range(0, len(s), 3)]
	val=""
	for i in list:
		val=val+chr(int(i))
	return val
def encrypt_file(messagepath):
	m=open(messagepath)
	m.read





