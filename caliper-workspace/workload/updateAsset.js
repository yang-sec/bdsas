'use strict';

const { WorkloadModuleBase } = require('@hyperledger/caliper-core');

class MyWorkload extends WorkloadModuleBase {

    static iter; 

    constructor() {
        super();
    }
    
    async initializeWorkloadModule(workerIndex, totalWorkers, roundIndex, roundArguments, sutAdapter, sutContext) {
        await super.initializeWorkloadModule(workerIndex, totalWorkers, roundIndex, roundArguments, sutAdapter, sutContext);
        this.iter = 0;

        for (let i=0; i<this.roundArguments.assets; i++) {
            const assetID = `${this.workerIndex}_${i}`;
            console.log(`Worker ${this.workerIndex}: Creating asset ${assetID}`);
            const request = {
                contractId: this.roundArguments.contractId,
                contractFunction: 'CreateAsset',
                invokerIdentity: 'User1',
                contractArguments: [assetID,'blue','20','penguin','500'],
                readOnly: false
            };

            await this.sutAdapter.sendRequests(request);
        }
    }
    
    async submitTransaction() {
        this.iter = (this.iter + 1) % this.roundArguments.assets;
        const assetId = `${this.workerIndex}_${this.iter}`;
        const randomValue = Math.floor(Math.random()*500);
        const myArgs = {
            contractId: this.roundArguments.contractId,
            contractFunction: 'UpdateAsset',
            invokerIdentity: 'User1',
            contractArguments: [assetId,'blue','20','penguin',`${randomValue}`],
            readOnly: false
        };
        console.log(`Worker ${this.workerIndex}: Updating asset ${assetId}`);
        await this.sutAdapter.sendRequests(myArgs);
    }
    
    async cleanupWorkloadModule() {
        for (let i=0; i<this.roundArguments.assets; i++) {
            const assetID = `${this.workerIndex}_${i}`;
            console.log(`Worker ${this.workerIndex}: Deleting asset ${assetID}`);
            const request = {
                contractId: this.roundArguments.contractId,
                contractFunction: 'DeleteAsset',
                invokerIdentity: 'User1',
                contractArguments: [assetID],
                readOnly: false
            };

            await this.sutAdapter.sendRequests(request);
        }
    }
}

function createWorkloadModule() {
    return new MyWorkload();
}

module.exports.createWorkloadModule = createWorkloadModule;
