import './Quiz_wrapper.css';
import Quiz_header from '../Quiz_header/Quiz_header';
import Quiz_body from '../Quiz_body/Quiz_body';

function Quiz_wrapper(){
    return(
        <div className="Quiz_wrapper_container">
            <Quiz_header></Quiz_header>
            <Quiz_body></Quiz_body>
        </div>

    )
}
export default Quiz_wrapper