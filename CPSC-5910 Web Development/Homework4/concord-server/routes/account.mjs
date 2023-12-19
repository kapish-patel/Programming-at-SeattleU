import { Router } from 'express'
import { renameUser } from '../models/users.mjs'

const router = Router()

router.put('/name', async (req, res) => {
  const newName = req.body
  const { publicUserId } = req.auth
  await renameUser(publicUserId, newName)
  res.status(200).end()
})

export default router