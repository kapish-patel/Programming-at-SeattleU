import { Router } from 'express'
import { getUsers } from '../models/users.mjs'

const router = Router()

/* GET users listing. */
router.get('/', async (req, res, next) => {
  const users = await getUsers()
  res.send(users)
});

export default router
