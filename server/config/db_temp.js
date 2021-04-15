const dbConfig = require('./dbConfig')
const config = require('config');
const {MongoClient} = require('mongodb');

const connectDB_temp = async (f) => {
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

module.exports = connectDB_temp;