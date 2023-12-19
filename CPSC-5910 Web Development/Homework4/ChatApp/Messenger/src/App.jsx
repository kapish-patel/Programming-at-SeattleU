import './App.css'
import Rooms from './Components/Rooms/rooms';
import Messages from './Components/Messages/messages';
import Userinfo from './Components/UserInfo/userinfo';
// import UserData from '../CustomHooks/UserData';
// import RoomsData from '../CustomHooks/RoomsData';

function App() {
  // const {userdata, userdata_Error} = UserData();
  // const {roomsdata, roomsdata_Error, addNewRoom} = RoomsData();
  return (
    <div className="App_container">
      <div className="userinfo_and_rooms_container">
        <Userinfo></Userinfo>
        <Rooms></Rooms>
      </div>
      <div className="messages_container">
        <Messages></Messages>
      </div>
    </div>
  )
}

export default App
