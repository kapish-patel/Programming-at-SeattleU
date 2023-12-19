import React, { useEffect, useState } from 'react';
import './roomdetail.css';
import { useDispatch, useSelector } from 'react-redux';
import { fetchRoomDetails } from '../../../slice/Messagingslice';

function RoomDetail() {
    const dispatch = useDispatch();

    const selectedRoomId = useSelector((state) => state.Messagingslice.selectedRoomId);
    const roomDetails = useSelector((state) => state.Messagingslice.roomDetails);

    useEffect(() => {
        if (selectedRoomId) {
          dispatch(fetchRoomDetails(selectedRoomId));
        }
      }, [selectedRoomId, dispatch]);

    return (
        <div className="Roomdetail_container">
            {selectedRoomId ? (
        <p className='roomdetail_roomname'>{roomDetails ? `${selectedRoomId} - ${roomDetails.description}` : 'Loading...'}</p>
        // You can add more details here based on your roomDetails object
      ) : (
        <p className='roomdetail_roomname'>Please select a room</p>
      )}
        </div>
    );
}

export default RoomDetail;
