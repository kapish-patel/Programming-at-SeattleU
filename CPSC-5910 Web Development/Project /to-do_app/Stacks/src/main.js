import { createApp } from 'vue'
import './style.css'
import App from './App.vue'
import Store from './Store/index'
import {createRouter, createWebHistory} from 'vue-router';
import routes from './Router/router';

const router = createRouter({
    history: createWebHistory(),
    routes,
})

createApp(App).use(Store).use(router).mount('#app');
