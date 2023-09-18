import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="tasks"
export default class extends Controller {
  connect() {
    console.log("jdhkjd")
  }

  toggle(e) {
    const id = e.target.dataset.id
    const csrfToken = document.querySelector("[name='csrf-token']").content

    fetch(`/tasks/${id}/toggle`, {
        method: 'POST', // *GET, POST, PUT, DELETE, etc.
        mode: 'cors', // no-cors, *cors, same-origin
        cache: 'no-cache', // *default, no-cache, reload, force-cache, only-if-cached
        credentials: 'same-origin', // include, *same-origin, omit
        headers: {
            'Content-Type': 'application/json',
            'X-CSRF-Token': csrfToken
        },
        body: JSON.stringify({ completed: e.target.checked }) // body data type must match "Content-Type" header
    })
      .then(response => response.json())
      .then(data => {
         alert(data.message)
       })
  } 


  search() {
    clearTimeout(this.timeout)
    this.timeout = setTimeout(() => {
      this.element.requestSubmit()
    }, 200)
  }


  delete(event){
    
    const id = event.target.dataset.id;
    const csrfToken = document.querySelector("[name='csrf-token']").content
    fetch(`/tasks/${id}`,{
      method: 'DELETE',
      mode: 'cors', // no-cors, *cors, same-origin
      cache: 'no-cache', // *default, no-cache, reload, force-cache, only-if-cached
      credentials: 'same-origin', // include, *same-origin, omit
      headers: {
          'Content-Type': 'application/json',
          'X-CSRF-Token': csrfToken
      }
    })
    .then(response => response.json())
    .then(data => {
        const taskElement = document.querySelector(`#task_${id}`);
        if (taskElement) {
          taskElement.remove();
        }
    });
  }

}
