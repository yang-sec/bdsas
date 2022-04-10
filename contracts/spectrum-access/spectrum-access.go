/* 
  Prototype code of the spectrum access contract used in BD-SAS
  - Here we implement a straightforward FCFS spectrum allocation model, over fixed channel-location availabilities.
  - This is for demonstrating the basic feasibility of our Hyperledger Fabric-based prototype.
  - More complex models, including one involving interference calculation and optimized channel scheduling, are left to future implementation.

  Yang Xiao, Virginia Tech, 4/7/2022
*/

package main

import (
  "encoding/json"
  "fmt"
  "time"
  "strconv"
  "log"

  "github.com/hyperledger/fabric-contract-api-go/contractapi"
)

// SmartContract provides functions for managing an Assignment
type SmartContract struct {
  contractapi.Contract
}

// Assignment describes basic details of what makes up a spectrum access assignment
type Assignment struct {
  ID             string `json:"id"`         // ID: "Channel-Location" (as the identifier for the assignment)
  User           string `json:"user"`       // Identifier of the user, e.g., "PAL1"
  Channel        int    `json:"channel"`    // Channel index (same as in ChaLoc)
  Location       int    `json:"location"`   // Location index (same as in ChaLoc)
  EIRP           int    `json:"eirp"`       // Effective Isotropic Radiated Power (dBm/10MHz)
  Desc           string `json:"desc"`       // Other description, e.g., antenna height, air interface technology, etc.
  TimeAS         string `json:"timeas"`      // Time of assignment
  TimeHB         string `json:"timehb"`      // Time of the last heartbeat
  Status         int    `json:"status"`     // Status of assignment. 0: assigned (not yet alive), 1: alive (as a result of having fresh "Heartbeart"), 2: vacate
}

// InitLedger
// We assume there are 4 PAL users already 
func (s *SmartContract) InitLedger(ctx contractapi.TransactionContextInterface) error {
  assignments := []Assignment{
    {ID: "ACCESS1_1", User: "PAL1", Channel: 1, Location: 1, EIRP: 47, Desc: "Verizon 5G", TimeAS: time.Now().Format("01-01-2001 10:00:00"), TimeHB: "0", Status: 0},
    {ID: "ACCESS1_2", User: "PAL1", Channel: 1, Location: 2, EIRP: 47, Desc: "Verizon 5G", TimeAS: time.Now().Format("01-01-2001 10:00:00"), TimeHB: "0", Status: 0},
    {ID: "ACCESS1_3", User: "PAL2", Channel: 1, Location: 3, EIRP: 47, Desc: "AT&T LTE", TimeAS: time.Now().Format("01-01-2001 10:00:00"), TimeHB: "0", Status: 0},
    {ID: "ACCESS2_1", User: "PAL3", Channel: 2, Location: 1, EIRP: 47, Desc: "VT Wireless", TimeAS: time.Now().Format("01-01-2001 10:00:00"), TimeHB: "0", Status: 0},
  }

  for _, assignment := range assignments {
    assignmentJSON, err := json.Marshal(assignment)
    if err != nil {
      return err
    }

    err = ctx.GetStub().PutState(assignment.ID, assignmentJSON)
    if err != nil {
      return fmt.Errorf("failed to put to world state. %v", err)
    }
  }

  return nil
}

/* 
  Access creates an access assignment of channel-location according to user request. 
  Here is where we realize the straightforward FCFS spectrum access model.
*/
func (s *SmartContract) Access(ctx contractapi.TransactionContextInterface, user string, channel int, location int, eirp int, desc string) error {
  
  id := "ACCESS" + strconv.Itoa(channel) + "_" + strconv.Itoa(location)
  exists, err := s.AssignmentExists(ctx, id)
  if err != nil {
    return err
  }
  if exists {
    return fmt.Errorf("the assignment %s already exists, try other channels", id)
  }

  assignment := Assignment{
    ID:             id,
    User:           user,
    Channel:        channel,
    Location:       location,
    EIRP:           eirp,
    Desc:           desc,
    TimeAS:         time.Now().Format("01-01-2001 10:00:00"),
    TimeHB:         "0",
    Status:         0,
  }
  assignmentJSON, err := json.Marshal(assignment)
  if err != nil {
    return err
  }

  return ctx.GetStub().PutState(id, assignmentJSON)
}

