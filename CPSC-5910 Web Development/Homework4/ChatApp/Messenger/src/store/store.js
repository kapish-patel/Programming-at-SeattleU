// src/store.js
import { configureStore } from '@reduxjs/toolkit';
import UserInfosliceReducer from '../../slice/UserInfoslice';
import RoomssliceReducer from '../../slice/Roomsslice';
import MessagingsliceReducer from '../../slice/Messagingslice';

const store = configureStore({
  reducer: {
    UserInfoslice: UserInfosliceReducer,
    Roomsslice: RoomssliceReducer,
    Messagingslice: MessagingsliceReducer,
  }
  
});

export default store;
