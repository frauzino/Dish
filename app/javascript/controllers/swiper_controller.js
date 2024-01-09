import { Controller } from "@hotwired/stimulus"

// const event = new CustomEvent("swipe");
// window.dispatchEvent(event);

let touchstartX = 0
let touchendX = 0

// Connects to data-controller="swiper"
export default class extends Controller {


  static targets = ['slideElement']

  connect() {
    // this.slideElementTargets.forEach(this.swipe)
    for(let i = 0; i < this.slideElementTargets.length; i++) {
      let slide = this.slideElementTargets[i]
      this.swipe(slide, this.slideElementTargets, i)
    }
  }

  swipe(slide, slideArray, index) {

    slide.addEventListener('touchstart', e => {
      touchstartX = e.changedTouches[0].screenX
    });

    slide.addEventListener('touchend', e => {
      touchendX = e.changedTouches[0].screenX
      checkDirection(slide, slideArray, index)
    });

    function checkDirection(slide, slideArray, index) {
      if (touchendX < touchstartX && index < slideArray.length) {
        console.log('swiped left!')
        changeSlide("left", slide, slideArray, index)
      }
      if (touchendX > touchstartX && index > 0) {
        console.log('swiped right!')
        changeSlide("right", slide, slideArray, index)
      }
    }

    function changeSlide(direction, slide, slideArray, index) {
      if (direction == "left") {
        slide.classList.add("slide-out-left");
        slideArray[index + 1].classList.add("slide-in-left");
        console.log('left')

        setTimeout(() => {
          slide.classList.add("hidden");
          slideArray[index + 1].classList.remove("hidden");
        }, 400);

      } else {
        slide.classList.add("slide-out-right");
        slideArray[index - 1].classList.add("slide-in-right");
        console.log('right')

        setTimeout(() => {
          slide.classList.add("hidden");
          slideArray[index - 1].classList.remove("hidden");
        }, 400);
      }
    }
  }
}
