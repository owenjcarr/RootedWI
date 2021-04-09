const mongoose = require('mongoose');
const dbConfig = require('./dbConfig')
const config = require('config');

const connectDB = async() => {
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
        console.log(err)
        process.exit(1)
    }
}

module.exports = connectDB;