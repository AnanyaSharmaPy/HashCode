pragma solidity ^0.5.0;

contract createNetwork{

    struct user {
        address payable person;
        uint256 excess;
        uint256 request;
        uint256 accountBalance;
        string location;
    }

    mapping(bytes32 => user) users;
    mapping(address => bytes32) active;

    event joined(bytes32 id,address payable person,string location,uint256 excess,uint256 request,uint256 accountBalance);
    event addedSurplus(bytes32 id,address payable person,uint256 surplus);

    function join(string memory _location) public{
        require(active[msg.sender]==bytes32(0),"already joined the network");
        bytes32 id = keccak256(abi.encodePacked(msg.sender,_location));
        users[id] = user(msg.sender,0,0,100,_location);
        active[msg.sender] = id;
        emit joined(id,msg.sender,_location,0,0,100);
    }

    function addSurplus(uint _surplus) public {
        require(active[msg.sender]!=bytes32(0),"not in the network");
        bytes32 id = active[msg.sender];
        user storage User = users[id];
        User.excess +=_surplus;
        emit addedSurplus(id,msg.sender,User.excess);
    }

    function retrieveData(address _person) public view returns(bytes32,address,string memory,uint256,uint256) {
        require(active[_person]!=bytes32(0),"not in the network");
        bytes32 id = active[msg.sender];
        user storage User = users[id];
        return (id,User.person,User.location,User.excess,User.request);
    }
}

contract exchangePower is createNetwork {

    event requestedForEnergy (address payable eReceiver, uint256 noOfUnits);
    event confirmTransfer (address eReceiver,address eSender, uint256 noOfUnits);

    function requestEnergy(uint256 _units) public {
        bytes32 recId = active[msg.sender];
        user storage eReceiver = users[recId];
        uint256 price = (_units * 87)/10;
        require(eReceiver.accountBalance >= price, "Insufficient funds..");
        eReceiver.request += _units;
        emit requestedForEnergy(msg.sender, _units);
    }

    function comfirmTransfer(address _eReceiver, uint256 _noOfUnits) public {
        bytes32 recId = active[_eReceiver];
        user storage eReceiver = users[recId];
        bytes32 sendId = active[msg.sender];
        user storage eSender = users[sendId];
        uint256 price = (_noOfUnits * 87)/10;
        require(msg.sender != _eReceiver, "Cannot send to self");
        require(eSender.excess >= _noOfUnits && eReceiver.request >= _noOfUnits);
        eSender.excess -= _noOfUnits;
        eReceiver.request -= _noOfUnits;
        eSender.accountBalance += price;
        eReceiver.accountBalance -= price;
    }

}