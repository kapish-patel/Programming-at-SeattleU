import LastonlineAndEdit from '../LastonlineAndEdit/lastonlineandedit';
import Username from '../Username/Username';
import './Userinfo.css'

function Userinfo(){
    return(
        <div className="Userinfo_container">
            <LastonlineAndEdit></LastonlineAndEdit>
            <Username></Username>
        </div>
    )
}

export default Userinfo