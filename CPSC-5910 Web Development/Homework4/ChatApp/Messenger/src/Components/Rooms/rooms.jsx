import Room from '../Room/room'
import Addroom from '../Addroom/addroom'
import './rooms.css'

import { fetchRooms } from '../../../slice/Roomsslice'
import React,{useEffect} from 'react'
import { useSelector, useDispatch } from 'react-redux';

function Rooms(){
    const dispatch = useDispatch();

    const {rooms, status, error} = useSelector((state) => state.Roomsslice);

    useEffect(() => {
        dispatch(fetchRooms());
    },[dispatch]);

    if (status === 'Loading...'){
        return <p>Loading....</p>
    }

    if (status === 'failed'){
        return <p> {error} </p>
    }
    return(
        <div className="Rooms_container">
            <Addroom></Addroom>
            {rooms.map((room) => (
                <Room key={room.name} room={room} />
            ))}
        </div>
    )
}

export default Rooms