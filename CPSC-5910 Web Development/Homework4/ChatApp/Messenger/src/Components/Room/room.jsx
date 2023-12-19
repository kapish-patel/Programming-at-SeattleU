import './room.css'
import { useDispatch, useSelector } from 'react-redux';
import { fetchRoomChat, setSelectedRoomId } from '../../../slice/Messagingslice';
import { useEffect } from 'react';
import './room.css';


function Room({room}){

    const dispatch = useDispatch();
    const selectedRoomId = useSelector((state) => state.Messagingslice.selectedRoomId);
    const handleClick = () => {
        // Dispatch setSelectedRoomId when a room is clicked
        dispatch(setSelectedRoomId(room.name));
      };

    useEffect(() => {
        if(selectedRoomId){
            dispatch(fetchRoomChat(selectedRoomId));
        }
    },[selectedRoomId, dispatch])
    return(
        <div className="room_component" onClick={handleClick}>
            <p>{room.name}</p>
        </div>
    )
}

export default Room