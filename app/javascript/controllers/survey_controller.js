import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="survey"
export default class extends Controller {
  connect() {
    console.log('hello survey');
  }
}
