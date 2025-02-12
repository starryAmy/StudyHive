document.addEventListener("DOMContentLoaded", function() {
  const loadMorebtn = document.getElementById("load-more");
  if (loadMorebtn) {
    loadMorebtn.addEventListener("click", function() {
      // get current page which is stored in attribute of elements
      let page = parseInt(this.getAttribute("data-page")) + 1;
      // send AJAX request
      fetch(`/desks?page=${page}`, {
        headers: { "X-Requested-With": "XMLHttpRequest", "Accept": "text/javascript" }
      })
      .then(response => response.text()) //return HTML
      .then(html => {
        console.log(html);
        document.getElementById("desk-room-container").insertAdjacentHTML("beforeend", html);
        this.setAttribute("data-page", page); //set new value to the attribute of this button
      })
    })
  }
})
