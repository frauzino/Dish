import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="badges"
export default class extends Controller {

  static targets = ["badgeElement"]

  connect() {
    console.log('hello badges')

    console.log(this.badgeElementTargets[0])
  }
}
