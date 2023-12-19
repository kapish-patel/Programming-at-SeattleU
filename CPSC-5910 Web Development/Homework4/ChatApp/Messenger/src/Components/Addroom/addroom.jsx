import './Addroom.css';
import { addRooms, fetchRooms } from '../../../slice/Roomsslice';
import React, { useState } from 'react';
import { useSelector, useDispatch } from 'react-redux';

function Addroom() {
  const dispatch = useDispatch();
  const { status, error } = useSelector((state) => state.Roomsslice);

  const [name, setRoomName] = useState('');
  const [description, setRoomDescription] = useState('');

  const handleClick = async () => {
    try {
        // Dispatch the addRooms action with the roomName and roomDescription
        dispatch(addRooms({name,description}));
        
        // Clear the input values
        setRoomName('');
        setRoomDescription('');
    } catch (error) {
        console.error('Failed to add room:', error.message);
    }
  };

  return (
    <div className="Addroom_container">
      <input
        type="text"
        id="roomname-input"
        placeholder="Room Name"
        onChange={(e) => setRoomName(e.target.value)}
      />
      <textarea
        id="roomdescription-input"
        placeholder="Room Description"
        onChange={(e) => setRoomDescription(e.target.value)}
      ></textarea>
      <button onClick={handleClick}>+</button>
    </div>
  );
}

export default Addroom;
