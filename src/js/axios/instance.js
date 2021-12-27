// These are instances of axios not using interceptors.
import axios from 'axios'

//pattern 1
axios.get('/user?ID=12345')
    .then(res => {
    })
    .catch(error => {
    })
    .always(() => {
    })

//pattern2, same as pattern1
axios.get('/user', {
    params: {
        ID: 12345
    }
})
    .then(res => {
    })
    .catch(error => {
    })
    .always(() => {
    })

//pattern3, same as pattern1,2
axios({
    url: '/user',
    method: 'get',
    params: {
        ID: 12345
    }
})
    .then(res => {
    })
    .catch(error => {
    })
    .always(() => {
    })


//pattern4, Create a new instance then send a request
axios.create()({
    url: '',
    method: 'post',
    headers: {
        'X-CSRF-TOKEN': ''
    },
    data: {

    }
})

