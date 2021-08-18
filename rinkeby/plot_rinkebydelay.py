import matplotlib.pyplot as plt
import numpy as np

# construct some data like what you have:
mins_S  = np.array([5.25,	8.47,	8.53,	7.63,	6.74,	7.70,	11.71,	9.56])
maxes_S = np.array([15.50,	16.87,	35.20,	48.24,	61.15,	72.78,	122.35,	157.70])
means_S = np.array([10.44,	13.00,	22.56,	25.72,	33.12,	40.78,	54.35,	58.37])
std_S   = np.array([0.10,	0.27,	7.70,	12.15,	16.96,	21.19,	26.02,	30.98])



means_E = np.array([36.80,	33.38,	23.64,	15.35,	11.64,	10.96,	10.73])
std_E   = np.array([16.86,	12.52,	9.30,	5.56,	4.48,	4.40,	4.85])
mins_E  = np.array([8.74,	11.72,	3.70,	1.68,	2.64,	2.81,	1.75])
maxes_E = np.array([65.19,	55.27,	42.44,	28.05,	18.93,	18.92,	19.92])

NSet=np.array([10,20,40,60,80,100,120,140])
ESet=np.array([1,2,3,4,6,8,10])

E_Thresh = ESet * 15

###################################
plot1 = plt.figure(1,figsize=(6, 5))
# plt.figure(figsize=(6, 5))
# create stacked errorbars:
plt.errorbar(NSet, means_S, [means_S - mins_S, maxes_S - means_S], linestyle='-', marker='o', markersize=7, color='green', ecolor='gray', capsize=5, capthick=2)
plt.errorbar(NSet, means_S, std_S, linestyle='None', lw=8, color='orange')
plt.plot(np.arange(150),150*np.ones(150),':',color='red')

plt.legend([
	'Epoch time',
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
plt.errorbar(ESet, means_E, [means_E - mins_E, maxes_E - means_E], linestyle='-', marker='o', markersize=7, color='green', ecolor='gray', capsize=5, capthick=2)
plt.errorbar(ESet, means_E, std_E, linestyle='None', lw=8, color='orange')
plt.plot(ESet,E_Thresh,':s',color='red')

plt.legend([
	'Epoch time',
	'min/mean/max',
	'std'
	], fontsize='18')

plt.xlabel('Epoch length ($T^E$)', fontsize='18')
plt.ylabel('Finalization Latency (s)', fontsize='18')
# plt.grid(axis='y')
plt.xlim((0,11))
plt.ylim((0,70))
plt.xticks(fontsize='13')
plt.yticks(fontsize='13')
plt.savefig("g-chain-latency-normal.pdf", bbox_inches='tight')

plt.show()