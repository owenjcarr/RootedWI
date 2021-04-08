const express = require('express');
const connectDB = require('./config/db');

connectDB()

const app = express();

// bodyparser middleware
app.use(express.json());

app.post(
    '/test',
    (req, res) => res.json(req.body)
  );

// use routes
app.use('/api/users', require ('./routes/api/users'));

const PORT = process.env.PORT || 8000;

app.listen(PORT, console.log(`Server running in ${process.env.NODE_ENV} mode on port ${PORT}`));