import './lastonline.css';
import React, {useEffect} from 'react';
import { useSelector, useDispatch } from 'react-redux';
import { fetchUsers } from '../../../slice/UserInfoslice';

function Lastonline(){
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
        <div className="Lastonline_container">
            <p>{new Date(user.registrationTimestamp).toLocaleString()}</p>
        </div>
    )
}

export default Lastonline