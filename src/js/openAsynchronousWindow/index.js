/**
 * Returns a reference to the window object that opened immediately after the user's click.   
 * 
 * @description - call back function way
 * @callback callBackFunc  
 * @param {object} openedWindow - A reference to the window object.
 * @param {object} error - Errors being created and thrown during execution.
 * 
 * @param {string} windowName - Same as the parameter windowName of the window.open()
 * @param {string} windowFeatures - Same as the parameter windowFeatures of the window.open()
 * @param {function} callBackFunc - The call back function that handle the window object.
 * 
 * @description - promise way 
 * @param {object} paramObj - A wrapper object that has properties of windowName and windowFeatures.
 * @returns {promise} - A promise that contains the reference to the window object.
 * 
 */

function openAsynchronousWindow(...args) {
    let openedWindow = null
    if (arguments.length === 3) {
        let callBackFunc = args[2]
        if (typeof callBackFunc === 'function') {
            try {
                openedWindow = window.open('', args[0], args[1])
                callBackFunc(openedWindow, null)
            }
            catch (error) {
                callBackFunc(openedWindow, error)
            }
        }
        else {
            console.error('If you want to use openAsynchronousWindow as the call back function way, the third parameter need to be a function.')
        }
    }
    else if (arguments.length === 1) {
        let paramObj = args[0]
        return new Promise((resolve, reject) => {
            if (typeof paramObj === 'object') {
                try {
                    openedWindow = window.open('', paramObj.windowName, paramObj.windowFeatures)
                    return resolve(openedWindow)
                }
                catch (error) {
                    return reject(error)
                }
            }
            else {
                return reject('If you want to use openAsynchronousWindow as the promise way, parameters need to be wrapped as an object.')
            }
        })
    }
    else{
        console.error('The length of arguments should be 1(promise way) or 3(call back function way).')
    }
}