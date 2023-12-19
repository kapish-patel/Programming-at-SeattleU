
const FAILURE_CHANCE = process.env.FAILURE_CHANCE || 0.1

export default function chaosMiddleware() {
    return (req, res, next) => {
        if(Math.random() < FAILURE_CHANCE) {
            res.status(500).end()
        } else {
            next()
        }
    }
}