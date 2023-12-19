import { createSlice, createAsyncThunk } from '@reduxjs/toolkit'

//fetch room detail
export const fetchRoomDetails = createAsyncThunk('Messagingslice/fetchRoomDetails', async(name) => {
    try{
      //get the response
      const response = await fetch(`api/rooms/${name}`);
      if (!response.ok){
        throw new Error("Request Data Error");
      } 
      const roomDetails = await response.json();
      return roomDetails;
    }catch(error){
      throw error
    }
})

// get the data of chat
export const fetchRoomChat = createAsyncThunk('Messagingslice/fetchRoomChat', async(selectedRoomId) => {
    try{
        const response = await fetch(`api/rooms/${selectedRoomId}/chats`);
        if (!response.ok){
            throw new Error("Request data Error");
        }
        const chatData = await response.json();
        return chatData;
    }catch(error){
        throw error
    }
})

//send new message - continue from here change the params and also see what is expected by server
export const sendMessage = createAsyncThunk('Messagingslice/sendMessage', async (RoomInfo, {dispatch}) => {
    try {
        const {message, roomId} = RoomInfo;
        const response = await fetch(`/api/rooms/${roomId}/chats`, {
        method: 'POST',
        headers: {
          'Content-Type': 'text/plain',
        },
        body: message,
      });
      if (!response.ok) {
        throw new Error('Failed to send message');
      }
      const timeStamp = await response.json();
      console.log(chatData);
      return dispatch(fetchRoomChat(roomId))

    } catch (error) {
      throw error;
    }
  });

//initial state
const initialState = {
    selectedRoomId: null,
    roomDetails: null,
    chatData: [],
    status: 'idle',
    error: null,
  };

  const Messagingslice = createSlice({
    name: 'Messagingslice',
    initialState,
    reducers: {
      // all the reducers here
      setSelectedRoomId: (state, action) => {
        state.selectedRoomId = action.payload;
      },
    },
    extraReducers: (builder) => {
      builder
      //add cases here  
      .addCase(fetchRoomDetails.pending, (state) => {
        state.status = 'Loading...';
      })
      .addCase(fetchRoomDetails.fulfilled, (state, action) => {
        state.status = 'succeeded';
        state.roomDetails = action.payload;
      })
      .addCase(fetchRoomDetails.rejected, (state, action) => {
        state.status = 'failed';
        state.error = action.error.message;
      })
      
      // cases for fetchroomchat
      .addCase(fetchRoomChat.pending, (state) => {
        state.status = 'Loading...';
      })
      .addCase(fetchRoomChat.fulfilled, (state, action) => {
        state.status = 'succeeded';
        state.chatData = action.payload;
      })
      .addCase(fetchRoomChat.rejected, (state, action) => {
        state.status = 'failed';
        state.error = action.error.message;
      })

      //cases for addroom
      .addCase(sendMessage.pending, (state) => {
        state.status = 'Loading...';
      })
      .addCase(sendMessage.fulfilled, (state, action) => {
        state.status = 'succeeded';
        state.chatData = action.payload;
      })
      .addCase(sendMessage.rejected, (state, action) => {
        state.status = 'failed';
        state.error = action.error.message;
      });
    }
});
export const { setSelectedRoomId } = Messagingslice.actions;
export default Messagingslice.reducer;