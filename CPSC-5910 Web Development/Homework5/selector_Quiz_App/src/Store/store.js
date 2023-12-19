// src/store.js
import { configureStore } from '@reduxjs/toolkit';
import QuestionsSliceReducer from '../slices/QuestionsSlice';
import SelectorSliceReducer from '../slices/SelectorSlice';

const store = configureStore({
  reducer: {
    QuestionSlice: QuestionsSliceReducer,
    SelectorSlice: SelectorSliceReducer,
  }
  
});

export default store;
