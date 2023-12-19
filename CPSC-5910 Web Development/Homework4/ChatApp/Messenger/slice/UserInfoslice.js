import { createSlice, createAsyncThunk } from '@reduxjs/toolkit';
import Cookies from 'js-cookie';



//fetching data using thunk
export const fetchUsers = createAsyncThunk('UserInfoslice/fetchUsers', async() => {
  try{
    //get the response
    const response = await fetch('api/users');
    if (!response.ok){
      throw new Error("Request Data Error");
    } 
    const result = await response.json();
    return result;
  }catch(error){
    throw error
  }
})

//updat userdata
export const updateUser = createAsyncThunk('UserInfoslice/updateUser', async(newName, {dispatch}) => {
  try{
    //calling the update user api
    const response = await fetch('/api/account/name', {
    method: 'PUT',
    headers: {
      'Content-Type': 'text/plain',
    },
    body: newName,
    });
  
    if (!response.ok){
      throw new Error("Failed to Update username");
    }
  
    dispatch(fetchUsers());
  }catch(error){
    throw error
  }
  
});

const initialState = {
  user: [],
  allUsers: [],
  status: 'idle',
  error: null
};

const UserInfoslice = createSlice({
  name: 'UserInfoslice',
  initialState,
  reducers: {
    // all the reducers here
  },
  extraReducers: (builder) => {
    builder
      .addCase(fetchUsers.pending, (state) => {
        state.status = 'Loading...';
      })

      .addCase(fetchUsers.fulfilled, (state, action) => {
        state.status = 'succeeded';
        state.allUsers = action.payload;

        //get the public key from cookies and filter out the data
        const publicUserIdFromCookie = Cookies.get('publicUserId');
        state.user = action.payload.find(element => element.publicUserId === publicUserIdFromCookie);

      })

      .addCase(fetchUsers.rejected, (state, action) => {
        state.status = 'failed';
        state.error = action.error.message;
      })

      //update username cases
      .addCase(updateUser.pending, (state) => {
        state.status = 'Loading...';
      })

      .addCase(updateUser.fulfilled, (state, action) => {
        state.status = 'succeeded';
        state.user.name = action.payload.name;
      })

      .addCase(updateUser.rejected, (state, action) => {
        state.status = 'failed';
        state.error = action.error.message;
      })
  }
});


export default UserInfoslice.reducer;