/* 
  Inquiry returns the availability of a potential assignment in the world state (similar to but slightly different from ReadAssignment)
*/
func (s *SmartContract) Inquiry(ctx contractapi.TransactionContextInterface, channel int, location int) (int, error) {
  
  id := "ACCESS" + strconv.Itoa(channel) + "_" + strconv.Itoa(location)
  assignmentJSON, err := ctx.GetStub().GetState(id)
  if err != nil {
    return 9, fmt.Errorf("failed to read from world state: %v", err)
  }
  if assignmentJSON == nil {
    return 0, nil // Available
  }

  return 1, nil // Occupied. Here we return an "int" in case there are more states to consider
}

/* 
  ReadAssignment returns the existence of an assignment in the world state
*/
func (s *SmartContract) ReadAssignment(ctx contractapi.TransactionContextInterface, channel int, location int) (*Assignment, error) {
  
  id := "ACCESS" + strconv.Itoa(channel) + "_" + strconv.Itoa(location)
  assignmentJSON, err := ctx.GetStub().GetState(id)
  if err != nil {
    return nil, fmt.Errorf("failed to read from world state: %v", err)
  }
  if assignmentJSON == nil {
    return nil, fmt.Errorf("assignment %s does not exist available", id)
  }

  var assignment Assignment
  err = json.Unmarshal(assignmentJSON, &assignment)
  if err != nil {
    return nil, err
  }

  return &assignment, nil
}

/* 
  Heartbeat indicates an existing assignment in the world state to show the user is still alive, and update relevant information 
*/
func (s *SmartContract) Heartbeat(ctx contractapi.TransactionContextInterface, user string, channel int, location int, eirp int, desc string) error {
  
  assignment, err := s.ReadAssignment(ctx, channel, location)
  if err != nil {
    return fmt.Errorf("assignment ID %s does not exist ", assignment.ID)
  }
  if assignment.ID != "ACCESS" + strconv.Itoa(channel) + "_" + strconv.Itoa(location) {
    return fmt.Errorf("assignment ID %s does not match the provided channel and location ", assignment.ID)
  }
  if assignment.User != user {
    return fmt.Errorf("assignment User %s does not match the provide user ", assignment.User)
  }

  assignment.EIRP = eirp
  assignment.Desc = desc
  assignmentJSON, err1 := json.Marshal(assignment)
  if err1 != nil {
    return err1
  }

  return ctx.GetStub().PutState(assignment.ID, assignmentJSON)
}

/* 
  DeleteAssignment deletes an given assignment from the world state.
*/
func (s *SmartContract) DeleteAssignment(ctx contractapi.TransactionContextInterface, user string, channel int, location int) error {
  
  id := "ACCESS" + strconv.Itoa(channel) + "_" + strconv.Itoa(location)
  exists, err := s.AssignmentExists(ctx, id)
  if err != nil {
    return err
  }
  if !exists {
    return fmt.Errorf("the assignment %s does not exist", id)
  }

  return ctx.GetStub().DelState(id)
}

/* 
  AssignmentExists returns true when assignment with given ID exists in world state
*/
func (s *SmartContract) AssignmentExists(ctx contractapi.TransactionContextInterface, id string) (bool, error) {
  assignmentJSON, err := ctx.GetStub().GetState(id)
  if err != nil {
    return false, fmt.Errorf("failed to read from world state: %v", err)
  }

  return assignmentJSON != nil, nil
}


/* 
  GetAllAssignments returns all assignments found in world state
*/
func (s *SmartContract) GetAllAssignments(ctx contractapi.TransactionContextInterface) ([]*Assignment, error) {
  // range query with empty string for startKey and endKey does an
  // open-ended query of all assignments in the chaincode namespace.
  resultsIterator, err := ctx.GetStub().GetStateByRange("", "")
  if err != nil {
    return nil, err
  }
  defer resultsIterator.Close()

  var assignments []*Assignment
  for resultsIterator.HasNext() {
    queryResponse, err := resultsIterator.Next()
    if err != nil {
      return nil, err
    }

    var assignment Assignment
    err = json.Unmarshal(queryResponse.Value, &assignment)
    if err != nil {
      return nil, err
    }
    assignments = append(assignments, &assignment)
  }

  return assignments, nil
}

func main() {
  assignmentChaincode, err := contractapi.NewChaincode(&SmartContract{})
  if err != nil {
    log.Panicf("Error creating spectrum-access chaincode: %v", err)
  }

  if err := assignmentChaincode.Start(); err != nil {
    log.Panicf("Error starting spectrum-access chaincode: %v", err)
  }
}