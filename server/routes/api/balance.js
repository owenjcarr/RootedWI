const express = require('express');
const router = express.Router();
const getAllData = require('../../accessBalanceSheet');



async function getBalance(name){
    let data = await getAllData(name);
    console.log(data);
    return data;
}


router.get('/:name', async (req,res) => {
    let name = req.params.name;
    let balance = await getBalance(name);
    res.writeHead(200, {'Content-Type': 'application/json'});
    res.end(JSON.stringify({name, balance}));
})

module.exports = router;