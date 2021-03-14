pragma solidity 0.7.4;

contract TimeBasedNFTData {

    mapping(uint => string[2]) tokenUri;
    
    address tokenContract;
    
    constructor(address _tokenContract) {
        tokenContract = _tokenContract;    
    }
    

    function getTokenURI(uint _tokenId) external view returns (string memory)  {
        uint8 hour = uint8((block.timestamp / 60 / 60) % 24);
        
        //calculate AM/PM in IST
        hour = hour + 5;
        
        if(hour > 24) {
            hour = hour - 24;
        }
        
        if(hour < 12 ) {
            return tokenUri[_tokenId][0];    
        } else {
            return tokenUri[_tokenId][1];
        }
        
    }
    
    //TODO add restriction
    function mint(uint _tokenId, string memory _amURI, string memory _pmURI) public returns (bool){
        require(msg.sender == tokenContract, "Sorry Human, You can't call this function");
        tokenUri[_tokenId] = [_amURI, _pmURI];
        return true;
    }
    
}}
//0x58475Fc946cab6B4fFB524eE5492B7a934EaB89E - nft
//0x63E17847F940B2fa193641849ADc4b3Ec0D54523 - timebased


//JSON MORNING HASH - Qmdw88xTrq9ns1iZSwEs6Hn3G6aVFJLBfsFycSurqLmSDS
//JSON Not morning HASH - QmNXQo8Ex5TVsdFp9aGjLaNAb3HhzhBFEbWP9iDvMnZRS3