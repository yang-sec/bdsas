import os
import time
import threading
import numpy as np
import concurrent.futures

Contract_Addr = '0xcec6fd8cde51b7bbd92bdf82314508e1f53081d2'
Regulator_Addr = '0x0a4a2f95e8625eb07a67f8dfa0cd566c515a01c3'
Regulator_Prkey = '6307a6a04aa0e59aa308d64073ddbe28c81914a1e96353d7c89aa6c88cb611a4'

P = 5 # default servers of an L-Chain
L = 28 # default number of L-Chains



# def register_data_on_Contract(contract_addr, DO_address, DO_pkey, contractType, data_num, operation, price, DC_addr, DC_action):
def register_server(contract_addr, sender_addr, sender_prkey, server_addr, de, li, st, seq):

	# Fields of a naked transaction
	gas_price = int(2500000000)
	gasLimit = int(300000)
	value = 0 # unit: wei

	# data = '0x34d12fb4\n%024x%s\n%064x\n%064x\n%064x\n%064x\n%064x\n%s' % (0, server_addr.lstrip('0x'), 0xa0, li, st, seq, len(de), de.encode('ascii').hex())
	data = '0x34d12fb4%024x%s%064x%064x%064x%064x%064x%s' % (0, server_addr.lstrip('0x'), 0xa0, li, st, seq, len(de), de.encode('ascii').hex())
	for i in range(64-2*len(de)):
		data += '0'
	# print(data)
	# Get the digest (RLP_hash) of the nake transaction
	# sprintf(nodejs_arg, "%ld %ld %s %ld %s %s %s", gas_price, gasLimit, to, value, data, address, pkey);
	nodejs_arg = '%ld %ld %s %ld %s %s %s' % (gas_price, gasLimit, contract_addr, value, data, sender_addr, sender_prkey)
	# sprintf(buffer1, "node App/txSendDirectly.js %s", nodejs_arg);
	buffer1 = 'node txSendDirectly.js %s' % (nodejs_arg)

	ret = os.system(buffer1)
	return time.time()


# register_server('0xcec6fd8cde51b7bbd92bdf82314508e1f53081d2','0x0a4a2f95e8625eb07a67f8dfa0cd566c515a01c3','6307a6a04aa0e59aa308d64073ddbe28c81914a1e96353d7c89aa6c88cb611a4','0xa059f4d3f829a08416014d2dcd66e94d86b17e2a','SAS Server 001',0,2,0)


# Open DOs
DATA = np.load('Servers_Witnesses_TestList.npz')
Servers = DATA['Server_Candidates']

# tocs = []
# tic = time.time()
# futures=[]
# with concurrent.futures.ThreadPoolExecutor() as executor:
# 	for l in range(L):
# 		for p in range(P):
# 			idx = l*P + p
# 			futures.append(executor.submit(register_server, Contract_Addr, Regulator_Addr, Regulator_Prkey, Servers[idx][0], 'SAS Server '+str(idx),l,2,p))
# 		if l < L-1:
# 			time.sleep(15*E/L) # 150 = one epoch time = 10 G-Chain block cycles

# 	tocs = [f.result() for f in futures]

idx = 0
for l in range(L):
	if l <= 4:
		continue
	for p in range(P):
		print('l: '+str(l)+', p: '+str(p))
		idx = l*P + p
		register_server(Contract_Addr, Regulator_Addr, Regulator_Prkey, Servers[idx][0], 'SAS Server '+str(idx),l,2,p)
		time.sleep(5)

# tocs = np.array(tocs)
# elapses = tocs - tic

# for l in range(L):
# 	for p in range(P):
# 		idx = l*P + p
# 		elapses[idx] -= 15*E/L * l


# # toc = time.time()
# # print(tocs-tic)
# print('Collected',len(elapses),'/',L*P)
# print('mean:', np.mean(elapses))
# print('std:', np.std(elapses))
# print('min max:', elapses.min(), elapses.max())

