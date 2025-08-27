const express = require('express');
const jwt = require('jsonwebtoken');
const bcrypt = require('bcryptjs');
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
    // Align keys to mobile app domain expectations
    return res.json({
      id: String(user._id),
      name: user.name || '',
      phone: user.phone || '',
      rating: 5.0, // default rating until ratings implemented
      is_driver: Boolean(user.isDriver),
    });
  } catch (err) {
    console.error('profile error:', err);
    return res.status(500).json({ message: 'Server error' });
  }
});

// PATCH /profile - update profile fields
router.patch('/', requireAuth, async (req, res) => {
  try {
    const { name, phone, location, isDriver, email } = req.body || {};
    const updates = {};
    if (name !== undefined) updates.name = String(name);
    if (phone !== undefined) updates.phone = String(phone);
    if (location !== undefined) updates.location = String(location);
    if (isDriver !== undefined) updates.isDriver = Boolean(isDriver);
    if (email !== undefined) updates.email = String(email).toLowerCase();

    // uniqueness checks
    if (updates.email) {
      const existingEmail = await User.findOne({ email: updates.email, _id: { $ne: req.user.id } });
      if (existingEmail) return res.status(409).json({ message: 'Email already in use' });
    }
    if (updates.phone) {
      const existingPhone = await User.findOne({ phone: updates.phone, _id: { $ne: req.user.id } });
      if (existingPhone) return res.status(409).json({ message: 'Phone already in use' });
    }

    const user = await User.findByIdAndUpdate(req.user.id, updates, { new: true }).lean();
    if (!user) return res.status(404).json({ message: 'User not found' });

    return res.json({
      id: String(user._id),
      name: user.name || '',
      phone: user.phone || '',
      rating: 5.0,
      is_driver: Boolean(user.isDriver),
    });
  } catch (err) {
    console.error('update profile error:', err);
    return res.status(500).json({ message: 'Server error' });
  }
});

// PATCH /profile/password - change password
router.patch('/password', requireAuth, async (req, res) => {
  try {
    const { currentPassword, newPassword } = req.body || {};
    if (!currentPassword || !newPassword) {
      return res.status(400).json({ message: 'currentPassword and newPassword are required' });
    }

    const user = await User.findById(req.user.id);
    if (!user) return res.status(404).json({ message: 'User not found' });

    const valid = await bcrypt.compare(String(currentPassword), user.passwordHash);
    if (!valid) return res.status(401).json({ message: 'Current password is incorrect' });

    user.passwordHash = await bcrypt.hash(String(newPassword), 10);
    await user.save();
    return res.json({ success: true });
  } catch (err) {
    console.error('change password error:', err);
    return res.status(500).json({ message: 'Server error' });
  }
});

module.exports = router;

