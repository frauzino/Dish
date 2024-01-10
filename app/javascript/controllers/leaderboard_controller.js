import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="leaderboard"
export default class extends Controller {

  static targets = ['indivPanelElement', 'schoolPanelElement', 'multidotElement', 'leftElement', 'rightElement']

  connect() {
  }

  showIndivs() {
    this.schoolPanelElementTarget.classList.add('slide-out-right');
    this.indivPanelElementTarget.classList.add('slide-in-right');

    this.leftElementTarget.classList.add('hidden')
    this.rightElementTarget.classList.remove('hidden')

    this.multidotElementTargets.forEach(this.selectDot);

    setTimeout(() => {
      this.schoolPanelElementTarget.classList.add('hidden');
      this.schoolPanelElementTarget.classList.remove('slide-out-right');
      this.indivPanelElementTarget.classList.remove('hidden');
    }, 400);

    setTimeout(() => {
      this.indivPanelElementTarget.classList.remove('slide-in-right');
    }, 1000);
  }

  showSchools() {
    this.indivPanelElementTarget.classList.add('slide-out-left');
    this.schoolPanelElementTarget.classList.add('slide-in-left');

    this.rightElementTarget.classList.add('hidden')
    this.leftElementTarget.classList.remove('hidden')

    this.multidotElementTargets.forEach(this.selectDot)

    setTimeout(() => {
      this.indivPanelElementTarget.classList.add('hidden');
      this.indivPanelElementTarget.classList.remove('slide-out-left');
      this.schoolPanelElementTarget.classList.remove('hidden');
    }, 400);

    setTimeout(() => {
      this.schoolPanelElementTarget.classList.remove('slide-in-left');
    }, 1000);
  }

  selectDot(item) {
    if (item.classList.contains("dark-dot")) {
      item.classList.remove("dark-dot");
    } else {
      item.classList.add("dark-dot");
    };
  }
}
