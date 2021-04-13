const mongoose = require('mongoose');
const dbConfig = require('./dbConfig')
const config = require('config');
// const {MongoClient} = require('mongodb');

const connectDB = async (f) => {
    const client = new MongoClient(dbConfig.database, {
        useNewUrlParser: true,
        useUnifiedTopology: true,
        useFindAndModify: false,
    });
    try {
        const conn = await mongoose.connect(config.get('database'), {
            useNewUrlParser: true,
            useUnifiedTopology: true,
            useFindAndModify: false,
            useCreateIndex: true

        })
        console.log(`MongoDB Connected: ${conn.connection.host}`)
    }
    catch (err) {
//         await client.connect();
//         console.log(`MongoDB Connected`)
//         return await f(client);
//     } catch (err) {
        console.log(err)
        process.exit(1)
    } finally {
        await client.close();
    }
}

module.exports = connectDB;