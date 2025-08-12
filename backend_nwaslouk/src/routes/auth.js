const express = require('express');
const bcrypt = require('bcryptjs');
const jwt = require('jsonwebtoken');

const User = require('../models/User');

const router = express.Router();
const JWT_SECRET = process.env.JWT_SECRET || 'dev_jwt_secret';
const JWT_EXPIRES_IN = process.env.JWT_EXPIRES_IN || '7d';

function signToken(user) {
  return jwt.sign({ sub: user._id, email: user.email }, JWT_SECRET, { expiresIn: JWT_EXPIRES_IN });
}

// POST /auth/sign-up
router.post('/sign-up', async (req, res) => {
  try {
    const { email, password, confirmPassword, name, phone, location, isDriver } = req.body || {};
    if (!email || !password) {
      return res.status(400).json({ message: 'Email and password are required' });
    }
    if (confirmPassword !== undefined && confirmPassword !== password) {
      return res.status(400).json({ message: 'Passwords do not match' });
    }

    const existingEmail = await User.findOne({ email: email.toLowerCase() });
    if (existingEmail) return res.status(409).json({ message: 'Email already in use' });

    if (phone) {
      const existingPhone = await User.findOne({ phone });
      if (existingPhone) return res.status(409).json({ message: 'Phone already in use' });
    }

    const passwordHash = await bcrypt.hash(password, 10);
    const user = await User.create({
      email: email.toLowerCase(),
      passwordHash,
      name: name || '',
      phone: phone || undefined,
      location: location || '',
      isDriver: Boolean(isDriver)
    });

    const token = signToken(user);
    return res.status(201).json({ token });
  } catch (err) {
    console.error('sign-up error:', err);
    return res.status(500).json({ message: 'Server error' });
  }
});

// POST /auth/sign-in
router.post('/sign-in', async (req, res) => {
  try {
    const { email, phone, password } = req.body || {};
    if ((!email && !phone) || !password) {
      return res.status(400).json({ message: 'Identifier (email or phone) and password are required' });
    }

    const query = email ? { email: String(email).toLowerCase() } : { phone: phone };
    const user = await User.findOne(query);
    if (!user) return res.status(401).json({ message: 'Invalid credentials' });

    const valid = await bcrypt.compare(password, user.passwordHash);
    if (!valid) return res.status(401).json({ message: 'Invalid credentials' });

    const token = signToken(user);
    return res.json({ token });
  } catch (err) {
    console.error('sign-in error:', err);
    return res.status(500).json({ message: 'Server error' });
  }
});

// POST /auth/logout (stateless)
router.post('/logout', async (_req, res) => {
  // With JWT stateless auth, logout is handled client-side by discarding the token.
  // Endpoint provided for symmetry and future stateful invalidation.
  return res.json({ success: true });
});

module.exports = router;