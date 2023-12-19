<!-- Template -->
<template>
    <div class="Stacks-header_component">
        <Branding />
        <UserInfo />
    </div>
</template>

<!-- Script -->
<script>
import Branding from './Branding.vue';
import UserInfo from './User-info.vue';

export default {
    data() {
        return {
            greetings: "This is header"
        };
    },
    components: { Branding, UserInfo }
}
</script>

<!-- Style -->
<style>
.Stacks-header_component{
    color: blue;
    display: flex;
    flex-direction: row;
    justify-content: space-between;
    height: 7vh;
    width: 100vw;
}   
</style>