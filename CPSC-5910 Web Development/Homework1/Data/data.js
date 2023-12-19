/**
 * data.js file contains all the objects for storing data in memory
 */

/**
 * formulas object contains ID, inputs{resource:asd, quantity:12}, outputs{resource:asd, quantity:12} 
 * there are some handler functions listed below
 * 1. add_Formula = add a new formula and return that formula back
 * 2. get_Formula = returns a specific formula detail
 * 3. getall_formula = returns all the formulas in the object.
 * 4. isFormula_Exist() = return true of false if the formula is ther in object
 * * * sample formula data * * *
1: {
        "inputs": [
            { "resource": "iron ore", "quantity": 2 },
            { "resource": "coal", "quantity": 1 }
        ],
        "outputs": [
            { "resource": "iron bar", "quantity": 1 }
        ]
    },
    2: {
        "inputs": [
            { "resource": "wood", "quantity": 3 },
            { "resource": "stone", "quantity": 2 }
        ],
        "outputs": [
            { "resource": "furniture", "quantity": 1 }
        ]
    },
    3: {
        "inputs": [
            { "resource": "butter", "quantity": 2 },
            { "resource": "egg", "quantity": 3 },
            { "resource": "sugar", "quantity": 1 },
            { "resource": "flour", "quantity": 2 },
            { "resource": "baking soda", "quantity": 2 }
        ],
        "outputs": [
            { "resource": "cookies", "quantity": 36 }
        ]
    }
 */
const formulas = {};

function add_Formula(ID, data){
    formulas[ID] = data;
    return formulas[ID];
}

function get_Formula(ID){
    return formulas[ID];
}

function getall_Formula(){
    return formulas
}

function isFormula_Exist(ID){
    if (formulas[ID])
        return true
    else
        return false
}

/**
 * plans object contains id, name and array of formula ID's
 * below are some handler function used for operations
 * 1. get_Plan() = return detail of a plan
 * 2. getall_Plan() = return details of all plans
 * 3. add_Plan() = adds and return new plan
 * 4. appendFormula() = adds formula to a plan at the end of all formula
 * 5. list_Formulas() = returns the list of all the formulas in a plan
 * 6. update_Formulas_Plan() = update the formula in a plan and return detail of plan
 * 7. delete_Plan() = removes a plan from the plans object.
 * 8. isplan_Exist() = check if a plan already exist in system
 * 9. search_Plan_From_Formula() = search and return a list of ID's which has specific formula in them
 * * * sample plan data * * *
     1:  {
        "formulas": [1,3]
    },
    2:  {
        "formulas": [2]
    },
    3:  {
        "formulas": [3]
    }
 */
const plans = {};

function get_Plan(PID){
    return plans[PID]
}
function getall_Plan(){
    return plans
}

function add_Plan(ID, data){
    plans[ID] = data;
    return plans[ID];
}

function appendFormula(PID, FID){
    plans[PID].formulas.push(FID);
    return plans[PID];
}

function list_Formulas(PID){
    return plans[PID].formulas;
}

function update_Formulas_Plan(PID, FID, new_Formula){
    const formulalist = list_Formulas(PID)

    for (i = 0; i < existing_formulas.length; i++)
    {
        if (formulalist[i] == FID)
                formulalist[i] = new_Formula
    }
    plans[PID].formulas = formulalist
    return get_Plan(PID)
}

function delete_Plan(PID){
    plan_detail = plans[PID];
    plans[PID].delete;
    return plan_detail;
}

function isplan_Exist(ID){
    if (plans[ID])
        return true
    else
        return false
}

function search_Plan_From_Formula(FID){

    const PlanIds = [];
    for (const planId in plans){
        if (plans[planId].formulas.includes(FID)){
            PlanIds.push(planId);
        }
    }
    return PlanIds
}

module.exports = {add_Formula, get_Formula, 
    getall_Formula, add_Plan, getall_Plan,
    add_Plan, appendFormula, isplan_Exist, 
    delete_Plan, list_Formulas, isFormula_Exist,
    update_Formulas_Plan, get_Plan,search_Plan_From_Formula
    };
