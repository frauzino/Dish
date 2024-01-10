import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="navbar"
export default class extends Controller {

  static targets = ['logoElement', "navbarElement"]

  connect() {
    window.onscroll = () => {showLogo(this.logoElementTargets, this.navbarElementTargets)}

    function showLogo(logos, navbars) {
      if (window.pageYOffset > 740 ) {
        logos.forEach(function(logo) {
          logo.classList.remove('hidden')
          logo.classList.add('fade-in')
        })
        navbars.forEach(function(navbar) {
          navbar.classList.add('bg-offwhite')
        })
      } else {
        logos.forEach(function(logo) {
          logo.classList.remove('fade-in')
          logo.classList.add('hidden')
        })
        navbars.forEach(function(navbar) {
          navbar.classList.remove('bg-offwhite')
        })
      }
    }
  }

}
