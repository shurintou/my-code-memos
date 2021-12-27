import axios from 'axios'
// import {getToken} from './cookie'  // cookie library
// import router from '../router/' // router

const request = axios.create({ //create an instance using interceptors
    baseURL: '',
    timeout: 0, // ms, 0 is intinite
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
    error => Promise.reject(error)
)

export default request