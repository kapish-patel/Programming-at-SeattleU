import Roomdetail from '../Roomdetail/roomdetail';
import Chat from '../Chat/chat';
import Newmessage from '../Newmessage/newmessage';
import './messages.css'

function Messages(){
    return (
        <div className="Messages_container">
            <div className="Message_component_wraper">
                <Roomdetail></Roomdetail>
                <Chat></Chat>
                <Newmessage></Newmessage>
            </div>
        </div>
    )
}

export default Messages