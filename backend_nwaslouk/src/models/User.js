const mongoose = require('mongoose');

const UserSchema = new mongoose.Schema(
  {
    name: { type: String, trim: true },
    email: { type: String, required: true, unique: true, lowercase: true, index: true },
    phone: { type: String, unique: true, sparse: true },
    passwordHash: { type: String, required: false }, // Optional for Google auth users
    googleId: { type: String, unique: true, sparse: true }, // Google OAuth ID
    authProvider: { type: String, enum: ['local', 'google'], default: 'local' }, // Authentication method
    location: { type: String },
    isDriver: { type: Boolean, default: false }
  },
  { timestamps: true }
);

module.exports = mongoose.model('User', UserSchema);