import './Quiz_explaination.css'
import {useSelector} from 'react-redux'

function Quiz_explaination(){

    const selector_data = useSelector((state)=> state.SelectorSlice)
    console.log(selector_data)
    return(
        <div className="Quiz_explaination_container">
            <div className="example_head_container">
                <h1>this is {selector_data.selectordata.type} Selector</h1>
            </div>
            <div className="example_explaination_caontainer">
                <p>Example: {selector_data.selectordata.Syntax}</p>
                <p>You have selected: {selector_data.selectedSelector}</p>
                <p>{selector_data.selectordata.Explainations}</p>
                <a href={selector_data.selectordata.link}>Readmore</a>
            </div>
        </div>
    )
}

export default Quiz_explaination