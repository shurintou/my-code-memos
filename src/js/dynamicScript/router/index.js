/* 
This is not a normal example.
I happend to meet this case, which I got some static html templates(with custom scripts and css imported)
and those custom scripts are mainly dealing with dom animation.
Then, these static templates are going to be transferred to Vue.js template,
but scripts in them can't not be modified.(well, according to some responsibility issue) 

So, what I do was, transferred each static templates to a Vue.js templatem(component),
then wrote something like this in router/index.js.
*/

//This is a part of the entire router/index.js code.
import Vue from 'vue' //2.6.11
import VueRouter from 'vue-router' //3.2.0

Vue.use(VueRouter)

const routers = [
    //transferred components
]

const router = new VueRouter({
    mode: 'history',
    routers    
})

let hasRoutered = false
router.afterEach((to,from) => {
    if(hasRoutered){ //In my case, the first time of router need not to load the script
        var oldScriptDom = document.getElementById('my_script')
        var parent = oldScriptDom.parentElement
        parent.removeChild(oldScriptDom) // remove the old script dom before insert a new one
        var scriptDom = document.createElement('script')
        scriptDom.setAttribute('type', 'text/javascript')
        document.body.appendChild(scriptDom)
        scriptDom.setAttribute('src', responseSrc)
        scriptDom.setAttribute('id', 'my_script')
        return
    }   
    hasRoutered = true
})

