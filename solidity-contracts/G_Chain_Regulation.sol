// SPDX-License-Identifier: GPL-3.0

pragma solidity >=0.7.0 <0.9.0;

/** 
 * @title SAS_Regulate
 * @dev Implements the G-Chain Regulatory Contract in BD-SAS
 */
contract SAS_Regulate {

    struct Regulator { // Managed by the FCC, NTIA, or other gov entities

    }

    struct Server { // SAS server

    }

    struct L_Chain { // L-Chain of a local spectrum region
        address 

    }

    struct Anchor_Peer { // Anchor peer of an L-Chain

    }

    mapping(address => Regulator) public regulators;
    mapping(address => Server) public servers;
    mapping(address => Anchor_Peer) public anchor_peers;

    /** 
     * @dev Create a new regulatory contract .
     * @param proposalNames names of proposals
     */
    constructor(){

    }

    /** 
     * @dev To publish/update new spectum access rules. Callable by a regulator.
     * @param type of regulation, target account
     */
    function publish(uint t, address account) public {
    
    }

    /** 
     * @dev To collect server reshuffle information. Callable by a server.
     * @param L-Chain index, VRF hash, VRF proof
     */
    function reshuffle()

}