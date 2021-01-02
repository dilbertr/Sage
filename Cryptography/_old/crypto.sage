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
def rsa_private_key_break(key):
	p=factor(key[0])[0][0]
	q=factor(key[0])[1][0]
	return rsa_private_key_known(p,q,key[1])
def rsa_public_key(p,q,e):
	return [p*q,e]
def rsa_encrypt(key,m):
	return m^key[1]%key[0]
def rsa_decrypt(public,private,c):
	G=Integers(public[0])
	return G(c)^G(private)
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
def encrypt_file(source,destination,key):
	m=open(source,"r")
	c=open(destination,"w")
	block=''
	encrypted_block=''
	blocklength=len(hex(key[0]))
	written_block=""
	while true:
		block=""
		block = m.read(8)
		if block=="":
			break
		encrypted_block=""
		encrypted_block=hex(rsa_encrypt(key,encode(block)))
		written_block="\n"
		written_block=written_block+encrypted_block
		print(written_block)
		c.write(written_block)
	c.close()
	m.close()
def decrypt_file(source,destination,public,private):
	c=open(source,"r")
	m=open(destination,"w")
	block=''
	blocklength=len(hex(public[0]))
	decrypted_block=""
	done=False
	while true:
		block=""
		while true:
			char=c.read(1)
			if char=="\n":
				break
			if char=="":
				done=True
				break
			block = block + char
		if block != "":
			decrypted_block=decode(rsa_decrypt(public,private,int(block,0)))
			print("Block:")
			print(block)
			m.write(decrypted_block)
		if done==True:
			break
	m.close()
	c.close()






