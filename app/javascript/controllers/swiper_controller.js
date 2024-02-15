import { Controller } from "@hotwired/stimulus"

// const event = new CustomEvent("swipe");
// window.dispatchEvent(event);

let touchstartX = 0
let touchendX = 0

// Connects to data-controller="swiper"
export default class extends Controller {


  static targets = ['slideElement', 'multidotContainerElement', 'multidotElement', 'rightElement', 'leftElement']

  connect() {
    // this.slideElementTargets.forEach(this.swipe)
    for(let i = 0; i < this.slideElementTargets.length; i++) {
      // i > 0 ? [slide.classList.add('hidden'), this.rightElementTarget.classList.remove('hidden')] : ''
      this.multidotContainerElementTarget.innerHTML += '<div class="multi-dot" data-swiper-target="multidotElement"></div>'
      this.multidotElementTargets[0].classList.add('dark-dot')
      let slide = this.slideElementTargets[i]
      if (i > 0) {
        slide.classList.add('hidden'),
        this.rightElementTarget.classList.remove('hidden')
        this.multidotContainerElementTarget.classList.remove('hidden')
      }
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
      this.checkDirection(slide, slideArray, dots, index)
    });
  }

  checkDirection(slide, slideArray, dots, index) {
    if ((touchendX < touchstartX) && (index + 1 < slideArray.length)) {
      this.changeSlide("left", slide, slideArray, dots, index)
    }
    if ((touchendX > touchstartX) && (index > 0)) {
      this.changeSlide("right", slide, slideArray, dots, index)
    }
  }

  changeSlide(direction, slide, slideArray, dots, index) {
    console.log('change index', index)

    dots.forEach(this.selectDot)

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

  prev() {
    const slide = this.slideElementTargets.find((slide) => !slide.classList.contains('hidden'))
    const index = this.slideElementTargets.indexOf(slide) - 1
    this.changeSlide('left',slide ,this.slideElementTargets ,this.multidotElementTargets, index - 1)
    this.rightElementTarget.classList.remove('hidden')
    if (index < 1) {this.leftElementTarget.classList.add('hidden')}
  }

  next() {
    const slide = this.slideElementTargets.find((slide) => !slide.classList.contains('hidden'))
    const index = this.slideElementTargets.indexOf(slide) + 1
    console.log('slide', slide)
    console.log('clicked index', index)
    console.log('length', this.slideElementTargets.length)
    this.changeSlide('right',slide ,this.slideElementTargets ,this.multidotElementTargets, index + 1)
    this.leftElementTarget.classList.remove('hidden')
    if (index === this.slideElementTargets.length - 1) {this.rightElementTarget.classList.add('hidden')}
  }

  selectDot(item) {
    if (item.classList.contains("dark-dot")) {
      item.classList.remove("dark-dot");
    } else {
      item.classList.add("dark-dot");
    };
  }

}
