const mongoose = require('mongoose');
const dbconnection = require('../connection');

let connection = dbconnection.connect();

const docuschema = new mongoose.Schema({
    title:{type: String},
    description:{type:String},
    last_Update:{type:Date}
});

console.log("Created document schema");
const documentModel =  dbconnection.mongooseConnection.model('Documents', docuschema);

// function to return all the documents
async function getall_Documents(){
    const allItems = await documentModel.find().exec();
    return allItems;
};

// function to return a specific document
async function get_Document(DID){
    const filter = {_id:DID}
    const item = await documentModel.findOne(filter).exec();
    return item;
}

//function to add new document in documents collection and return it
async function add_Document(req){
    const {title, description} = req.body;
    const UTC_date = get_Date();

    const new_Document = new documentModel({
        title: title,
        description: description,
        last_Update: UTC_date
    });
    const newdoc = await new_Document.save();
    return newdoc;
}

async function removeDocument(doc_ID){
    await documentModel.deleteOne({_id: doc_ID});
    return {success: "The document successfully deleted"}
}

async function updateDocument(req){
    const doc_ID = req.params.DID;
    const new_title = req.body.title;
    const new_description = req.body.description;
    const UTC_date = get_Date();

    const filter = {_id: doc_ID}
    const update = {title: new_title, description: new_description, last_Update: UTC_date }
    
    const updaterecord = await documentModel.findOneAndUpdate(filter, update);
    
    
    return updaterecord;
}

function get_Date(){
    return new Date().toUTCString();
}

module.exports = {getall_Documents, get_Document, add_Document, removeDocument, updateDocument};