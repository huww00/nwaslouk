const express = require('express');
const jwt = require('jsonwebtoken');
const User = require('../models/User');

const router = express.Router();
const JWT_SECRET = process.env.JWT_SECRET || 'dev_jwt_secret';

async function requireAuth(req, res, next) {
  try {
    const authHeader = req.headers['authorization'] || '';
    const parts = authHeader.split(' ');
    if (parts.length !== 2 || parts[0] !== 'Bearer') {
      return res.status(401).json({ message: 'Missing or invalid Authorization header' });
    }
    const token = parts[1];
    const payload = jwt.verify(token, JWT_SECRET);
    req.user = { id: payload.sub, email: payload.email };
    next();
  } catch (err) {
    return res.status(401).json({ message: 'Invalid or expired token' });
  }
}

router.get('/', requireAuth, async (req, res) => {
  try {
    const user = await User.findById(req.user.id).lean();
    if (!user) return res.status(404).json({ message: 'User not found' });
    return res.json({
      id: String(user._id),
      name: user.name || '',
      email: user.email,
      phone: user.phone || '',
      location: user.location || '',
      isDriver: Boolean(user.isDriver),
    });
  } catch (err) {
    console.error('profile error:', err);
    return res.status(500).json({ message: 'Server error' });
  }
});

module.exports = router;

