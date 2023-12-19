import Lastonline from '../Lastonline/Lastonline';
import Editbtn from '../Editbtn/editbtn';
import './lastonlineandedit.css';


function LastonlineAndEdit(){
    return(
        <div className="LastonlineAndEdit_container">
            <Lastonline></Lastonline>
            <Editbtn></Editbtn>
        </div>
    )
}

export default LastonlineAndEdit