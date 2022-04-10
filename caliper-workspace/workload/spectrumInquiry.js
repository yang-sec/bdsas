'use strict';

const { WorkloadModuleBase } = require('@hyperledger/caliper-core');

class MyWorkload extends WorkloadModuleBase {
    constructor() {
        super();
    }
    
    async initializeWorkloadModule(workerIndex, totalWorkers, roundIndex, roundArguments, sutAdapter, sutContext) {
        await super.initializeWorkloadModule(workerIndex, totalWorkers, roundIndex, roundArguments, sutAdapter, sutContext);
        this.locations_per_worker = this.roundArguments.locations/this.totalWorkers;

        // We initialize 1/4 of all channels at all 100 for all users
        for (let i=0; i<this.roundArguments.channels/4; i++) { 
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
        const randomChannel = Math.floor(Math.random()*this.roundArguments.channels) + 6;
        const randomLocation = Math.floor(Math.random()*this.roundArguments.locations) + 6;
        const myArgs = {
            contractId: this.roundArguments.contractId,
            contractFunction: 'Inquiry',
            invokerIdentity: 'Test User',
            contractArguments: [randomChannel, randomLocation], // We assume User ID = Location Index
            readOnly: true
        };

        await this.sutAdapter.sendRequests(myArgs);
    }
    
    async cleanupWorkloadModule() {
        for (let i=0; i<this.roundArguments.channels/4; i++) {
            const channelIdx = i + 6;
            for (let j=0; j<this.locations_per_worker; j++) {
                const locationIdx = j + this.workerIndex*this.locations_per_worker + 1;
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
