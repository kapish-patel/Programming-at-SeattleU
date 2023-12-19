import { Level } from 'level'

const roomDataDb = new Level('./db/rooms', { createIfMissing: true, valueEncoding: 'json' })

export async function getRooms() {
  const roomsWithKeys = await roomDataDb.iterator().all()
  return roomsWithKeys.map(([name, value]) => ({ name, ...value }))
}

export async function getRoom(roomName) {
  try {
    return await roomDataDb.get(roomName)
  } catch(e) {
    if(e.code === 'LEVEL_NOT_FOUND') {
      return null
    }
    // We only know how to deal with not found errors, so rethrow anything else
    throw e
  }
}

export async function addRoom(roomName, roomDetails) {
  await roomDataDb.put(roomName, roomDetails)
}