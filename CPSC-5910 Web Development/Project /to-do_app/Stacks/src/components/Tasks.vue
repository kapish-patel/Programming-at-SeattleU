<!-- Template -->
<template>
    <div class="Tasks_component">
        <Task v-for="task in categotyTasks" :key="task.id" :task="task" />
        <p id="funnytag" v-if="categotyTasks.length === 0">{{getRandomFunnyQuote()}}</p>
    </div>
</template>


<!-- Script -->
<script>
import Task from './Task.vue';

export default {
    data() {
        return {
            funnyQuote: [
                "Procrastinate now, don't put it off.",
                "I put the 'pro' in procrastinate.",
                "Why do today what you can put off until tomorrow?",
                "I'm not lazy; I'm on energy-saving mode.",
                "I could be a morning person, but I prefer to sleep.",
                "I'm not a procrastinator; I'm just extremely productive at unimportant things.",
                "I'm not avoiding work. I'm strategically not doing it.",
                "The sooner I fall behind, the more time I have to catch up.",
                "I always say 'morning' instead of 'good morning' because if it was a good morning, I would still be in bed.",
                "I'm not addicted to coffee; we're just in a committed relationship.",
                "I'm not a control freak, but you're doing it wrong.",
                "I'm not late; I'm on a flexible schedule.",
                "I'm not saying I hate my job, but if a zombie apocalypse happens, I'm sticking with the zombies.",
                "I'm not a morning person or a night owl. I'm a permanently exhausted pigeon.",
                "I'm not avoiding work; I'm conducting a strategic avoidance campaign.",
                "I'm not easily distracted; oh, look, a squirrel!",
                "I'm not a superhero, but give me a deadline, and I'll make the impossible happen.",
                "I don't have a 9 to 5 job; I have a when I open my eyes to when I close my eyes job.",
                "I'm not antisocial; I'm just pro-solitude.",
                "I'm not a procrastinator; I'm just waiting for the right moment... which is usually the last minute."
            ],
        }
    },
    props: {
        categotyTasks: {
            type: Array,
            required: true,
        },
    },
    components: { Task },
    methods:{
        getRandomFunnyQuote(){
            const randomIndex = Math.floor(Math.random()* this.funnyQuote.length);
            return this.funnyQuote[randomIndex];
        }
    }    
}
</script>


<!-- Style -->
<style>
.Tasks_component{
    color: blue;
    margin: 10px;
    display: flex;
    flex-direction: column;
    overflow-y: auto;
}
#funnytag {
    margin: 10px 0;
    text-align: center;
    font-style: italic;
    color: green;
}
</style>