// SPDX-License-Identifier: GPL-3.0

pragma solidity >=0.7.0 <0.9.0;

/** 
 * @title BDSAS_Regulate
 * @dev Implements the G-Chain Regulatory Contract for one L-Chain in BD-SAS. Experimental version 0.2.0
 */
contract BDSAS_Regulate {

    struct Server { // SAS server
        bytes32 desc; // Description, e.g., name, IP address, other credentials.
        uint8 status; // 0: valid, 1: invalid
    }

    struct Witness { // SAS server
        bytes32 desc; // Description, e.g., name, IP address, other credentials.
        uint8 status; // 0: valid, 1: invalid
        bool reshuffle_vote; // For confirming a reshuffle proposal
        bool update_vote; // For confirming an update
    }

    struct Regulation { // Short-term regulation, e.g., "order to vacate" due to incumbent arrival
        bytes32 desc; // Description of regulation content
        uint start_time;
        uint end_time;
        uint8 status; // 0: valid, 1: invalid
    }

    struct Proposal { // Verifiable random function (VRF) proposal (based on ed25519)
        bytes32 pubkey; // Public key - 32 bytes
        bytes32[2] hash; // Hash - 64 bytes
        bytes32[3] proof; // Proof - 80 bytes
        uint shift_num;
    }

    address public regulator; // There could be multiple regulators, we assume one for convenience

    /* L-Chain variables */
    bytes32 public DESC; // Description on the spectrum region, e.g., state-county name
    bytes32 public INTF; // Interference model parameters for the spectrum region
    uint public T_SHIFT; // The L-Chain's shift length in G-Chain block cycles
    uint public T_EPOCH; // The L-Chain's epoch length in G-Chain block cycles
    mapping(address => Server) public Servers;   // Candidate servers
    address[5] public Witness_Addr;              // We fix 5 witnesses, Witnesses[0] is the anchor
    mapping(address => Witness) Witnesses;       // For access control on witnesses
    address[5] public CurrentServers;            // We require 5 servers to serve an L-Chain
    uint public shift; // Shift count
    uint public epoch; // Epoch count
    Regulation[] public Regulations; // List of short-term regulations

    /* Variables for SAS server reshuffling */
    mapping(address => Proposal) public ReshuffleProposals; // Candidate server' VRF info
    uint8 reshuffle_status; // 0: accepting confirmation, 1: confirmation success, 2: confirmation failure (more than half are no-votes)
    uint reshuffle_vote_count;
    address[5] public ProposedServers; // For the next shift

    /** 
     * @dev Create a new regulatory contract.
       @param t_sh: shift length, t_ep: epoch length
     */
    constructor(uint t_sh, uint t_ep){
        regulator = msg.sender; // Regulator creates the contract
        DESC = "This is a test G-Chain contract";
        INTF = "Test parameters";
        T_SHIFT = t_sh;
        T_EPOCH = t_ep;
        reshuffle_status = 1;

        // We fix the 5 witnesses for convenience of testing. In real deployment they could be managed by the regulator
        Witness_Addr[0] = 0x8057442400c8634B95BA68b76922b2A486FBe4CF; // Also the anchor
        Witness_Addr[1] = 0xFE7079bbebb5fC8ad4a62fdDeB3556Cb691b2d3E;
        Witness_Addr[2] = 0xE362321EeddfC2513a54f8427C5ba40d088e8294;
        Witness_Addr[3] = 0x9463D8301D38341d5f6f7F5304Dd8E3e29867141;
        Witness_Addr[4] = 0x373E7DbF92e86Bc510F587bA560707A83d4f795E;
        for(uint i = 0; i < 5; i++) {
            Witnesses[Witness_Addr[i]].desc = "Fixed witness";
            Witnesses[Witness_Addr[i]].status = 1; // Valid
            Witnesses[Witness_Addr[i]].reshuffle_vote = false;
        }
    }
 
    /**
     * @dev Manage participant (server or anchor peer) of the contract. Callable by regulator.
     * @param p: participant address, a: action (0: invalidate, 1: normal), de: description
     */
    function ManageServer(address p, uint8 a, bytes32 de) public {
        require(msg.sender == regulator, "Only regulator can manage participants.");
        require(a == 0 || a == 1, "Illegal action on server.");
        Servers[p].status = a;
        Servers[p].desc = de;
    }

    /** 
     * @dev Publish/update new spectum access rules. Callable by regulator.
     * @param de: description, st: start time, et: end time, s: status 
     */
    function Publish(bytes32 de, uint st, uint et, uint8 s) public {
        require(msg.sender == regulator, "Only regulator can publish regulations.");
        Regulations.push(Regulation({desc: de, start_time: st, end_time: et, status: s}));
    }

    /** 
     * @dev Collect server reshuffle information. Callable by a server.
     * @param pubkey: VRF public key, hash: VRF hash (result), proof: VRF proof
     */
    function ReshufflePropose(bytes32 pubkey, bytes32[] memory hash, bytes32[] memory proof) public {
        // By original design, we would need to have all VRF proposals submitted within one epoch near the shift's end
        // Such time constraints will be added in future; they are absent in this version for easier testing
        require(Servers[msg.sender].status == 0, "The SAS server does not exist or is no longer valid."); // Valid server
        ReshuffleProposals[msg.sender].pubkey = pubkey;
        ReshuffleProposals[msg.sender].hash[0] = hash[0];
        ReshuffleProposals[msg.sender].hash[1] = hash[1];
        ReshuffleProposals[msg.sender].proof[0] = proof[0];
        ReshuffleProposals[msg.sender].proof[1] = proof[1];
        ReshuffleProposals[msg.sender].proof[2] = proof[2];
        ReshuffleProposals[msg.sender].shift_num = block.number / T_SHIFT;
    }

    /** 
     * @dev Collect SAS server group nomination. Callable by the anchor witness.
     * @param sg: server group nomination by an anchor
     */
    function ReshuffleNominate(address[] memory sg) public {
        require(msg.sender == Witness_Addr[0], "The sender is not the anchor witness."); // Valid anchor witness
        require(reshuffle_status > 0, "Already nominated; waiting for confirmations.");
        for(uint i = 0; i < 5; i++) {
            ProposedServers[i] = sg[i];
        }
        Witnesses[msg.sender].reshuffle_vote = true; // The anchor's own vote
        for(uint i = 1; i < 5; i++) {
            Witnesses[Witness_Addr[i]].reshuffle_vote = false; // Restart the votes
        }
        reshuffle_vote_count = 1;
        reshuffle_status = 0;
    }

    /** 
     * @dev Collect SAS server group confirmations. Callable by a normal witness.
     */
    function ReshuffleConfirm() public returns(uint8) {
        require(reshuffle_status == 0, "The confirmation procedure ended.");
        require(msg.sender != Witness_Addr[0], "Only callable by a normal witness.");
        require(Witnesses[msg.sender].status == 1, "Invalid witness.");
        require(Witnesses[msg.sender].reshuffle_vote == false, "You have already voted for this shift.");
        
        reshuffle_vote_count ++;
        Witnesses[msg.sender].reshuffle_vote = true;
        if(reshuffle_vote_count >= 3) { // 3 out of 5 witnesses vote yes
            for(uint i = 1; i < 5; i++) {
                CurrentServers[i] = ProposedServers[i];
            }
            reshuffle_status = 1; // Success
        }
        return reshuffle_status;
    }

    /** 
     * @dev Allow a server to update its local service. Callable by a server.
     * @param state: local service state
     */
    function LocalUpdate(bytes32 state) public {
        // Here we implement a simple compensation scheme: 
        require
        
    }

    function LocalUpdateConfirm(bytes32 state) public {
        // Here we implement a simple compensation scheme: 
        
    }

}