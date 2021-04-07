const mongoose = require('mongoose');
const Schema = mongoose.Schema;
const bcrypt = require('bcrypt');

// Create User Schema
const UserSchema = new Schema({
    name: {
        type: String,
        require: true
    },
    email: {
        type: String,
        require: true,
        unique: true
    },
    password: {
        type: String,
        require: true
    },


});

// hash password when saved
UserSchema.pre(
    'save',
    async function(next) {
      const user = this;
      const hash = await bcrypt.hash(this.password, 10);
  
      this.password = hash;
      next();
    }
  );

// valids password on login
UserSchema.methods.isValidPassword = async function(password) {
const user = this;
const compare = await bcrypt.compare(password, user.password);

return compare;
}

module.exports = User = mongoose.model('user', UserSchema);

