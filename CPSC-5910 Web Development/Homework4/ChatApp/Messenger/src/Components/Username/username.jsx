import './username.css';
import React, {useEffect} from 'react';
import { useSelector, useDispatch } from 'react-redux';
import { fetchUsers } from '../../../slice/UserInfoslice';
import './Username.css'

function Username(){
    // use the dispatch hook 
    const dispatch = useDispatch();

    //get the data from store using useSelector
    const {user, status, error} = useSelector((state) => state.UserInfoslice);
    //use the use effect hook to dispatch fetch user
    useEffect(() => {
        dispatch(fetchUsers());
    },[dispatch]);

    //handel different states 
    if (status === 'Loading...'){
        return <p>Loading...</p>
    }

    if (status === 'failed'){
        return <p>Error: {error}</p>
    }

    return(
        <div className="Username_container">
            <input type='text' id='username-input' placeholder={user.name}></input>
        </div>
    )
}

export default Username