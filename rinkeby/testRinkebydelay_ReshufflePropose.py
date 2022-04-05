import os
import binascii
import time
import threading
import numpy as np
import random
import string
import concurrent.futures


Contract_Addr = '0xDBd97d9d6e61dB19e3Dd0eAfcaF132507BEC1098'
NTH = int(input("Number Threads: "))


# def register_data_on_Contract(char *contract_addr, char *DO_address, char *DO_pkey, int contractType, int data_num, int operation, double price, char* DC_addr, int DC_action):
def reshuffle_proposal(contract_addr, sender_addr, sender_prkey, pubkey, h1, h2, h3, p1, p2, p3):

	# char buffer1[1000], nodejs_arg[1000];

	# Six fields of a naked transaction
	gas_price = int(2500000000)
	gasLimit = int(1000000)
	value = 0 # unit: wei

	# sprintf(data, '0xcc527740%064X%064X%064lX%024X%s%064X', data_num, operation, price_wei, 0, DC_addr, DC_action);
	data = '0x17b54798%064s%064s%064s%064s%064s%064s%064s' % (pubkey, h1, h2, h3, p1, p2, p3)
	# print(data)
	# Get the digest (RLP_hash) of the nake transaction
	# sprintf(nodejs_arg, "%ld %ld %s %ld %s %s %s", gas_price, gasLimit, to, value, data, address, pkey);
	nodejs_arg = '%ld %ld %s %ld %s %s %s' % (gas_price, gasLimit, contract_addr, value, data, sender_addr, sender_prkey)
	# sprintf(buffer1, "node App/txSendDirectly.js %s", nodejs_arg);
	buffer1 = 'node txSendDirectly.js %s' % (nodejs_arg)
	# print(buffer1)

	ret = os.system(buffer1)
	return time.time()

## We use random strings to simulate VRF hashes, proofsm and public keys
pk = []
h1 = []
h2 = []
h3 = []
p1 = []
p2 = []
p3 = []
for n in range(NTH):
	tmp = '%s' % binascii.b2a_hex(os.urandom(32))
	pk.append(tmp[2:-1])
	tmp = '%s' % binascii.b2a_hex(os.urandom(32))
	h1.append(tmp[2:-1])
	tmp = '%s' % binascii.b2a_hex(os.urandom(32))
	h2.append(tmp[2:-1])
	tmp = '%s' % binascii.b2a_hex(os.urandom(32))
	h3.append(tmp[2:-1])
	tmp = '%s' % binascii.b2a_hex(os.urandom(32))
	p1.append(tmp[2:-1])
	tmp = '%s' % binascii.b2a_hex(os.urandom(32))
	p2.append(tmp[2:-1])
	tmp = '%s' % binascii.b2a_hex(os.urandom(32))
	p3.append(tmp[2:-1])



DATA = np.load('Servers_Witnesses_TestList.npz')
Servers = DATA['Server_Candidates']

tocs=[]
tic = time.time()
with concurrent.futures.ThreadPoolExecutor() as executor:
	futures = [executor.submit(reshuffle_proposal, Contract_Addr, Servers[i][0], Servers[i][1], pk[i], h1[i], h2[i], h3[i], p1[i], p2[i], p3[i]) for i in range(NTH)]
	tocs = [f.result() for f in futures]

tocs = np.array(tocs)
elapses = tocs - tic

print('Collected',len(elapses),'/',NTH)
print('mean:', np.mean(elapses))
print('std:', np.std(elapses))
print('min max:', elapses.min(), elapses.max())
