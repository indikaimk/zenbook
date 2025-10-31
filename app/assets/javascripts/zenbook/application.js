//= require rails-ujs
//= require activestorage
//= require turbolinks
//= require_tree .

document.addEventListener("turbolinks:load", function() {
  const tocButton = document.querySelector(".toc-button");
  const tocDropdown = document.querySelector(".toc-dropdown");

  if (tocButton && tocDropdown) {
    tocButton.addEventListener("click", function(event) {
      event.preventDefault();
      tocDropdown.classList.toggle("open");
    });
  }
});
