import {addUser, verifyIdentify} from '../models/users.mjs'
import {randomUUID} from 'crypto'

const baseCookieOptions = {
  sameSite: 'strict',
  expires: new Date(Date.now() + 1000 * 60 * 60 * 24 * 365),
}

export default function authMiddleware() {
  return async function (req, res, next) {
    let { userSecret } = req.signedCookies
    let { publicUserId } = req.cookies
    if(userSecret && publicUserId) {
      if(!await verifyIdentify(publicUserId, userSecret)) {
        res.clearCookie('userSecret')
        res.clearCookie('publicUserId')
        res.status(401).end()
        return
      }
    } else {
      publicUserId = randomUUID()
      userSecret = randomUUID()
      await addUser(publicUserId, userSecret)
      res.cookie('publicUserId', publicUserId, baseCookieOptions)
      res.cookie('userSecret', userSecret, { ...baseCookieOptions, signed: true })
    }
    req.auth = { userSecret, publicUserId }
    next()
  }
}