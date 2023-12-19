import { Level } from 'level'

const userDataDb = new Level('./db/users', { createIfMissing: true, valueEncoding: 'json' })
const privateIdsDb = new Level('./db/privateIds', { createIfMissing: true })

export async function addUser(publicUserId, userSecret) {
  await Promise.allSettled([
    userDataDb.put(publicUserId, { name: publicUserId.substring(0, 8), registrationTimestamp: Date.now().valueOf() }),
    privateIdsDb.put(publicUserId, userSecret)
  ])
}

export async function verifyIdentify(publicUserId, userSecret) {
  const storedUserSecret = await privateIdsDb.get(publicUserId)
  return storedUserSecret === userSecret
}

export async function getUsers() {
  const usersWithKeys = await userDataDb.iterator().all()
  return usersWithKeys.map(([key, value]) => ({publicUserId: key, ...value}))
}

export async function renameUser(publicUserId, newName) {
  const user = await userDataDb.get(publicUserId)
  user.name = newName
  await userDataDb.put(publicUserId, user)
}