import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="alert"
export default class extends Controller {

  static targets = ['alertPanelElement', 'closeElement']

  connect() {
  }

  closePanel() {
    this.alertPanelElementTarget.classList.add('animated');
    this.alertPanelElementTarget.classList.add('slide-out-bottom');

    setTimeout(() => {
      this.alertPanelElementTarget.classList.add('hidden');
    }, 400);
  }
}
