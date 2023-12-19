# Stacks

![Logo](https://github.com/kapish-patel/Web-Development/blob/main/Project%20/to-do_app/Stacks/src/assets/Stacks.png)


## Tech Stack
  <img align="left" alt="Vue.js" width="30px" style="padding-right:10px;" src="https://cdn.jsdelivr.net/gh/devicons/devicon/icons/vuejs/vuejs-original.svg" />
  <img align="left" alt="HTML5" width="30px" style="padding-right:10px;" src="https://cdn.jsdelivr.net/gh/devicons/devicon/icons/html5/html5-original.svg" />
  <img align="left" alt="CSS3" width="30px" style="padding-right:10px;" src="https://cdn.jsdelivr.net/gh/devicons/devicon/icons/css3/css3-original.svg" />
  <img align="left" alt="JavaScript" width="30px" style="padding-right:10px;" src="https://cdn.jsdelivr.net/gh/devicons/devicon/icons/javascript/javascript-original.svg" />
  </br>

## Demo

| Actions | Demo  |
| :-------- | :------- |
| Add a Task| <img alt="add task gif" style="height:250px; width:400px;" src="https://github.com/kapish-patel/Web-Development/blob/main/Project%20/Demos/add_task.gif" />     |
| Strike a Task| <img alt="add task gif" style="height:250px; width:400px;" src="https://github.com/kapish-patel/Web-Development/blob/main/Project%20/Demos/strike_task.gif" />     |
| Edit a Task | <img alt="add task gif" style="height:250px; width:400px;" src="https://github.com/kapish-patel/Web-Development/blob/main/Project%20/Demos/edit_task.gif" />     |
| Delete a Task| <img alt="add task gif" style="height:250px; width:400px;" src="https://github.com/kapish-patel/Web-Development/blob/main/Project%20/Demos/delete_task.gif" />     |
| User information | <img alt="add task gif" style="height:250px; width:400px;" src="https://github.com/kapish-patel/Web-Development/blob/main/Project%20/Demos/edit_user.gif" />     |    
<!-- ** Try it here: [Live Demo](https://stacks-todo.vercel.app/) ** -->

## Run Locally

Clone the project

```bash
  git clone https://github.com/kapish-patel/Web-Development/tree/main/Project%20/to-do_app/Stacks
```

Go to the project directory

```bash
  cd stacks
```

Install dependencies

```bash
  npm install
```

Start the server

```bash
  npm run dev
```

Stop the server (Pc / Mac) 
```bash
    ctrl + c 
    Control + c
```

# Development journal
Okie Dokie!


| Questions | Answer   |
| :-------- | :------- |
| What is vue ??? | just a simple front-end framework |
| Why vue ? | light weight and why not another framework |
| Who owns vue ? | Open-source |
| Who created vue ? | Evan you |
| Is is vue good in compare to react ? | Both have their good sides |
| What is the development process in vue ? | It uses Templating method HTML, style, script |
| Is there any free vue course other then Documentation ? | yes search youtube |
| What does people say about vue ? | people have mixed openions |
| did I liked vue over rect ? | Hard No react is far more easy and better |
| Did I like Documentation of vue | If I did not knew react before, NO meaning a beginer would not understand it better |

## Learning and Development with Vue.js

### Learning Phase

I started learning Vue from a basic, high-level black box perspective, assuming that Vue is just a client-side JavaScript framework that helps in creating different components on a web page. [Vue in 100 Seconds](https://www.youtube.com/watch?v=nhBVL41-_Cw) explains Vue in under 100 seconds.

Moving ahead, I usually open the documentation of a framework, but when I was going through it, I felt that this documentation is not beginner-friendly. It assumes that a person who knows a framework before should be able to catch up quickly because it did not explain "what is a module," even though it is just an alias of a component. So, I started looking for a quick crash course on YouTube because it's free: [Vue Crash Course](https://www.youtube.com/watch?v=qZXt1Aom3Cs&t=251s), [Vue.js Full Course](https://www.youtube.com/playlist?list=PLRAV69dS1uWTpHQgiV4rZFlnuS8XDl71A).

With the videos, I was also looking at the documentation, and now that was making sense to me: [Vue Documentation](https://vuejs.org/guide/introduction.html).

What did I learn from tutorials and documentation?

- What is a component/module ([Component Basics](https://vuejs.org/guide/essentials/component-basics.html))
- Best practices for creating components ([Vue Style Guide](https://v2.vuejs.org/v2/style-guide/?redirect=true))
- How to create a Vue application (I am using Vite here) ([Application Essentials](https://vuejs.org/guide/essentials/application.html))
- What is Template syntax ([Template Syntax](https://vuejs.org/guide/essentials/template-syntax.html))
- Conditional rendering is important ([Conditional Rendering](https://vuejs.org/guide/essentials/conditional.html))
- Other directives like v-for, v-model, :ref for referencing, and other good stuff...

I ended up watching so many tutorials and falling into the tutorial hell for 5 days. Now I have a basic fundamental knowledge of Vue; I can start implementation now.

### Development Phase

I was using Visual Studio Code as my IDE ([VS Code](https://code.visualstudio.com)).

There are some extensions which I used for development in Vue - [Vuter](https://marketplace.visualstudio.com/items?itemName=yoyo930021.vuter).

Next up is a development tool by Vue which helps in deep debugging (installed as an extension to Google Chrome) - [Vue DevTools](https://devtools.vuejs.org/).

I took some time from my morning assignment completing routing to brainstorm ideas for my project and came up with a simple idea to make a To-Do application with some level of difficulty to add categories like Personal, Work, Health, etc., for each To-Do task.

Once I fixed what To-Do in the project, I created a sketch of how I want my application to look like with the help of pen and paper.

## wireframe
 <img alt="add task gif" style="height:400px; width:250px;" src="https://github.com/kapish-patel/Web-Development/blob/main/Project%20/Demos/Wireframe%20sketch.jpg"/>
<br>

Finally, I started coding by creating an application using [Vite](https://vitejs.dev).

Basically, Vite creates a template project to jumpstart it.

Using best practices provided above, I created different components and added basic HTML and CSS content to make a high-fidelity look of the application.

Initially, I was using props to pass data into different components, but this quickly became messy, and I was not able to keep my "time machine" (hard to keep track of variables) active for a long time. So, I thought of using Vuex, which is a state management library.

To learn, I used a lot of references, some of them in the Documentation [Vuex Documentation](https://vuex.vuejs.org/) and videos [Vuex Video Tutorial](https://www.youtube.com/watch?v=5lVQgZzLMHc&t=810s). I also asked ChatGPT for some basic file structure and how I should design my code for easy understanding and to avoid writing a lot of code.

After setting up the store, it was pretty simple to use the state variables in different components, and Vue DevTools also works well with Vuex and helps in tracking state variables.

Initially, I completed some functionality like displaying data, manipulating data, deleting data, but when I came across adding new data, I faced a problem where I had the add button in one component, and I wanted to add data into a totally different component. In other words, my add button was in a grandparent component, and I wanted to add data into a grandchild component.

**Solution**: ChatGPT, because it is the ultra-max pro Revolutionary Cutting Edge High-end tool for general purposes. I use it wisely to learn, generate ideas, and troubleshoot problems so that I can spot my mistakes quickly and easily. I copied and pasted my code into the prompt and asked to spot mistakes. It turned out that I was not using the commit function, which takes a function name defined in the store and parameters of that function. I was directly using the function instead of using the commit function, which ensures proper updating of the mutation.

Next up was using Vue Router, which helps in routing the application. It was pretty simple to use, only two tags:
- router-link: used for sending user requests to a different URL
- router-view: used for displaying components based on the URL
Documentation was enough to use Vue Router [Vue Router Documentation](https://router.vuejs.org/guide/).

At the end of the project, I like to beautify it, so I used a lot of tools that helped me in styling components, backgrounds, fonts, icons:
- Google Fonts: [Google Fonts](https://fonts.google.com/)
- SVG Backgrounds: [SVG Backgrounds](https://www.svgbackgrounds.com/set/free-svg-backgrounds-and-patterns/)
- Canva Logo Maker: [Canva Logo Maker](https://www.canva.com/create/logos/)
- CSS Tricks: [CSS Tricks](https://css-tricks.com/)
- Icons: [Font Awesome](https://fontawesome)
- color pallets: [Color hunt](https://colorhunt.co/) 
