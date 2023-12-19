<!-- Template -->
<template>
    <div class="Category-detail_component">
        <p>{{ categoryName }}</p>
    </div>
</template>


<!-- Script -->
<script>
export default {
    data() {
        return {
            greetings: "this is Category detail component"
        }
    },
    props: {
        categoryName: {
            type: String,
            required: true,
        },
    },
}
</script>


<!-- Style -->
<style>
.Category-detail_component{
    color: #880088;
    font-family: 'Josefin Sans';
    align-self: center;
    margin: 5px;
    font-size: 16px;
    font-weight: 600;
    letter-spacing: 3px;
    text-transform: uppercase;
    transition: color 0.3s ease, transform 0.3s ease;
}
.Category-detail_component:hover{
    color: #770077;
    transform: scale(1.1);
}
</style>