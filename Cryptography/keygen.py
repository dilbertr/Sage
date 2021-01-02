import crypto
import math
import random

p=crypto.next_prime((math.floor(random.random()*(2**256)))*2**256+math.floor(random.random()*(2**256)))
q=crypto.next_prime((math.floor(random.random()*(2**256)))*2**256+math.floor(random.random()*(2**256)))
public=open("public.key","w")
private=open("private.key","w")
public.write(str(p*q)+",65537")
private.write(str(crypto.rsa_private_key_known(p,q,65537)))
public.close()
private.close()