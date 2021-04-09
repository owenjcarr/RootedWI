const express = require('express');
const connectDB = require('./config/db');

connectDB()

const app = express();

// bodyparser middleware
app.use(express.json());

// use routes
app.use('/api/users', require ('./routes/api/users'));
app.use('/api/auth', require ('./routes/api/auth'));

const PORT = process.env.PORT || 8000;

app.listen(PORT, console.log(`Server running in ${process.env.NODE_ENV} mode on port ${PORT}`));