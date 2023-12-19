import UserDetails from '../components/User-details.vue';
import StacksBody from '../components/Stacks-body.vue'

const routes = [
    {path: '/user', component: UserDetails},
    {path: '/', component: StacksBody},
]

export default routes;