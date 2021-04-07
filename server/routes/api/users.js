const express = require('express');
const router = express.Router();
const bcrypt = require('bcryptjs');

// User Model
const User = require('../../models/User');

// @route POST api/users
// @desc Resgister new user
// @access Public
router.post('/', (req,res) => {
    const { name, email, password } = res.body;

    // Simple validation
    if(!name || !email || !password) {
        return res.status(400).json({msg: 'Please enter all fields'});
    }

    User.findOne({email}) 
        .then(user => {
            if(user) return res.status(400).json({msg: 'User already exists'});

            const newUser = new User({
                name,
                email,
                password
            });
            
            //Create salt & hash
            bcrypt.getSalt(10, (err, salt) => {
                bcrypt.hash(newUser.password, salt, (err,hash) => {
                    if(err) throw err;
                    newUser.password = hash;
                    newUser.save() 
                        .then(user => {
                            res.json({
                                user: {
                                    id: user.id,
                                    name: user.name,
                                    email: user.email
                                }
                            });
                        });
                });
            });
        });
});

module.exports = router;

