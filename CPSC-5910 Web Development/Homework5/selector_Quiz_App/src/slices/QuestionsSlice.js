import { createSlice } from '@reduxjs/toolkit';
import { generateSelector } from '../Generators/selectorGenerator';

function is_ID(word){
  if(word[0] == '#')
    return true
  else 
    return false
}

function isClass(word){
  const pseudoClasses = [
    ':first-child',
    ':last-child',
    ':nth-child(even)',
    ':nth-child(odd)',
    ':active',
    ':checked',
    ':visited',
    ':hover',
  ]

  if(word[0]=='.' || pseudoClasses.includes(word) || word[0] == '[')
    return true
  else
    return false
}
function isType(word){
  const pseudoElements = [
    '::before',
    '::after',
    '::first-letter',
    '::first-line',
  ]

  const taglist = [
    'div',
    'p',
    'input',
    'a',
    'button',
    'span',
    'ul',
    'li',
    'ol',
    'form',
    'label',
    'h1',
    'h2',
    'legend',
    'textarea',
    'select',
    'option',
    'table',
    'tr',
    'td',
    'th',
    'img',
    'section',
    'article',
    'nav',
    'fieldset',
    'figcaption',
    'figure',
  ]
  if (pseudoElements.includes(word) || taglist.includes(word))
    return true
  else
    return false
}

function calculateAnsere(question){
  var answer = [0,0,0]
  for(var string of question){
    if(is_ID(string))
      answer[0] = answer[0] + 1
    else if(isClass(string))
      answer[1] = answer[1] + 1
    else if(isType(string))
      answer[2] = answer[2] + 1
  }
  return answer
}

export const fetchNewQuestion = () => async (dispatch) => {
  try {
    const newQuestion = generateSelector();
    const newAnswer = calculateAnsere(newQuestion);
    console.log(newQuestion, newAnswer)
    dispatch(setQuestion({question: newQuestion, answer:newAnswer}));
  } catch (error) {
    console.error('Error fetching new question:', error);
  }
};

const initialState = {
    question: [],
    answers: [0,0,0]
};

const QuestionSlice = createSlice({
    name: 'QuestionSlice',
    initialState,
    reducers: {
      // all the reducers here
      setQuestion: (state, action) =>{
        state.question = action.payload.question;
        state.answers = action.payload.answer;
      }
    },
    extraReducers: (builder) => {
        builder
    }
})

export const {setQuestion} = QuestionSlice.actions;
export default QuestionSlice.reducer;