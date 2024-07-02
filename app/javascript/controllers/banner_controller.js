import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="banner"
export default class extends Controller {

  static targets = [ "scrollingText" ]

  connect() {
    this.scrollText()
  }

  scrollText() {
    let textArray = this.scrollingTextTarget.innerText.split(',')
    let currentIndex = 1
    this.scrollingTextTarget.innerText = textArray[0]
    this.scrollingTextTarget.classList.add('english-violet');

    setInterval(() => {
      if (currentIndex === 1) {
        this.scrollingTextTarget.classList.add('slide-out-top');
      }
        this.scrollingTextTarget.classList.replace('slide-in-bottom', 'slide-out-top');

      setTimeout(() => {
        let newText = textArray[currentIndex]
        this.scrollingTextTarget.innerText = newText
        this.setColor(currentIndex)
        this.scrollingTextTarget.classList.replace('slide-out-top', 'slide-in-bottom');
        currentIndex = (currentIndex + 1) % textArray.length
      }, 450);

      // setTimeout(() => {
      //   this.scrollingTextTarget.classList.replace('slide-in-bottom', 'slide-out-top');
      // }, 3000);
    }, 3000);
  }

  setColor(index) {
    this.scrollingTextTarget.classList.remove('english-violet', 'gold-yellow', 'purple', 'pale-blue');
    switch(index) {
      case 0:
        this.scrollingTextTarget.classList.add('english-violet');
        break;
      case 1:
        this.scrollingTextTarget.classList.add('gold-yellow');
        break;
      case 2:
        this.scrollingTextTarget.classList.add('purple');
        break;
      default:
        this.scrollingTextTarget.classList.add('pale-blue');
    };
  };
}
