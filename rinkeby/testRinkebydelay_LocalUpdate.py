import os
import time
import threading
import numpy as np
# import logging
import concurrent.futures


# ContractAddress = '0x208D3CEdFE8918298A726264B578A9BA2AE8c85B' # DO's own contract
# DO_Address = '0xac5d434a4a9CF170BaaA5D1bE12B48c7fe358fa0'
# DO_PrivateKey = '3bdc966729b1c929efa2053c40c77f31cf2e9048950c8f86af937780e5686dbd'
DataConsumerAddress = '65843BE2Dd4ad3bC966584E2Fcbb38838d49054B'
price = 0.01;  # ethers
# NTH = 10
# L = 10
P = 5
L = 20
E = int(input("Epoch length: ")) # 1->10 G-Chain blocks

# Open DOs
DATA = np.load('DOs.npz')
Servers = DATA['Server_Candidates']


# def register_data_on_Contract(char *contract_addr, char *DO_address, char *DO_pkey, int contractType, int data_num, int operation, double price, char* DC_addr, int DC_action):
def register_data_on_Contract(contract_addr, DO_address, DO_pkey, contractType, data_num, operation, price, DC_addr, DC_action):

	# char buffer1[1000], nodejs_arg[1000];

	# Six fields of a naked transaction
	gas_price = int(2000000000)
	gasLimit = int(300000)
	# char to[100];
	value = 0 # unit: wei
	# char data[500];

	# char address[100], pkey[200];
	# sprintf(to, "%s", contract_addr);
	# sprintf(address, "%s", DO_address);
	# sprintf(pkey, "%s", DO_pkey);

	price_wei = int(price * 1000000000000000000)

	# sprintf(data, '0xcc527740%064X%064X%064lX%024X%s%064X', data_num, operation, price_wei, 0, DC_addr, DC_action);
	data = '0xcc527740%064X%064X%064lX%024X%s%064X' % (data_num, operation, price_wei, 0, DC_addr, DC_action)

	# Get the digest (RLP_hash) of the nake transaction
	# sprintf(nodejs_arg, "%ld %ld %s %ld %s %s %s", gas_price, gasLimit, to, value, data, address, pkey);
	nodejs_arg = '%ld %ld %s %ld %s %s %s' % (gas_price, gasLimit, contract_addr, value, data, DO_address, DO_pkey)
	# sprintf(buffer1, "node App/txSendDirectly.js %s", nodejs_arg);
	buffer1 = 'node txSendDirectly.js %s' % (nodejs_arg)
	# print(buffer1)

	ret = os.system(buffer1)
	# return ret
	return time.time()

data_counter = 0
OperationNum = 0


# threads = list()
# for i in range(NTH):
# 	x = threading.Thread(target=register_data_on_Contract, args=(DOs[i][2], DOs[i][0], DOs[i][1], 0, data_counter, OperationNum, price, DataConsumerAddress, 0,))
# 	threads.append(x)
# 	x.start()

# tic = time.time()
# for index, thread in enumerate(threads):
# 	thread.join()
# 	print('Thread',index,'done')  

# pararange = np.arange(NTH)
# print(pararange)
tocs = []
tic = time.time()
futures=[]
with concurrent.futures.ThreadPoolExecutor() as executor:
	# future = executor.submit(register_data_on_Contract, DOs[0][2], DOs[0][0], DOs[0][1], 0, data_counter, OperationNum, price, DataConsumerAddress, 0)
	# futures = [executor.submit(register_data_on_Contract, DOs[i][2], DOs[i][0], DOs[i][1], 0, data_counter, OperationNum, price, DataConsumerAddress, 0) ]
	for l in range(L):
		for p in range(P):
			idx = l*P + p
			futures.append(executor.submit(register_data_on_Contract, DOs[idx][2], DOs[idx][0], DOs[idx][1], 0, data_counter, OperationNum, price, DataConsumerAddress, 0))
		if l < L-1:
			time.sleep(15*E/L) # 150 = one epoch time = 10 G-Chain block cycles

	tocs = [f.result() for f in futures]

tocs = np.array(tocs)
elapses = tocs - tic

for l in range(L):
	for p in range(P):
		idx = l*P + p
		elapses[idx] -= 15*E/L * l


# toc = time.time()
# print(tocs-tic)
print('Collected',len(elapses),'/',L*P)
print('mean:', np.mean(elapses))
print('std:', np.std(elapses))
print('min max:', elapses.min(), elapses.max())

