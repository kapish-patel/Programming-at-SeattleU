<template>
  <div class="User-details_component">
    <div class="profile-section">
      <div class="user-info">
        <p>
          <strong class="string-label" >Name:</strong>
          <template v-if="!isEditing.name">
            {{ UserInfo.name }} 
            <button class="fa-solid fa-pen-to-square" @click="startEditing('name')"></button>
          </template>
          <template v-else>
            <input  class="user-info-input" ref="nameInput" v-model="editedDetails.name" type="text" placeholder="Name" @blur="saveChanges('name')"/>
          </template>
        </p>

        <p>
          <strong class="string-label" >Age:</strong>
          <template v-if="!isEditing.age">
            {{ UserInfo.age }} 
            <button class="fa-solid fa-pen-to-square" @click="startEditing('age')"></button>
          </template>
          <template v-else>
            <input class="user-info-input" ref="ageInput" v-model.number="editedDetails.age" type="number" placeholder="Age" @blur="saveChanges('age')"/>
          </template>
        </p>

        <p>
          <strong class="string-label" >Email:</strong>
          <template v-if="!isEditing.email">
            {{ UserInfo.email }} 
            <button class="fa-solid fa-pen-to-square" @click="startEditing('email')"></button>
          </template>
          <template v-else>
            <input class="user-info-input" ref="emailInput" v-model="editedDetails.email" type="email" placeholder="Email" @blur="saveChanges('email')"/>
          </template>
        </p>
      </div>
    </div>
  </div>
</template>

<script>
import { mapGetters ,mapMutations } from 'vuex';

export default {
  data() {
    return {
      isEditing: {
        name: false,
        age: false,
        email: false,
      },
      editedDetails: {
        name: '',
        age: null,
        email: '',
      },
    };
  },
  computed:{
    ...mapGetters(['UserInfo'])
  },
  methods: {
    ...mapMutations(['updateName', 'updateAge', 'updateEmail']),
    
    startEditing(field) {
      // Set the editing flag for the specified field to true
      this.isEditing[field] = true;
      // Set the edited details to the current user details
      this.editedDetails[field] = this.UserInfo[field];

      this.$nextTick(() => {
        this.$refs[`${field}Input`].focus();
      })
    },
    
    saveChanges(field) {
      // Save the changes for the specified field
      switch (field) {
        case 'name':
          this.updateName(this.editedDetails.name);
          break;
        case 'age':
          this.updateAge(this.editedDetails.age);
          break;
        case 'email':
          this.updateEmail(this.editedDetails.email);
          break;
        default:
          break;
      }
      // Reset the editing flag and edited details
      this.isEditing[field] = false;
      // this.editedDetails[field] = '';
    },
  },
};
</script>

<style scoped>
.User-details_component {
    height: 93vh;
    width: 100vw;
    display: flex;
    flex-direction: row;
    justify-content: center;
    font-family: 'Roboto Mono';
}
.profile-section {
  margin-top: 20px;
}

.string-label{
  font-size: 17px;
}

.user-info-input{
  font-family: 'Roboto Mono';
  font-size: 13px;
}

.user-info {
  background-color: #f4f4f4;
  padding: 20px;
  border-radius: 10px;
  box-shadow: 0 0 10px rgba(0, 0, 0, 0.1);
}

.user-info p {
  margin-bottom: 15px;
}

strong {
  color: #c21600;
}

.fa-solid.fa-pen-to-square {
  background-color: #6FCCFF;
  border: 1px solid #3388cc;
  border-radius: 5px;
  margin-left: 10px;
  cursor: pointer;
}

input[type="text"],
input[type="number"],
input[type="email"] {
  padding: 8px;
  margin-top: 5px;
  margin-bottom: 15px;
  border: 1px solid #ccc;
  border-radius: 5px;
}

input[type="text"]:focus,
input[type="number"]:focus,
input[type="email"]:focus {
  outline: none;
  border-color: #6FCCFF;
  box-shadow: 0 0 5px rgba(111, 204, 255, 0.5);
}

input[type="text"]::placeholder,
input[type="number"]::placeholder,
input[type="email"]::placeholder {
  color: #ccc;
}


</style>