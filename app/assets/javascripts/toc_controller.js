import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  // static targets = [ "questionForm" ]

  connect() {
    console.log("TOC controller connected")
  }


  toggle(event) {
    console.log("Checkbox changed, submitting form...")
    this.questionFormTarget.requestSubmit()
  }
}