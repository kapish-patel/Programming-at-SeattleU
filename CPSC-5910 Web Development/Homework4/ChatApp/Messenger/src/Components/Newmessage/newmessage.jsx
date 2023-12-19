import { useDispatch, useSelector } from 'react-redux';
import './newmessage.css';
import React, {useState} from 'react';
import { sendMessage } from '../../../slice/Messagingslice';


function Newmessage(){
    const dispatch = useDispatch();
    const [message, setMessage] = useState('');
    const roomId = useSelector((state) => state.Messagingslice.selectedRoomId);

    const handelclick = async() => {
        if(message.trim() !== ''){
            const RoomInfo = {message, roomId}
            dispatch(sendMessage(RoomInfo));
            setMessage('');
        }
    };
    return(
        <div className="Newmessage_container">
            <input placeholder='Enter message here' value={message} onChange={(e) => setMessage(e.target.value)}></input>
            <button onClick={handelclick}>Send</button>
        </div>
    )
}

export default Newmessage