import { Router } from 'express'
import { StatusCodes } from 'http-status-codes'
import { addMessage, getChats } from '../models/chats.mjs'
import {addRoom, getRoom, getRooms} from '../models/rooms.mjs'

const router = Router()

router.post('/', async (req, res) => {
  const { name, description } = req.body
  const existingRoom = await getRoom(name)
  if(existingRoom) {
    res.status(StatusCodes.CONFLICT).end()
  } else {
    await addRoom(name, {description})
    res.status(201).end()
  }
})

router.get('/', async (req, res) => {
  const rooms = await getRooms()
  res.send(rooms)
})

router.get('/:roomId', async (req, res) => {
  const { roomId } = req.params
  const room = await getRoom(roomId)
  if(room) {
    res.send(room)
  } else {
    res.status(StatusCodes.NOT_FOUND).end()
  }
})

router.post('/:roomId/chats', async (req, res) => {
  const { roomId } = req.params
  const messageText = req.body
  const timestamp = await addMessage(roomId, { posterId: req.auth.publicUserId, messageText })
  res.status(201).send(timestamp)
})

router.get('/:roomId/chats', async (req, res) => {
  const { roomId } = req.params
  console.log({ roomId });
  const messages = await getChats(roomId)
  res.send(messages)
})

export default router