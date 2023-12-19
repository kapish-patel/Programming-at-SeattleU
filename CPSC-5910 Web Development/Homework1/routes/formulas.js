/**
 * formulas.js file servs all the API related to formulas
 */
var express = require('express');
var router = express.Router();
var data = require('../Data/data')

var COUNTER = 0

/* POST add a new formula
 * POST /formula
 * Body: A json object containing input resources with quantity and output resources with quantity.
 * Return: A json object containing newly added formula. 
 */
router.post('/', (req, res) => {
    //process data from body
    const { inputs, outputs } = req.body;

    // call add function in data file 
    returnFormula = data.add_Formula(COUNTER, {inputs, outputs});

    res.status(200).json({Success:returnFormula});
    COUNTER++;
});

/* GET return inputs and outputs of a specific formula.
 * GET /formulas/:fid/details
 * Body: -
 * Return: A json objetct containing formula details.
 * */
router.get('/:fid/details', (req, res) => {

    const fid = req.params.fid;
    
    // Validate ID
        //check if this id is number 
    if (isNaN(fid))
        return res.status(400).json({error:"Invalid ID:"});

    formulaDetail = data.get_Formula(fid);
    res.status(200).json({"Inputs and Outputs":formulaDetail});
});
  
module.exports = router;


/**
 * expected body from POST request
 * 1: {
    inputs: [
        { resource: "iron ore", quantity: 2 },
        { resource: "coal", quantity: 1 }
    ],
    outputs: [
        { resource: "iron bar", quantity: 1 }
    ]
}
*/