// The orginal full tx generation process of geth
var Web3 = require('web3');
// var web3 = new Web3(new Web3.providers.HttpProvider('https://ropsten.infura.io/'));
// var web3 = new Web3(new Web3.providers.HttpProvider('https://rinkeby.infura.io/'));
var web3 = new Web3(new Web3.providers.HttpProvider('https://rinkeby.infura.io/v3/a50e7d8fcaeb49fca1685d34ccdf3611'));
// var util = require('ethereumjs-util');
var tx = require('ethereumjs-tx').Transaction;


var argv = process.argv;

// var address = '0xac5d434a4a9cf170baaa5d1be12b48c7fe358fa0';
// var pkey = Buffer.from('3bdc966729b1c929efa2053c40c77f31cf2e9048950c8f86af937780e5686dbd', 'hex');
var address = argv[7];
var pkey = Buffer.from(argv[8], 'hex');



web3.eth.getTransactionCount(address).then(function (res, err){
	if (err) {
		console.log('error: ' + err);

	}
	else {
		var txCount = res;
		var rawTx = {
		    nonce: web3.utils.numberToHex(txCount),
		    gasPrice: web3.utils.numberToHex(argv[2]),
		    gasLimit: web3.utils.numberToHex(argv[3]),
		    to: argv[4], // DO's address
		    value: web3.utils.numberToHex(argv[5]), // 0.01 ether
		    data: argv[6]
		};

		// var transaction = new tx(rawTx);
		var transaction = new tx(rawTx, { chain: 'rinkeby'});
		transaction.sign(pkey); // This step needs to be done in the enclave
		var RawTxHex = '0x' + transaction.serialize().toString('hex'); // This is what we need to feed the api
		// console.log('\nRawTxHex:\n' + RawTxHex);
		web3.eth.sendSignedTransaction(RawTxHex).on('receipt', console.log);
	}
});