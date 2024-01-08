import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="leaderboard"
export default class extends Controller {

  static targets = ['indivPanelElement', 'schoolPanelElement', 'multidotElement']

  connect() {
  }

  showIndivs() {
    this.schoolPanelElementTarget.classList.add('hidden');
    this.indivPanelElementTarget.classList.remove('hidden');
    this.multidotElementTargets.forEach(this.selectDot);
  }

  showSchools() {
    this.indivPanelElementTarget.classList.add('hidden');
    this.schoolPanelElementTarget.classList.remove('hidden');
    this.multidotElementTargets.forEach(this.selectDot)
  }

  selectDot(item) {
    if (item.classList.contains("dark-dot")) {
      item.classList.remove("dark-dot");
    } else {
      item.classList.add("dark-dot");
    };
  }
}
