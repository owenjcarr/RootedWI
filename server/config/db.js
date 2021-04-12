// const mongoose = require('mongoose');
const dbConfig = require('./dbConfig');
const {MongoClient} = require('mongodb');

const connectDB = async (f) => {
    const client = new MongoClient(dbConfig.database, {
        useNewUrlParser: true,
        useUnifiedTopology: true,
        useFindAndModify: false,
    });
    try {
        await client.connect();
        console.log(`MongoDB Connected`)
        return await f(client);
    } catch (err) {
        console.log(err)
        process.exit(1)
    } finally {
        await client.close();
    }
}

module.exports = connectDB;