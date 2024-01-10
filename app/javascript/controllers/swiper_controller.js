import { Controller } from "@hotwired/stimulus"

// const event = new CustomEvent("swipe");
// window.dispatchEvent(event);

let touchstartX = 0
let touchendX = 0

// Connects to data-controller="swiper"
export default class extends Controller {


  static targets = ['slideElement', 'multidotElement']

  connect() {
    // this.slideElementTargets.forEach(this.swipe)
    for(let i = 0; i < this.slideElementTargets.length; i++) {
      let slide = this.slideElementTargets[i]
      this.swipe(slide, this.slideElementTargets, i)
    }
  }

  swipe = (slide, slideArray, index) => {
    let dots = this.multidotElementTargets

    slide.addEventListener('touchstart', e => {
      touchstartX = e.changedTouches[0].screenX
    });

    slide.addEventListener('touchend', e => {
      touchendX = e.changedTouches[0].screenX
      checkDirection(slide, slideArray, dots, index)
    });

    function checkDirection(slide, slideArray, dots, index) {
      if ((touchendX < touchstartX) && (index + 1 < slideArray.length)) {
        changeSlide("left", slide, slideArray, dots, index)
      }
      if ((touchendX > touchstartX) && (index > 0)) {
        changeSlide("right", slide, slideArray, dots, index)
      }
    }

    function changeSlide (direction, slide, slideArray, dots, index) {

      dots.forEach(selectDot)

      function selectDot(item) {
        if (item.classList.contains("dark-dot")) {
          item.classList.remove("dark-dot");
        } else {
          item.classList.add("dark-dot");
        };
      }

      if (direction == "left") {
        slide.classList.add("slide-out-left");
        slideArray[index + 1].classList.add("slide-in-left");

        setTimeout(() => {
          slide.classList.add("hidden");
          slide.classList.remove("slide-out-left");
          slideArray[index + 1].classList.remove("hidden");
        }, 400);

        setTimeout(() => {
          slideArray[index + 1].classList.remove("slide-in-left")
        }, 1000);

      } else {
        slide.classList.add("slide-out-right");
        slideArray[index - 1].classList.add("slide-in-right");

        setTimeout(() => {
          slide.classList.add("hidden");
          slide.classList.remove("slide-out-right");
          slideArray[index - 1].classList.remove("hidden");
        }, 400);

        setTimeout(() => {
          slideArray[index - 1].classList.remove("slide-in-right")
        }, 1000);
      }
    }
  }
  selectDot(item) {
    console.log('dot')
    if (item.classList.contains("dark-dot")) {
      item.classList.remove("dark-dot");
    } else {
      item.classList.add("dark-dot");
    };
  }

}
