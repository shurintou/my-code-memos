// These are instances of axios using interceptors.
import request from './request'

export function aNewPostApi(data) {
    return request({
        url: '/youApiPath',
        method: 'post',
        data: data
    })
}

export function aNewGetApi(params) {
    return request({
        url: '/youApiPath',
        method: 'get',
        params: params
    })
}

//Import the instance of axios below and then you can use it with something like,
/* aNewPostApi(requestDtoObject).then(res => {

    }) 
    .catch(error => {
        
    })
    .finally(() => {

    })
*/