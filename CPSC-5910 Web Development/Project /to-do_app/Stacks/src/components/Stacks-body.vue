<!-- Template -->
<template>
    <div class="Stack-body_container">
        <Categories />
        <!-- add user-detail component for changing user infor and also change the path for that to  /user -->
    </div>
</template>

<!-- Script -->
<script>
import Categories from './Categories.vue';

export default {
    data() {
        return {
            greetings: "This is body component"
        }
    },    
    components: { Categories }
}
</script>

<!-- Style -->
<style>
.Stack-body_container{
    height: 93vh;
    width: 100vw;
}
</style>