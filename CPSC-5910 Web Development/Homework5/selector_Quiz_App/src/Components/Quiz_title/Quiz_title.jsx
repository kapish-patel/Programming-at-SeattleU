import './Quiz_title.css';
import { useDispatch } from 'react-redux';
import { fetchNewQuestion } from '../../slices/QuestionsSlice'; // Assuming you have an action for fetching a new question

function Quiz_title() {
  const dispatch = useDispatch();

  const handleFetchNewQuestion = () => {
    dispatch(fetchNewQuestion());
  };

  return (
    <div className="Quiz_title_component">
      <p>Guess the Specificity of the below statement</p>
      <button id='randombtn' onClick={handleFetchNewQuestion}>Random Question</button>
    </div>
  );
}

export default Quiz_title;
