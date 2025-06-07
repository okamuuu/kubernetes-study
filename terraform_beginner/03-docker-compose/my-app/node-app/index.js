const express = require('express');
const { Pool } = require('pg');
const Redis = require('redis');

const app = express();
const port = 3000;

const pg = new Pool();
const redis = Redis.createClient({ url: `redis://redis:6379` });
redis.connect();

app.get('/', async (req, res) => {
  const pgResult = await pg.query('SELECT NOW()');
  const redisResult = await redis.ping();
  res.send(`PostgreSQL: ${pgResult.rows[0].now}, Redis: ${redisResult}`);
});

app.listen(port, () => console.log(`Node.js app listening on port ${port}`));