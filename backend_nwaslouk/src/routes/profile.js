const express = require('express');
const User = require('../models/User');
const { authMiddleware } = require('../middleware/auth');

const router = express.Router();

router.use(authMiddleware);

// GET /profile
router.get('/', async (req, res) => {
  try {
    const user = await User.findById(req.userId).lean();
    if (!user) return res.status(404).json({ message: 'Not found' });
    // Map to app domain (mock rating and isDriver from user)
    const profile = {
      id: String(user._id),
      name: user.name || '',
      phone: user.phone || '',
      rating: 4.5,
      is_driver: Boolean(user.isDriver),
    };
    return res.json(profile);
  } catch (err) {
    console.error('get profile error:', err);
    return res.status(500).json({ message: 'Server error' });
  }
});

// PATCH /profile
router.patch('/', async (req, res) => {
  try {
    const { name, phone } = req.body || {};
    const update = {};
    if (name !== undefined) update.name = String(name);
    if (phone !== undefined) update.phone = String(phone);

    if (update.phone) {
      const exists = await User.findOne({ phone: update.phone, _id: { $ne: req.userId } });
      if (exists) return res.status(409).json({ message: 'Phone already in use' });
    }

    const user = await User.findByIdAndUpdate(req.userId, { $set: update }, { new: true });
    if (!user) return res.status(404).json({ message: 'Not found' });
    const profile = {
      id: String(user._id),
      name: user.name || '',
      phone: user.phone || '',
      rating: 4.5,
      is_driver: Boolean(user.isDriver),
    };
    return res.json(profile);
  } catch (err) {
    console.error('update profile error:', err);
    return res.status(500).json({ message: 'Server error' });
  }
});

module.exports = router;