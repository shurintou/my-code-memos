import axios from 'axios'
// import {getToken} from './cookie'  // cookie library
// import router from '../router/' // router

const request = axios.create({ //create an instance using interceptors
    baseURL: '',
    timeout: 0, // ms, 0 is infinite
    headers: {'X-Custom-Header': ''}
})

request.interceptors.request.use(
    config => {
        if(config.method === 'post'){
            config.headers['X-Custom-Header'] = ''
        }
        return config
    },
    error => Promise.reject(error)
)

request.interceptors.response.use(
    res => {
        if(res.headers.result === '0'){ // correct response
            return res.data
        }
        else if(res.data.code === 'error'){ //error response
            return Promise.reject('error')
        }
    },
    error => {
        if(error.code === 'ECONNABORTED' && error.message.indexOf('timeout') !== -1){
            //handle the timeout error
        }
        Promise.reject(error)
    }
)

export default request