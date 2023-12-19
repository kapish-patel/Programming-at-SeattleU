// Import mongoose module
const mongoose = require('mongoose');

class dbConnection {
    static mongooseInstance;
    static mongooseConnection;
    static DB_CONNECTION_STRING = 'mongodb://localhost:27017/Homework2';
    
    static connect(){

        //if the instance exist return it
        if (this.mongooseInstance) return this.mongooseInstance;

        this.mongooseConnection = mongoose.connection;

        this.mongooseConnection.on("open", () => {
            console.log("Connected to MongoDB");
        });

        this.mongooseInstance = mongoose.connect(this.DB_CONNECTION_STRING);
        return this.mongooseInstance;

    }
}

module.exports = dbConnection;