const express = require('express');
const router = express.Router();
const getAllData = require('../../accessBalanceSheet');



async function getBalance(email){
    let data = await getAllData(email);
    console.log(data);
    return data;
}


router.get('/:email', async (req,res) => {
    let email = req.params.email;
    let response = await getBalance(email);
    res.writeHead(200, {'Content-Type': 'application/json'});
    res.end(JSON.stringify(response));
})

module.exports = router;