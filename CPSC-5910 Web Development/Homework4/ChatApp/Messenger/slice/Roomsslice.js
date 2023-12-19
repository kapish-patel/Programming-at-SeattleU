import { createSlice, createAsyncThunk } from '@reduxjs/toolkit'

//fetching data using thunk
export const fetchRooms = createAsyncThunk('Roomsslice/fetchRooms', async() => {
  try{
    //get the response
    const response = await fetch('api/rooms');
    if (!response.ok){
      throw new Error("Request Data Error");
    } 
    const rooms = await response.json();

    return rooms;
  }catch(error){
    throw error
  }
})

//add new rooms
export const addRooms = createAsyncThunk('Roomsslice/addRooms', async(newRoom, {dispatch}) => {
    //calling the update user api
    try{
        const response = await fetch('/api/rooms', {
            method: 'POST',
            headers: {
              'Content-Type': 'application/json',
            },
            body: JSON.stringify(newRoom),
          });
        
        if (!response.ok){ 
            throw new Error("Failed to create room");
        }

        return dispatch(fetchRooms());
  }catch(error){
    throw error
  }  
});

const initialState = {
  rooms: [],
  status: 'idle',
  error: null
};

const Roomsslice = createSlice({
  name: 'Roomsslice',
  initialState,
  reducers: {
    // all the reducers here
  },
  extraReducers: (builder) => {
    builder
      .addCase(fetchRooms.pending, (state) => {
        state.status = 'Loading...';
      })

      .addCase(fetchRooms.fulfilled, (state, action) => {
        state.status = 'succeeded';
        state.rooms = action.payload;
      })

      .addCase(fetchRooms.rejected, (state, action) => {
        state.status = 'failed';
        state.error = action.error.message;
      })

      //addrooms case
      .addCase(addRooms.pending, (state) => {
        state.status = 'Loading...';
      })

      .addCase(addRooms.fulfilled, (state, action) => {
        state.status = 'succeeded';
        state.rooms = [...state.rooms, action.payload];
      })

      .addCase(addRooms.rejected, (state, action) => {
        state.status = 'failed';
        state.error = action.error.message;
      })

  }
});


export default Roomsslice.reducer;
