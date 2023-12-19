<!-- Template -->
<template>
    <div class="Category_component">
        <button class="Category_add-btn fa-solid fa-plus" @click="addTask"></button>
        <CategoryDetail :categoryName="category.name" />
        <Tasks :categotyTasks="category.tasks"/>
    </div>
</template>


<!-- Script -->
<script>
import Tasks from './Tasks.vue';
import CategoryDetail from './Category-detail.vue';

export default {
    data() {
        return {
            greetings: "this is category component"
        }
    },
    props:{
        category:{
            type: Object,
            require: true,
        }
    },
    components: { Tasks, CategoryDetail },
    methods:{
        addTask(){
            const newTask = {id: Date.now(), taskDescription:'Edit Me', isStriked: false};

            this.$store.commit('addTask', {categoryId: this.category.id, newTask});
        }
    }    
}
</script>


<!-- Style -->
<style>
.Category_component{
    margin-top: 20px;
    width: 350px;
    border-radius: 10px;
    display: flex;
    flex-direction: column;
}
.Category_add-btn {
    align-self: flex-end;
    width: 35px;
    height: 20px; /* Adjust height for a more square button */
    border-radius: 10px;
    margin-top: 5px;
    margin-right: 5px;
    background-color: #92DEBA;
    border: 1px black solid;
    transition: background-color 0.3s, transform 0.3s;
    cursor: pointer;
}

.Category_add-btn:hover {
    background-color: #6EBD96; /* Darker color on hover */
    transform: scale(1.1); /* Slightly scale up on hover for a button effect */
    box-shadow: black 1px;
}
</style>