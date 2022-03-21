// SPDX-License-Identifier: GPL-3.0

pragma solidity >=0.7.0 <0.9.0;

/** 
 * @title BDSAS_Regulate
 * @dev Implements the G-Chain Regulatory Contract for one L-Chain in BD-SAS. Experimental version 0.2.0
 */
contract BDSAS_Regulate {

    struct Server { // SAS server
        bytes32 desc; // Description, e.g., name, IP address, other credentials.
        uint8 status; // 0: valid, 1: invalidated
    }

    struct Witness { // Local witness
        bytes32 desc; // Description, e.g., name, IP address, other credentials.
        uint8 status; // 0: anchor witness, 1: normal witness, 2: invalidated
    }

    struct VRF_Proposal { // Verifiable random function (VRF) proposal (based on ed25519)
        bytes32 pubkey; // Public key - 32 bytes
        bytes32[2] hash; // Hash - 64 bytes
        bytes32[3] proof; // Proof - 80 bytes
    }

    address public regulator; // There could be multiple regulators, we assume one for convenience

    // L-Chain variables
    bytes32 public DESC; // Description on the spectrum region, e.g., state-county name
    bytes32 public INTF; // Interference model parameters for the spectrum region
    uint public T_SHIFT; // The L-Chain's shift length in G-Chain block cycles
    uint public T_EPOCH; // The L-Chain's epoch length in G-Chain block cycles
    bool public is_reshuffling;
    mapping(address => Server) public cand_servers; // Candidate servers
    mapping(address => VRF_Proposal) public vrf_proposals;
    address[3] anchors; // We require 3 anchors fixed for an L-Chain
    address[5] curr_servers; // We require 5 servers to serve an L-Chain
    uint public shift; // Shift count
    uint public epoch; // Epoch count

    /** 
     * @dev Create a new regulatory contract.
       @param de: region description, im: interference model parameters, t_sh: shift length, t_ep: epoch length
     */
    constructor(bytes32 de, bytes32 im, uint t_sh, uint t_ep){
        regulator = msg.sender; // Regulator creates the contract
        DESC = de;
        INTF = im;
        T_SHIFT = t_sh;
        T_EPOCH = t_ep;
        is_reshuffling = false;
    }

    /**
     * @dev Manage participant (server or anchor peer) of the contract. Callable by regulator.
     * @param p: participant address, t (1: add server, 2: add anchor peer, 3: remove), L
     */
    function ManageParticipant(address p, uint t, bytes32 de) public {
        require(msg.sender == regulator, "Only regulator can manage participants.");
        if (t == 1) {
            cand_servers[p].status = 0;
        } 
    }

    /** 
     * @dev Publish/update new spectum access rules. Callable by regulator.
     * @param type of regulation, target account
     */
    function Publish(uint t, address account, uint[] lchain) public {
    
    }

    /** 
     * @dev Collect server reshuffle information. Callable by a server.
     * @param L-Chain index, parts of VRF hash, parts of VRF proof
     */
    function Reshuffle(bytes32 pubkey, bytes32[3] hash, bytes32[2] proof) public {
        require()
        require(cand_servers[msg.sender].status == 0, "The sender does not exist or is no longer valid");

    }

    /** 
     * @dev Collect confirmation on SAS servers from local witnesses. Callable by a witness. (1 proposal N-1 confirmations)
     * @param L-Chain index, parts of VRF hash, parts of VRF proof
     */
    function ReshuffleConfirm(address[5] chosen_servers) public {

    }

    function LocalUpdate(uint i, bytes32 state) public {
        
    }

}