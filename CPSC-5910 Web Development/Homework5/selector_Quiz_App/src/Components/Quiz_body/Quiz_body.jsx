import './Quiz_body.css'
import Quiz_explaination from '../Quiz_explaination/Quiz_explaination'
import Quiz from '../Quiz/Quiz'

function Quiz_body(){
    return(
        <div className="Quiz_body_container">
            <Quiz></Quiz>
            <Quiz_explaination></Quiz_explaination>
        </div>
    )
}

export default Quiz_body