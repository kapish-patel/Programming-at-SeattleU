import {createStore} from 'vuex';

export default createStore({
    state:{
        categories: [
            { id: 1, name: 'Work', tasks: []},
            { id: 2, name: 'Personal', tasks: []},
            { id: 3, name: 'Family', tasks: []},
            { id: 4, name: 'Health', tasks: []},
            { id: 5, name: 'Long Term Goals', tasks: []},
        ],
        UserInfo:{
            name: "Kapish",
            age: 23,
            email: "kpatel3@seattleu.edu",
        }

    },
    mutations:{
        updateTaskDescription(state, payload){
            const {taskId, editedTaskDescription} = payload;
            const category = state.categories.find(category => category.tasks.some(task => task.id === taskId));
            console.log(category)
            if(category){
                const taskToUpdate = category.tasks.find(task => task.id === taskId);
                if (taskToUpdate){
                    taskToUpdate.taskDescription = editedTaskDescription;
                }
            }
        },

        deleteTask(state, payload) {
            const { taskId } = payload;
      
            for (let i = 0; i < state.categories.length; i++) {
              const category = state.categories[i];
              const taskIndex = category.tasks.findIndex(task => task.id === taskId);
      
              if (taskIndex !== -1) {
                category.tasks.splice(taskIndex, 1);
                break;
              }
            }
        },

        addTask(state, payload){
            const {categoryId, newTask} = payload;
            const category = state.categories.find((cate) => cate.id === categoryId);

            if (category){
                category.tasks.unshift(newTask);
            }
        },

        updateName(state, newName) {state.UserInfo.name = newName;},
        updateAge(state, newAge) {state.UserInfo.age = newAge;},
        updateEmail(state, newEmail) {state.UserInfo.email = newEmail;},
    },
    actions:{

    },
    getters:{
        allcategories: (state) => state.categories,
        UserInfo: (state) => state.UserInfo,
    },
    modules:{
        
    }

})