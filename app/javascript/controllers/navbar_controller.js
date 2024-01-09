import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="navbar"
export default class extends Controller {

  static targets = ['logoElement', "navbarElement"]

  connect() {
    console.log(this.logoElementTarget)
    window.onscroll = () => {showLogo(this.logoElementTarget, this.navbarElementTarget)}

    function showLogo(logo,navbar) {
      if (window.pageYOffset > 740 ) {
        logo.classList.remove('hidden');
        logo.classList.add('fade-in');
        navbar.classList.add('bg-offwhite')
      } else {
        logo.classList.remove('fade-in');
        logo.classList.add('hidden');
        navbar.classList.remove('bg-offwhite');
      }
    }
  }

}
