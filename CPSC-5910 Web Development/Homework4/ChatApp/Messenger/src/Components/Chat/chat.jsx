import React, { useState, useEffect } from 'react';
import { useSelector, useDispatch } from 'react-redux';
import { fetchRoomChat, setSelectedRoomId } from '../../../slice/Messagingslice';
import { fetchUsers } from '../../../slice/UserInfoslice';
import './chat.css';

function Chat() {
  const selectedRoomId = useSelector((state) => state.Messagingslice.selectedRoomId);
  const chatData = useSelector((state) => state.Messagingslice.chatData);
  const allUsers = useSelector((state) => state.UserInfoslice.allUsers);
  const dispatch = useDispatch();

  useEffect(() => {
    // Fetch chat data initially when the component mounts
    if (selectedRoomId) {
      dispatch(fetchRoomChat(selectedRoomId));
    }

    dispatch(fetchUsers());

    // Set up an interval to fetch chat data every 5 seconds
    const intervalId = setInterval(() => {
      if (selectedRoomId) {
        dispatch(fetchRoomChat(selectedRoomId));
      }
    }, 5000);

    // Clean up the interval when the component is unmounted
    return () => clearInterval(intervalId);
  }, [selectedRoomId, dispatch]);

  if (!selectedRoomId) {
    // No room selected, display a message or render nothing
    return (
      <div className="Chat_container">
        <p>Please select a room</p>
      </div>
    );
  }

  function getUserById(users, userId){
    return users.find(user => user.publicUserId === userId)
  }
  return (
    <div className="Chat_container">
      <ul>
        {[...chatData].reverse().map((message) => (
          <li>
            <strong>{getUserById(allUsers, message.posterId)?.name}</strong>: {message.messageText}
          </li>
        ))}
      </ul>
    </div>
  );
}

export default Chat;
