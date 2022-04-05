import os
import time
import threading
import numpy as np
import concurrent.futures

Contract_Addr = '0xDBd97d9d6e61dB19e3Dd0eAfcaF132507BEC1098'
Regulator_Addr = '0x0a4a2f95e8625eb07a67f8dfa0cd566c515a01c3'
Regulator_Prkey = '6307a6a04aa0e59aa308d64073ddbe28c81914a1e96353d7c89aa6c88cb611a4'

P = 5 # default witnesses of an L-Chain
L = 20 # default number of L-Chains



# def register_data_on_Contract(contract_addr, DO_address, DO_pkey, contractType, data_num, operation, price, DC_addr, DC_action):
def register_witness(contract_addr, sender_addr, sender_prkey, witness_addr, de, li, st, seq):

	# Fields of a naked transaction
	gas_price = int(2500000000)
	gasLimit = int(1000000)
	value = 0 # unit: wei

	# data = '0x34d12fb4\n%024x%s\n%064x\n%064x\n%064x\n%064x\n%064x\n%s' % (0, server_addr.lstrip('0x'), 0xa0, li, st, seq, len(de), de.encode('ascii').hex())
	data = '0x6c8ecf16%024x%s%064x%064x%064x%064x%064x%s' % (0, witness_addr[2:], 0xa0, li, st, seq, len(de), de.encode('ascii').hex())
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
Witnesses = DATA['Witnesses']

idx = 0
for l in range(L):
	for p in range(P):
		print('\nl: '+str(l)+', p: '+str(p))
		idx = l*P + p
		register_witness(Contract_Addr, Regulator_Addr, Regulator_Prkey, Witnesses[idx][0], 'Witness '+str(idx),l,1,p)