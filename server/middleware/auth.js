const config = require('config');
const jwt = require('jsonwebtoken');

// use as a parameter in private routes

function auth(req, res, next) {
    const token = req.header('x-auth-token');

    // check for token
    if(!token) {
        res.status(401).json({msg: 'auth denied'});
    }

    try {
        // verify token
        const decoded = jwt.verify(token, config.get('jwtSecret'));
        // Add user from payload
        req.user = decoded;
        next();
    } catch(e) {
        res.status(400).json({msg: 'token is not valid'});
    }
}

module.exports = auth;