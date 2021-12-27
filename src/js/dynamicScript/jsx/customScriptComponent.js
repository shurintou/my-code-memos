/* 
    As we know, writting any <script> tag in a Vue.js template is not allowed,
    but sometimes we do need use external scripts in vue.
    So, import dynamicScript into a Vue.js templtate with jsx would be a choice.
*/
export default {
    render(createElement){
        let self = this
        return createElement('script', {
            attrs: {
                type: 'text/javascript',
                src: this.src
            },
            on: {
                load: function(event){
                    self.$emit('load', event)
                },
                error: function(event){
                    self.$emit('error', event)
                },
                readystatechange: function(event){ //an alternative of load event
                    if(this.readyState === 'complete'){
                        self.$emit('load', event)
                    }
                }
            }
        })
    },
    props: {
        src: { type: String, required: true}
    }
}

/* 
    import CustomScript from './dynamicScript/customScriptComponent.js'
    components: {
        CustomScript
    }
*/
//Import this module as a component and then you can use it something like.
/*  
    <CustomScript v-if="res.data.src !== ''" :src="res.data.src" @load="loadHandler" @error="errorHandler"></CustomScript>

*/