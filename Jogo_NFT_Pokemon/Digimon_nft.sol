// SPDX-License-Identifier: GPL-3.0

pragma solidity ^0.8.0;


import "@openzeppelin/contracts/token/ERC721/ERC721.sol";

contract Digimon_nft is ERC721{

    struct Digimon{
        string name;
        uint level;
        string img;
        uint life;
        uint power;
        uint defesa;
        
    }

    Digimon[] public Digimons;
    address public gameOwner;

    constructor () ERC721 ("Digimon_nft", "DGN"){

        gameOwner = msg.sender;

    } 

    modifier onlyOwnerOf(uint _monsterId) {

        require(ownerOf(_monsterId) == msg.sender,"Apenas o dono pode batalhar com este Digimon");
        _;

    }

    function battle(uint _attackingDigimon, uint _defendingDigimon) public onlyOwnerOf(_attackingDigimon){
        Digimon storage attacker = Digimons[_attackingDigimon];
        Digimon storage defender = Digimons[_defendingDigimon];

         if (attacker.power >= defender.defesa) {
            defender.life -= attacker.power - defender.defesa;
        }else{
            attacker.life -= defender.defesa - attacker.power;
        }
    }

    function createNewDigimon(string memory _name, address _to, string memory _img) public {
        require(msg.sender == gameOwner, "Apenas o dono do jogo pode criar novos Digimons");
        uint id = Digimons.length;
        Digimons.push(Digimon(_name, 1,_img));
        _safeMint(_to, id);
    }

}