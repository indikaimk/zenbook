import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  static targets = [ "tocDropdown" ]

  connect() {
    console.log("TOC controller connected")
  }


  toggle(event) {
    event.preventDefault()
    console.log("toggle menu")
    this.tocDropdownTarget.classList.toggle("open")
  }
}