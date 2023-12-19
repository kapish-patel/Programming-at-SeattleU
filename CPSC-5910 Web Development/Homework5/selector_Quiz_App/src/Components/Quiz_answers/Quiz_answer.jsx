import './Quiz_answer.css'
import {useSelector} from 'react-redux'
import { useState, useEffect } from 'react';

function Quiz_answer(){

    const [classIdInput, setClassIdInput] = useState('');
    const [tagInput, setTagInput] = useState('');
    const [pseudoInput, setPseudoInput] = useState('');

    const answers = useSelector((state) => state.QuestionSlice.answers)
    console.log(answers)
    const checkAnswer = (userInput, correctanswer) => {
        return parseInt(userInput) === parseInt(correctanswer)
    }

    useEffect(() => {
        // Reset input values and border colors when answers change
        setClassIdInput('');
        setTagInput('');
        setPseudoInput('');

        document.querySelectorAll('.Quiz_answer_container input').forEach((input) => {
            input.style.border = '2px solid blue';
          });

    }, [answers]);
    return (
        <div className="Quiz_answer_container">
            <div className="class-id_Input_container">
                <label>Id selector</label>
                <input type="number"  value={classIdInput} onChange={(e) => setClassIdInput(e.target.value)}
                style={{
                    border: checkAnswer(classIdInput, answers[0])
                      ? '2px solid green'
                      : '2px solid red',
                  }}
                />
            </div>
            
            <div className="tag-input_container">
                <label>Class + PsuedoClass</label>
                <input type="number"  value={tagInput} onChange={(e) => setTagInput(e.target.value)}
                style={{
                    border: checkAnswer(tagInput, answers[1])
                      ? '2px solid green'
                      : '2px solid red',
                  }}
                />
            </div>
            
            <div className="psuedo-class-element_input_container">
                <label>Tag + PsuedoElement</label>
                <input type="number"  value={pseudoInput} onChange={(e) => setPseudoInput(e.target.value)}
                style={{
                    border: checkAnswer(pseudoInput, answers[2])
                      ? '2px solid green'
                      : '2px solid red',
                  }}
                />
            </div>    
        </div>
    )
}

export default Quiz_answer