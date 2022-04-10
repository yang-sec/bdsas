'use strict';

const { WorkloadModuleBase } = require('@hyperledger/caliper-core');

class MyWorkload extends WorkloadModuleBase {

    static iter1;
    static iter2; 

    constructor() {
        super();
    }
    
    async initializeWorkloadModule(workerIndex, totalWorkers, roundIndex, roundArguments, sutAdapter, sutContext) {
        await super.initializeWorkloadModule(workerIndex, totalWorkers, roundIndex, roundArguments, sutAdapter, sutContext);
        this.iter1 = 0;
        this.iter2 = 0;
        this.locations_per_worker = this.roundArguments.locations/this.totalWorkers;

        // We initialize all 10 channels at all 100 for all users
        for (let i=0; i<this.roundArguments.channels; i++) { 
            const channelIdx = i + 6; // We assume channel 1~5 are dedicated to PAL users as were initialized in contract 
            for (let j=0; j<this.locations_per_worker; j++) {
                const locationIdx = j + this.workerIndex * this.locations_per_worker + 1;
                console.log(`GAA User ${this.workerIndex}: Requesting Access to Channel ${channelIdx} Location ${locationIdx}`);
                const request = {
                    contractId: this.roundArguments.contractId,
                    contractFunction: 'Access',
                    invokerIdentity: `Test User`,
                    contractArguments: [`GAA${this.workerIndex}`, channelIdx, locationIdx, 30, 'Private LTE'],
                    readOnly: false
                };
                await this.sutAdapter.sendRequests(request);
            }
        }
    }
    
    async submitTransaction() {
        this.iter1 = (this.iter1 + 1) % this.roundArguments.channels;
        this.iter2 = (this.iter2 + 1) % this.locations_per_worker;
        const channelIdx = this.iter1 + 6;
        const locationIdx = this.iter2 + this.workerIndex * this.locations_per_worker + 1;
        const myArgs = {
            contractId: this.roundArguments.contractId,
            contractFunction: 'Heartbeat',
            invokerIdentity: 'Test User',
            contractArguments: [`GAA${this.workerIndex}`, channelIdx, locationIdx, 30, 'Private LTE'],
            readOnly: false
        };
        // console.log(`GAA User ${this.workerIndex}: Providing Heartbeat to Assignment of Channel ${channelIdx} Location ${locationIdx}`);
        await this.sutAdapter.sendRequests(myArgs);
    }
    
    async cleanupWorkloadModule() {
        for (let i=0; i<this.roundArguments.channels; i++) {
            const channelIdx = i + 6;
            for (let j=0; j<this.locations_per_worker; j++) {
                const locationIdx = j + this.workerIndex*this.roundArguments.locations/this.totalWorkers + 1;
                console.log(`GAA User ${this.workerIndex}: Deleting assignment of Channel ${channelIdx} Location ${locationIdx}`);
                const request = {
                    contractId: this.roundArguments.contractId,
                    contractFunction: 'DeleteAssignment',
                    invokerIdentity: 'Test User',
                    contractArguments: [`GAA${this.workerIndex}`, channelIdx, locationIdx],
                    readOnly: false
                };
                await this.sutAdapter.sendRequests(request);
            }
        }
    }
}

function createWorkloadModule() {
    return new MyWorkload();
}

module.exports.createWorkloadModule = createWorkloadModule;
