const express = require('express');
const connectDB = require('./config/db');

connectDB()

const app = express();

// bodyparser middleware
app.use(express.json());

// use routes
app.use('/api/users', require ('./routes/api/users'));
app.use('/api/auth', require ('./routes/api/auth'));
app.use('/api/produce', require('./routes/api/produce'));
app.use('/api/balance', require('./routes/api/balance'));

app.use((req, res, next) => {
    res.status(404);
    console.log(req.url);
    // respond with html page
    if (req.accepts('html')) {
        console.log('html');
        console.log(JSON.stringify(req.headers));
        res.json({ error: `${req.url} not found` });
        return;
    }

    // respond with json
    if (req.accepts('json')) {
        console.log('json');
        res.json({ error: `${req.url} not found` });
        return;
    }

    // default to plain-text. send()
    res.type('txt').send('Not found');
});


app.get('/', (req,res) => {
    res.send('Hello World');
})

const PORT = process.env.PORT || 8000;

app.listen(PORT, console.log(`Server running in ${process.env.NODE_ENV} mode on port ${PORT}`));