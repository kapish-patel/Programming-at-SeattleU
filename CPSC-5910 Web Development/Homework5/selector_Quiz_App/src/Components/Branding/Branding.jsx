import './Branding.css';
import blacklogo from '../../assets/images/logo_black.png'

function Branding(){
    return(
        <div className="Branding_container">
            <img alt='black logo' src={blacklogo}/>
        </div>
    )
}
export default Branding
