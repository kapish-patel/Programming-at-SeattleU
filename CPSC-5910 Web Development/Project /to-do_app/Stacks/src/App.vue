<script setup>
import StacksBody from './components/Stacks-body.vue';
import StacksHeader from './components/Stacks-header.vue';
</script>

<template>
  <div class="App_Component">
    <StacksHeader/>
    <router-view/>
  </div>
</template>

<script>
export default {
    data() {
        return {
            greetings: "This is body component"
        }
    },    
    components: { StacksBody, StacksHeader }
}
</script>

<style>
.App_Component{
  display: flex;
  flex-direction: column;
  background-color: #FFFFFF;
  background-image: url("data:image/svg+xml,%3Csvg xmlns='http://www.w3.org/2000/svg' viewBox='0 0 1600 900'%3E%3Cpolygon fill='%23cc1c1c' points='957 450 539 900 1396 900'/%3E%3Cpolygon fill='%23aa0a0a' points='957 450 872.9 900 1396 900'/%3E%3Cpolygon fill='%23d13e4a' points='-60 900 398 662 816 900'/%3E%3Cpolygon fill='%23b74950' points='337 900 398 662 816 900'/%3E%3Cpolygon fill='%23db546e' points='1203 546 1552 900 876 900'/%3E%3Cpolygon fill='%23a92343' points='1203 546 1552 900 1162 900'/%3E%3Cpolygon fill='%23d02d71' points='641 695 886 900 367 900'/%3E%3Cpolygon fill='%23aa4166' points='587 900 641 695 886 900'/%3E%3Cpolygon fill='%23c54494' points='1710 900 1401 632 1096 900'/%3E%3Cpolygon fill='%23a2397b' points='1710 900 1401 632 1365 900'/%3E%3Cpolygon fill='%23b155b1' points='1210 900 971 687 725 900'/%3E%3Cpolygon fill='%23822682' points='943 900 1210 900 971 687'/%3E%3C/svg%3E");
  background-attachment: fixed;
  background-size: cover;
}
</style>
