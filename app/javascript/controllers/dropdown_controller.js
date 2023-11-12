import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="dropdown"
export default class extends Controller {
  connect() {
    console.log('dropdown')
  }

  static targets = ["dropdownContent", "dropdownBlocker"]

  openDropdown() {
    this.dropdownContentTarget.classList.add("show");
    this.dropdownBlockerTarget.classList.add("show");
  }

  closeDropdown() {
    this.dropdownContentTarget.classList.remove("show");
    this.dropdownBlockerTarget.classList.remove("show");
  }
}
