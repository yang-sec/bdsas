import matplotlib.pyplot as plt
import numpy as np

# construct some data like what you have:
mins_S  = np.array([12.84,	9.27,	17.38,	10.66,	3.22,	15.25,	9.23,	17.24])
maxes_S = np.array([14.12,	24.10,	49.64,	56.66,	77.17,	105.58,	113.87,	136.55])
means_S = np.array([13.25,	12.41,	30.56,	32.82,	40.73,	54.93,	57.71,	75.51])
std_S   = np.array([0.44,	5.83,	11.82,	16.32,	22.18,	27.09,	32.49,	38.51])


means_E = np.array([46.06,	37.09,	30.68,	26.08,	19.12,	12.68,	9.63,	8.68])
std_E   = np.array([22.89,	18.85,	15.26,	10.32,	7.07,	4.68,	4.42,	3.81])
mins_E  = np.array([10.69,	6.67,	4.74,	6.67,	3.96,	3.69,	2.74,	3.78])
maxes_E = np.array([90.35,	73.17,	56.82,	48.09,	32.67,	23.22,	17.83,	13.96])

NSet=np.array([10,20,40,60,80,100,120,140])
ESet=np.array([1,2,3,4,5,6,8,10])

E_Thresh = ESet * 15

###################################
plot1 = plt.figure(1,figsize=(6, 5))
# plt.figure(figsize=(6, 5))
# create stacked errorbars:
plt.errorbar(NSet, means_S, [means_S - mins_S, maxes_S - means_S], linestyle='', marker='o', markersize=7, color='green', ecolor='gray', capsize=5, capthick=2)
plt.errorbar(NSet, means_S, std_S, linestyle='None', lw=7, color='orange')
# plt.plot(np.arange(150),150*np.ones(150),':',color='red')

plt.legend([
	'min/mean/max',
	'std'
	], fontsize='18')

plt.xlabel('Number of SAS Servers ($N$)', fontsize='18')
plt.ylabel('Finalization Latency (s)', fontsize='18')
# plt.grid(axis='y')
plt.xlim((0,148))
plt.ylim((0,158))
plt.xticks(fontsize='13')
plt.yticks(fontsize='13')
plt.savefig("g-chain-latency-bursty.pdf", bbox_inches='tight')

###################################
plot2 = plt.figure(2,figsize=(6, 5))
# plt.figure(figsize=(6, 5))
# create stacked errorbars:
plt.errorbar(ESet, means_E, [means_E - mins_E, maxes_E - means_E], linestyle='', marker='o', markersize=7, color='green', ecolor='gray', capsize=5, capthick=2)
plt.errorbar(ESet, means_E, std_E, linestyle='None', lw=7, color='orange')
plt.plot(ESet,E_Thresh,':s',color='red')

plt.legend([
	'Epoch time',
	'min/mean/max',
	'std'
	], fontsize='18')

plt.xlabel('Epoch length ($T^E$ G-Chain blocks)', fontsize='18')
plt.ylabel('Finalization Latency (s)', fontsize='18')
# plt.grid(axis='y')
plt.xlim((0,11))
plt.ylim((0,95))
plt.xticks(fontsize='13')
plt.yticks(fontsize='13')
plt.savefig("g-chain-latency-normal.pdf", bbox_inches='tight')

plt.show()