import './Quiz.css'
import Quiz_title from '../Quiz_title/Quiz_title'
import Quiz_question from '../Quiz_question/Quiz_question'
import Quiz_answer from '../Quiz_answers/Quiz_answer'

function Quiz(){
    return (
        <div className="Quiz_container">
            <Quiz_title></Quiz_title>
            <Quiz_question></Quiz_question>
            <Quiz_answer></Quiz_answer>
        </div>
    )
}

export default Quiz