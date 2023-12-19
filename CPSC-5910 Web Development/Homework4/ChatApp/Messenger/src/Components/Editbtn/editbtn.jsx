import './editbtn.css'
import { updateUser } from '../../../slice/UserInfoslice';
import { useDispatch } from 'react-redux';
import React from 'react';

function Editbtn(){
    const dispatch = useDispatch();

    const handelclick = () => {
        const newName = document.querySelector('#username-input').value;
        if (newName){
            dispatch(updateUser(newName));
        }
    }
    return(
        <div className="Editbtn_container">
            <button onClick={handelclick}>edit</button>
        </div>
    )
}

export default Editbtn