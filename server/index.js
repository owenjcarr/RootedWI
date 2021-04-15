const express = require('express');
const connectDB = require('./config/db');
const connectDB_temp = require('./config/db_temp');
const getAllData = require('./accessBalanceSheet');

connectDB()

const app = express();

// bodyparser middleware
app.use(express.json());

// use routes
app.use('/api/users', require ('./routes/api/users'));
app.use('/api/auth', require ('./routes/api/auth'));


// TODO: use express routes
async function getBalance(name){
    let data = await getAllData(name);
    console.log(data);
    return data;
}

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

app.get('/api/produce', async (req, res) => {
    let produce = await getProduce();
    // TODO: use try catch to return 400 on error
    res.writeHead(200, {'Content-Type': 'application/json'});
    res.end(JSON.stringify(produce));
})

app.get('/api/balance/:name', async (req,res) => {
    let name = req.params.name;
    let balance = await getBalance(name);
    res.writeHead(200, {'Content-Type': 'application/json'});
    res.end(JSON.stringify({name, balance}));
})

app.get('/', (req,res) => {
    res.send('Hello World');
})

const PORT = process.env.PORT || 8000;

app.listen(PORT, console.log(`Server running in ${process.env.NODE_ENV} mode on port ${PORT}`));