function detectDevTools() {
    let currentTimestamp = new Date().getTime()
    const intervalTimer = setInterval(() => {
        debugger
        const newTimestamp = new Date().getTime()
        if (newTimestamp - currentTimestamp > 120) {
            clearInterval(intervalTimer)
            window.open('about:blank', '_self')
        }
        else {
            currentTimestamp = newTimestamp
        }
    }, 100)
}