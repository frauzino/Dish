import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="mobile-nav"
export default class extends Controller {

  static targets = ['mainMenuDrawerElement', 'userMenuDrawerElement']

  connect() {
  }

  // Open Drawers

  openMainMenuDrawer() {
    this.mainMenuDrawerElementTarget.classList.remove('hidden');
    this.mainMenuDrawerElementTarget.classList.add('drawer-open-left');
  }

  openUserMenuDrawer() {
    this.userMenuDrawerElementTarget.classList.remove('hidden')
    this.userMenuDrawerElementTarget.classList.add('drawer-open-right');
  }

  // Close Drawers

  closeMainMenuDrawer() {
    this.mainMenuDrawerElementTarget.classList.remove('drawer-open-left');
    this.mainMenuDrawerElementTarget.classList.add('drawer-close-left');

    setTimeout(() => {
      this.mainMenuDrawerElementTarget.classList.add('hidden')
      this.mainMenuDrawerElementTarget.classList.remove('drawer-close-left');
    }, 500);
  }

  closeUserMenuDrawer() {
    this.userMenuDrawerElementTarget.classList.remove('drawer-open-right');
    this.userMenuDrawerElementTarget.classList.add('drawer-close-right');

    setTimeout(() => {
      this.userMenuDrawerElementTarget.classList.add('hidden')
      this.userMenuDrawerElementTarget.classList.remove('drawer-close-right');
    }, 500);
  }
}
