function load() {

    /* Set the autocomplete property from sessionStorage */
    let selectDom = document.getElementById('auto_complete')
    let autocompleteVal = sessionStorage.getItem('autocomplete_value')
    selectDom.selectedIndex = sessionStorage.getItem('autocomplete_index')
    document.querySelectorAll('input').forEach(dom => dom.autocomplete = autocompleteVal)



    /* Set the description in the html */
    let newText = document.createElement('span')
    if (!document.getElementById(document.title).checked) {
        newText.innerText = "but it's not. Because the checked property was auto completed. Try change the autocomplete property to be 'off' ."
        newText.style.color = 'red'
    }
    else{
        newText.innerText = "and it is."
        if(history.length == 1){
            newText.innerText += " You may now click pageA(B) to redirect to another page."
        }
        else{
            if(autocompleteVal !== 'off'){
                newText.innerText += " Try history back with browser back button."
            }
        }
        newText.style.color = 'green'
    }
    document.body.appendChild(newText)

}

function select(event){
    let selectDom = event.target
    sessionStorage.setItem('autocomplete_index', selectDom.selectedIndex)
    sessionStorage.setItem('autocomplete_value', selectDom.options[selectDom.selectedIndex].value)
    let newText = document.createElement('p')
    newText.innerText = "Autocomplete property has been changed, because the new property would only be applied to new history, so try click pageA(B) several times to make some histories :)"
    document.body.appendChild(newText)
}

