const express = require('express');
const router = express.Router();
const bcrypt = require('bcryptjs');
const config = require('config');
const jwt = require('jsonwebtoken');
const auth = require('../../middleware/auth');

// User Model
const User = require('../../models/User');

// @route POST api/auth
// @desc Auth user
// @access Public
router.post('/', (req,res) => {
    const { email, password } = req.body;

    // Simple validation
    if(!email || !password) {
        return res.status(400).json({msg: 'Please enter all fields'});
    }

    // Check for existing user
    User.findOne({email}) 
        .then(user => {
            if(!user) return res.status(400).json({msg: 'User doesn\'t exist'});
            
            // validate password
            bcrypt.compare(password, user.password)
                .then(isMatch => {
                    if(!isMatch) return res.status(400).json({msg: 'invalid credentials'});

                    jwt.sign(
                        { id: user.id, name: user.name },
                        config.get('jwtSecret'),
                        { expiresIn: 60 }, // expiration time
                        (err, token) => {
                            if(err) throw err;
                            res.json({
                                token,
                                user: {
                                    id: user.id,
                                    name: user.name,
                                    email: user.email
                                }
                            });
                        }
                    );
                })
        });
    });

// @route GET api/auth/user
// @desc Get user data
// @access Private

router.get('/user',auth, (req, res) => {
    User.findById(req.user.id)
        .select('-password')
        .then(user => res.json(user));
})
module.exports = router;

