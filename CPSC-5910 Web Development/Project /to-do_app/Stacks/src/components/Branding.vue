<!-- Template -->
<template>
    <div class="Header-branding_component">
        <router-link to="/">
            <img src="../assets/Stacks.png" alt="Stacks logog with name" id="branding_image">
        </router-link>
    </div>
</template>

<!-- Script -->
<script>
export default {
    data() {
        return {
            greetings: "this is logo / branding component"
        }
    },    
}
</script>

<!-- Style -->
<style>
.Header-branding_component{
    color: blue;
}
#branding_image{
    margin-left: 10px;
    margin-bottom: 10px;
    height: 100%;
    
}
</style>