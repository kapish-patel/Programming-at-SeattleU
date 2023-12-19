<!-- Template -->
<template>
    <div class="Header-userinfo_component">
        <router-link to="/user" class="router-link">
            <p id="user-infotag">Welcome {{ UserInfo.name }}</p>
        </router-link>
    </div>
</template>


<!-- Script -->
<script>
import {mapGetters} from 'vuex'

export default {
    data() {
        return {
            greetings: "Kapish"
        }
    },
    computed:{
    ...mapGetters(['UserInfo'])
  },    
}
</script>


<!-- Style -->
<style>
.router-link{
    text-decoration: none;
}

.Header-userinfo_component{
    margin-right: 10px;
    margin-top: 10px;
    display: flex;
    flex-direction: row;
    justify-content: space-between;
    text-decoration: none;
}

#user-infotag {
  font-size: 25px;
  font-weight: bold;
  color: #c21600;
  text-decoration: none; 
  font-family: 'Roboto Mono';
  text-transform: capitalize;
  letter-spacing: 8px;
}

#user-infotag:hover {
  color: #880088; 
}

</style>