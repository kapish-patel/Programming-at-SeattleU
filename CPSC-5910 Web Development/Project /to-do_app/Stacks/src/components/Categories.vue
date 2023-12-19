<!-- Template -->
<template>
    <div class="Categories_component">
        <Category v-for="category in allcategories" :key="category.id" :category="category"/>
    </div>
</template>


<!-- Script -->
<script>
import {mapGetters} from 'vuex';
import Category from './Category.vue';

export default {
    data() {
        return {
            greetings: "this is categories component"
        }
    },
    computed:{
        ...mapGetters(['allcategories'])
    },
    components: { Category }    
}
</script>


<!-- Style -->
<style>
.Categories_component{
    color: blue;
    display: flex;
    flex-direction: row;
    justify-content: space-evenly;
    height: 93vh;
    width: 100vw;
}
</style>