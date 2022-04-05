import os
import binascii
import time
import threading
import numpy as np
# import logging
import concurrent.futures


Contract_Addr = '0xDBd97d9d6e61dB19e3Dd0eAfcaF132507BEC1098'
P = 5
L = 20
E = int(input("Epoch length: ")) # 1->10 G-Chain blocks


# def register_data_on_Contract(char *contract_addr, char *DO_address, char *DO_pkey, int contractType, int data_num, int operation, double price, char* DC_addr, int DC_action):
def local_update(contract_addr, sender_addr, sender_prkey, lidx, state):

	# char buffer1[1000], nodejs_arg[1000];

	# Six fields of a naked transaction
	gas_price = int(2500000000)
	gasLimit = int(1000000)
	value = 0 # unit: wei

	# sprintf(data, '0xcc527740%064X%064X%064lX%024X%s%064X', data_num, operation, price_wei, 0, DC_addr, DC_action);
	data = '0xe3d13100%064x%064s' % (lidx, state)
	# print(data)
	# Get the digest (RLP_hash) of the nake transaction
	# sprintf(nodejs_arg, "%ld %ld %s %ld %s %s %s", gas_price, gasLimit, to, value, data, address, pkey);
	nodejs_arg = '%ld %ld %s %ld %s %s %s' % (gas_price, gasLimit, contract_addr, value, data, sender_addr, sender_prkey)
	# sprintf(buffer1, "node App/txSendDirectly.js %s", nodejs_arg);
	buffer1 = 'node txSendDirectly.js %s' % (nodejs_arg)
	# print(buffer1)

	ret = os.system(buffer1)
	return time.time()


## We use random 32-byte strings to simulate state hashes
state_hashes = []
for n in range(P*L):
	tmp = '%s' % binascii.b2a_hex(os.urandom(32))
	state_hashes.append(tmp[2:-1])


DATA = np.load('Servers_Witnesses_TestList.npz')
Servers = DATA['Server_Candidates']


tocs = []
tic = time.time()
futures=[]
with concurrent.futures.ThreadPoolExecutor() as executor:
	for l in range(L):
		for p in range(P):
			idx = l*P + p
			futures.append(executor.submit(local_update, Contract_Addr, Servers[idx][0], Servers[idx][1], l, state_hashes[idx]))
		if l < L-1:
			time.sleep(15*E/L) # 150 = one epoch time = 10 G-Chain block cycles

	tocs = [f.result() for f in futures]

tocs = np.array(tocs)
elapses = tocs - tic

for l in range(L):
	for p in range(P):
		idx = l*P + p
		elapses[idx] -= 15*E/L * l


print('Collected',len(elapses),'/',L*P)
print('mean:', np.mean(elapses))
print('std:', np.std(elapses))
print('min max:', elapses.min(), elapses.max())

