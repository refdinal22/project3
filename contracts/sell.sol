pragma solidity ^0.4.0;

contract sell{

    struct voucher{
        address owner;
        string code;
        uint price;
        bool sold;
    }
    uint id=0;

    
    // goods public seller;
    mapping (uint=>voucher) seller;
    
    //fungsi untuk menjual voucher baru
    function selling(string code, uint price) public{
        seller[id].owner = msg.sender;
        seller[id].code = code;
        seller[id].price = price * 1e18;
        seller[id].sold = false;
        id++;
    }
    
    //fungsi untuk menjual kembali voucher
    function resell(uint idVoucher) public{
        seller[idVoucher].sold = false;
    }
    
    //fungsi untuk membeli voucher
    function buy(uint idVoucher) public payable{
        require(msg.value == seller[idVoucher].price);
        require(seller[idVoucher].sold == false);
        
        seller[idVoucher].owner.transfer(seller[idVoucher].price);
        seller[idVoucher].owner = msg.sender;
        seller[idVoucher].sold = true;
    }
    
    //menampilkan kode voucher
    function getcode(uint idVoucher) view public returns(string){
        require(msg.sender == seller[idVoucher].owner);

        return seller[idVoucher].code;
    }
}
