import express from 'express'
import cookieParser from 'cookie-parser'
import logger from 'morgan'
import dotenv from 'dotenv'
import bodyParser from 'body-parser'

import authMiddleware from './middleware/auth.mjs'
import usersRouter from './routes/users.mjs'
import accountRouter from './routes/account.mjs'
import chatsRouter from './routes/rooms.mjs'
import chaosMiddleware from './middleware/chaos.mjs'

dotenv.config()

const app = express()

app.use(logger('dev'))
app.use(bodyParser.text())
app.use(express.json())
app.use(express.urlencoded({ extended: false }))
app.use(cookieParser(process.env.COOKIE_SECRET))
app.use(authMiddleware())
app.use(chaosMiddleware())

app.get('/', (req, res) => {
  res.send('<html></html>')
})

app.use('/users', usersRouter)
app.use('/account', accountRouter)
app.use('/rooms', chatsRouter)

export default app
