pragma solidity 0.7.4;

interface IERC721 {
    function ownerOf(uint256 tokenId) external view returns (address owner);
}
contract lockerNFTData {

    mapping(uint => string[2]) tokenUri;
    mapping(uint => uint) amountUsedToMint;
    mapping(uint => bool) isWithdrawn;
    
    address tokenContractAddr;
    IERC721 tokenContract;
    
    constructor(address _tokenContract) {
        tokenContractAddr = _tokenContract;    
        tokenContract = IERC721(_tokenContract);
    }
    
    function getTokenURI(uint _tokenId) external view returns (string memory)  {
        if(isWithdrawn[_tokenId]) {
            return tokenUri[_tokenId][1];
        } else {
            return tokenUri[_tokenId][0];
        }
    }
    
    
    function mint(uint _tokenId, string memory _notWithdrawn, string memory _withdrawn) public payable returns (bool){
        require(msg.sender == tokenContractAddr, "Sorry Human, You can't call this function");
        require(amountUsedToMint[_tokenId] == 0, "Token Already Exists"); //`NOT A GOOD` way to check :P
        require(msg.value > 0, "Should lock some amount to perform this action");
        tokenUri[_tokenId] = [_notWithdrawn, _withdrawn];
        amountUsedToMint[_tokenId] = msg.value;
        return true;
    }
    
    function withdraw(uint _tokenId) public {
        require(tokenContract.ownerOf(_tokenId) == msg.sender, "You are not the owner... Try polyjuice potion maybe??");
        require(isWithdrawn[_tokenId] == false, "Already Withdrawn");
        isWithdrawn[_tokenId] = true;
        (bool success, bytes memory data) = payable(msg.sender).call{value: amountUsedToMint[_tokenId]}("");
        
        require(success, "Withdraw failed");
    }
    
}