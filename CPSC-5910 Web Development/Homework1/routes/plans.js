/**
 * plans.js file serves all the router and API related to plans. 
 */
var express = require('express');
var router = express.Router();
var data = require('../Data/data')

var COUNTER = 0

/**
 * POST add new plan
 * POST /plan
 * Body: A json object containing list of formulas.
 * Return: A json object containing details of plan.
 */  
router.post('/', (req, res) => {
    const plandetail = req.body;
    newplan = data.add_Plan(COUNTER, plandetail);
    res.status(200).json({"Successfully added new plan":newplan});
    COUNTER++;
});

/* 
 * GET List which plans contain a specific formula.
 * GET /plan/formula/:fid
 * Body: - 
 * Return: A json object containing list of plans detail.
 */
router.get('/formula/:fid', (req, res) => {
    const fid = req.params.fid;
    //Validate ID
        //check if the id is number 
    if (isNaN(fid))
        return res.status(400).json({error:"Invalid ID"})
    
        //check if the id is present in formula
    if (!data.isFormula_Exist(fid))
        return res.status(400).json({error:"Formula does not exist"})

    listOf_Plans = data.search_Plan_From_Formula(fid);
    res.status(200).json({"List of plans:": listOf_Plans});
});

/* POST append a formula to end of a plan.
 * POST /plan/:pid/add_Formula
 * Body: A json object containing formula ID to be added to end of list.
 * Return: A json object containing updated plan details.
*/
router.post('/:pid/add_Formula', (req, res) => {
    const pid = req.params.pid;
    const fid = req.body.formula;

    //Validate PID
        //check if the id is number
    if (isNaN(pid))
        return res.status(400).json({error:"Invalid ID"});
    
        //check if the id is present in plan
    if (!data.isplan_Exist(pid))
        return res.status(400).json({error:"Plan does not exist"});
    else{
        new_Plan = data.appendFormula(pid,fid);
        res.status(200).json({success:new_Plan});
    }
});

/* PUT Replace a formula anywhere in the sequence of formulas associated with a plan. 
 * PUT /plan/:pid/formula/:fid
 * Body: A json object containing formula ID to be updated.
 * Return: A json object with update plan and formula list.
 * */
router.put('/:pid/formula/:fid',(req, res) => {
    const pid = req.params.pid;
    const fid = req.params.fid;

    //Validate PID
        //check if the id is number
    if (isNaN(pid))
        return res.status(400).json({error:"Invalid ID"});
    
        //check if the id is present in plan
    if (!data.isplan_Exist(pid))
        return res.status(400).json({error:"Plan does not exist"});

        //check if the fid is valid
    if (isNaN(fid))
        return res.status(400).json({error:"Invalid ID"});
    
        //check if the id is present in plan
    if (!data.isFormula_Exist(fid))
        return res.status(400).json({error:"Formula does not exist"});

    const updateformula = req.body.formula;
    
    plan_data = data.update_Formulas_Plan(pid, fid, updateformula)
        
    res.status(200).json({success:plan_data});
});

/* GET list of formulas containing in a plan. 
 * GET /plan/:pid/formulas
 * Body: - 
 * Return: A json object containing details of all the formulas in that plan.
 * */
router.get('/:pid/formulas', (req, res) => {
    const pid = req.params.pid;

    //Validate ID
        //check if the id is number 
    if (isNaN(pid))
        return res.status(400).json({error:"Invalid ID"})
    
        //check if the id is present in plan
    if (!data.isplan_Exist(pid))
        return res.status(400).json({error:"Plan does not exist"})
    else  
    {
        // fetch the formulas from plans object
        const formulas = data.list_Formulas(pid);
        const formulalist = {}

        console.log(formulas);
        // add the details of formulas from formulas object
        for( let i = 0; i < formulas.length; i++)
            formulalist[i] = data.get_Formula(formulas[i]);
        res.status(200).json(formulalist);
    }
});

/* DELETE Delete a plan 
 * DELETE /plan/:pid
 * Body: - 
 * Return: A json object containing recently deleted plan.
 * */
router.delete('/:pid', (req, res) => {
    const pid = req.params.pid;
    //Validate ID
        //check if the id is number
    if (isNaN(pid))
        return res.status(400).json({error:"Invalid ID"});
    
        //check if the id is present in plan
    if (!data.isplan_Exist(pid))
        return res.status(400).json({error:"Plan does not exist"});

    deleted_plan = data.delete_Plan(pid);
    res.status(200).json({"Successfully deleted this plan":deleted_plan});
});
module.exports = router;