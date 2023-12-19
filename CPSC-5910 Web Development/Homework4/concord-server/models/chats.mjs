import { Level } from 'level'

const chatDataDb = new Level('./db/chats', { createIfMissing: true, valueEncoding: 'json' })

const sublevel = name => chatDataDb.sublevel(name, { valueEncoding: 'json' })

export async function getChats(roomName) {
  const roomSublevel = sublevel(encodeURI(roomName))
  const messages = await roomSublevel.iterator({ reverse: true }).all()
  return messages.map(([timestamp, value]) => ({ timestamp, ...value }))
}

export async function addMessage(roomName, message) {
  const roomSublevel = sublevel(encodeURI(roomName))
  const timestamp = Date.now().valueOf().toString()
  await roomSublevel.put(timestamp, message)
  return timestamp
}