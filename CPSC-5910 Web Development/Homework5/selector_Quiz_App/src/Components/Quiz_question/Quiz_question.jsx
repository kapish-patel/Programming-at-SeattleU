import './Quiz_question.css'
import { useDispatch, useSelector } from 'react-redux';
import {setSelector} from '../../slices/SelectorSlice';

function Quiz_question() {
    const question = useSelector((state) => state.QuestionSlice.question);
    const dispatch = useDispatch();

    const handleElementClick = (element) => {
        dispatch(setSelector(element))
    };

    return (
        <div className="Quiz_question_component">
            {question.map((element, index) => (
                <p className='question_elements' key={index} onClick={() => handleElementClick(element)}>
                    {element}
                </p>
            ))}
        </div>
    );
}

export default Quiz_question;
