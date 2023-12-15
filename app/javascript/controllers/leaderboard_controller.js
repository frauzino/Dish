import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="leaderboard"
export default class extends Controller {

  static targets = ['indivPanelElement', 'schoolPanelElement']

  connect() {
  }

  showIndivs() {
    this.schoolPanelElementTarget.classList.add('hidden');
    this.indivPanelElementTarget.classList.remove('hidden');
  }

  showSchools() {
    this.indivPanelElementTarget.classList.add('hidden');
    this.schoolPanelElementTarget.classList.remove('hidden');
  }
}
