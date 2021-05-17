const express = require('express');
const router = express.Router();
const connectDB_temp = require('../../config/db_temp');

async function _getProduce(client){
    const result = await client.db("data").collection("weekly_produce").find().toArray();
    if (result) {
        console.log(result);
    } else{
        console.error("weekly produce is empty");
    }
    return result;
};
async function getProduce(){
    let produce = await connectDB_temp(_getProduce);
    return produce;
}

router.get('/', async (req, res) => {
    let produce = await getProduce();
    // TODO: use try catch to return 400 on error
    res.writeHead(200, {'Content-Type': 'application/json'});
    res.end(JSON.stringify(produce));
})

module.exports = router;