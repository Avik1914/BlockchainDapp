pragma solidity ^0.5.0;

contract LandContract {

  string public name;
  //The owner details who has deployed the contract
  address public owner;
  uint public landCount = 0;

  mapping(uint => Land) public lands;

  struct Land {
    uint landID;
    string location;
    uint value;
    address payable owner;
    bool forSale;
  }

  constructor() public {
    name = "Ether Appartments";
    owner = msg.sender;
  }
  
  event Add(
    uint landID, 
    string location, 
    uint value, 
    address payable owner, 
    bool forSale
  );

  event Transfer(
    uint landID, 
    string location, 
    uint value, 
    address payable owner, 
    bool forSale
  );

  event List(
    uint landID, 
    string location, 
    uint value, 
    address payable owner, 
    bool forSale
  );
  //For add land feature this is needed to be checked  
  modifier isOwner {
    require(msg.sender == owner);
    _;
  } 
  //When new lands are added
  function addLand(string memory _location, uint _value) public isOwner {
    //Check for valid location
    require(bytes(_location).length > 0, 'Must be a valid location');

    //Check for valid value
    require(_value > 0, 'Must be a value');

    //Global land counter
    landCount++;
    
    //land details are stored here
    lands[landCount] = Land(landCount, _location, _value, msg.sender, true);

    //an event is triggered and returned
    emit Add(landCount, _location, _value, msg.sender, true);
  }

  function buyLand(uint _id) public payable {
    //Getting specific land details
    Land memory _land = lands[_id];

    //Address of land owner
    address payable _landHolder = _land.owner;

    //check for valid landID and landCount
    require(_land.landID > 0 && _land.landID <= landCount, 'land does not exist');
    
    //check for value whether it is sufficient or not
    require(msg.value >= _land.value, 'Not enough funds');

    //Checking the land is for sale or not
    require(_land.forSale == true, 'land is not for sale');

    //checking that buyer and the land owner are the same person or not
    require(_landHolder != msg.sender, 'buyer cannot be land owner');

    //populating new land owner details
    _land.owner = msg.sender;
    _land.forSale = false;
    lands[_id] = _land;

    //transfet of funds
    address(_landHolder).transfer(msg.value);

    //event is triggered
    emit Transfer(landCount, _land.location, _land.value, msg.sender, false);
  }
  
  function listLand(uint _id, uint _value) public payable {
    //Getting specific land details
    Land memory _land = lands[_id];

    //check for valid landID and landCount
    require(_land.landID > 0 && _land.landID <= landCount, 'land does not exist');

    //checking that seller and the land owner are the same person or not
    require(_land.owner == msg.sender, 'you are not the land owner');

    //Checking the land is for sale or not
    require(_land.forSale == false, 'land is already listed');

    //populating land storage and changing forSale to true
    _land.forSale = true;
    _land.value = _value;
    lands[_id] = _land;

    //event is triggered
    emit List(_id, _land.location, _value, msg.sender, true);
  }
}
    