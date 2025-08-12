const mongoose = require('mongoose');

const MONGO_URI = process.env.MONGO_URI || 'mongodb://localhost:27017/nwasloukDB';

async function connectDb() {
  mongoose.set('strictQuery', true);
  await mongoose.connect(MONGO_URI);
  console.log('Connected to MongoDB:', MONGO_URI);
}

module.exports = { connectDb };