<!-- Template -->
<template>
    <div class="Task_component">
        <div class="CRUD-btns">
            <button class="Task_edit-btn" @click="editTask">✎</button>
            <button class="Task_strike-btn" @click="toogleStrike">/</button>
            <button class="Task_Delete-btn" @click="deleteTask">x</button>
        </div>
        <p v-if="!editing" class="TaskDescription" :class="{'striked':task.isStriked}">{{ task.taskDescription }}</p>
        <input v-if="editing" v-model="editedTaskDescription" @input="handelInput" @blur="saveTask" ref="editTask">
    </div>
</template>


<!-- Script -->
<script>
export default {
  props: {
    task: {
      type: Object,
      required: true,
    },
  },
  data() {
    return {
      greetings: "this is task component",
      editing: false,
      editedTaskDescription: this.task.taskDescription
    };
  },
  methods:{
        editTask(){
            this.editing = true 
            this.$nextTick(() => this.$refs.editTask.focus());
        },
        handelInput(){this.editedTaskDescription = event.target.value;},
        saveTask(){
            this.task.taskDescription = this.editedTaskDescription;
            
            this.$store.commit('updateTaskDescription', {
                taskId: this.task.id,
                editedTaskDescription: this.editedTaskDescription,
            });

            this.editing = false;
        },
        toogleStrike(){
            this.task.isStriked = !this.task.isStriked;

            this.$store.commit('toogleTaskStrike', {taskId: this.task.id});
        },
        deleteTask(){
            this.$store.commit('deleteTask', {taskId:this.task.id});
        }
    },
};
</script>


<!-- Style -->
<style>
.Task_component {
    border: 2px solid #ac0057; 
    border-radius: 10px;
    margin-bottom: 10px;
    display: flex;
    flex-direction: column;
    padding: 10px;
    background-color: #FFFFFF;
}
.Task_component:first-child{
    border: 2px solid #ac0057; 
    border-radius: 10px;
    margin-bottom: 10px;
    margin-top: 10px;
}
.Task_component:last-child{
    border: 2px solid #ac0057; 
    border-radius: 10px;
    margin-bottom: 0px;
}
.CRUD-btns{
    display: flex;
    flex-direction: row;
    justify-content: flex-end;
}
.Task_strike-btn {
    width: 17px;
    height: 17px;
    border-radius: 10px;
    margin-right: 3px;
    background-color: #44FFDD;
    transition: background-color 0.3s, transform 0.3s;
    cursor: pointer;
    border: 1px solid #aaa;
    display: flex;
    justify-content: center;
    align-items: center;
    transition: background-color 0.3s, transform 0.3s, width 0.3s, height 0.3s; 
}

.Task_strike-btn:hover {
    background-color: #33DDCC; /* Darker color on hover */
    transform: scale(1.1);
}

.Task_strike-btn:active {
    background-color: #22CCBB; /* Even darker color when clicked */
}

.Task_Delete-btn {
    width: 17px;
    height: 17px;
    border-radius: 10px; /* Adjusted border-radius for a more rounded look */
    margin-right: 3px;
    background-color: #FF6666;
    transition: background-color 0.3s, transform 0.3s;
    cursor: pointer;
    border: 1px solid #000; /* Add a border */
    display: flex;
    justify-content: center;
    align-items: center;
    transition: background-color 0.3s, transform 0.3s, width 0.3s, height 0.3s; 
}

.Task_Delete-btn:hover {
    background-color: #FF5050; /* Darker color on hover */
    transform: scale(1.1);
}

.Task_Delete-btn:active {
    background-color: #FF3333; /* Even darker color when clicked */
}

.Task_edit-btn {
    width: 17px;
    height: 17px;
    border-radius: 10px;
    margin-right: 3px;
    background-color: #6FCCFF;
    transition: background-color 0.3s, transform 0.3s, width 0.3s, height 0.3s; /* Added transform property */
    cursor: pointer;
    border: 1px solid #000;
    display: flex;
    justify-content: center;
    align-items: center;
}

.Task_edit-btn:hover {
    background-color: #4FA2DB;
    transform: scale(1.1); /* Added scale transform on hover */
}

.Task_edit-btn:active {
    background-color: #3685B2;
}


.striked {
  text-decoration: line-through;
  color: #888; 
  opacity: 0.6; 
}
.TaskDescription {
  color: #333; 
  font-family: 'Roboto Mono'; 
  font-size: 16px; 
  line-height: 1.35; 
}
</style>