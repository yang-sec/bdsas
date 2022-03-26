from secrets import token_bytes
from coincurve import PublicKey
from sha3 import keccak_256

N = 90

f = open("NewAddressesPrivKeys.py", "w")

f.write('# ------ ["$address", "$private_key"] ------\n')
f.write('AddressesPrivKeys = [\n')

addrs = []

for i in range(N):
	private_key = keccak_256(token_bytes(32)).digest()
	public_key = PublicKey.from_valid_secret(private_key).format(compressed=False)[1:]
	addr = keccak_256(public_key).digest()[-20:]
	if i == N-1:
		f.write('["0x' + addr.hex() + '", "' + private_key.hex() + '"]\n]')
	else:
		f.write('["0x' + addr.hex() + '", "' + private_key.hex() + '"],\n')
	addrs.append(addr)

f.write('\n\nAddresses = [\n')

for i in range(N):
	if i == N-1:
		f.write('0x'+addrs[i].hex() + '\n]')
	else:
		f.write('0x'+addrs[i].hex() + ',\n')

f.close()