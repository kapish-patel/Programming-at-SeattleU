var express = require('express');
var router = express.Router();
const document = require('../models/documentModel');

/* GET home page.
 * GET /
 * Body: -
 * Return: A json object containing all the objects of document collection. 
 */
router.get('/',(req, res) => {
  document.getall_Documents()
    .then(all_Items => {
      //console.log(`Got ${all_Items} from Document Model`);
      res.render('index',{all_Items});
    })
});

/**
 * GET postdocument page
 * GET /document
 * Body: -
 * Return: A html page with a form.
 */
router.get('/documents', (req, res) => {
  res.render('postDocument');
})

/** GET updatedocument page
 * GET /document/update
 * Body: -
 * Return: a ejs file with data and form.
 */
router.get('/document/:DID/modify', (req, res) => {
  const doc_ID = req.params.DID;
  document.get_Document(doc_ID)
    .then((item) => {
      res.render('edit', {item});
    });
})

/**
 * POST submit data from html form to database
 * POST /document
 * Body: a object containing data related to new document generated
 * Return: Redirect to home page after a posting new document 
 */
router.post('/document', (req, res) => {
    document.add_Document(req)
      .then(data => {
        res.redirect('/');
      })
})


/* GET document page
 * GET /documents/:DID
 * Body: -
 * Return: A json object containing just one object of a document collection.
 */
router.get('/document/:DID', (req, res) => {
  const doc_ID = req.params.DID; 
  //add validation here
  document.get_Document(doc_ID)
    .then(item => {
      //console.log(`got ${item} from Document Model`)
      res.render('document',{ item });
    });
})

/** DELETE a specific document with a document id
 * DELETE /documents/:DID
 * Body: -
 * Return: redirect to home page after deleting the document
 */
router.delete('/document/:DID', (req, res) => {
  const doc_Id = req.params.DID;
  const result = document.removeDocument(doc_Id);
  res.status(200).json(result);
})


/**
 * PUT update data of specific document
 * PUT /document/:DID
 * Body: -
 * Return: redirect to home page after updating the document
 */
router.put('/document/:DID', (req, res) => {
  console.log(req.body);
  const result = document.updateDocument(req);
  res.status(200).json(result);
})

module.exports = router;
