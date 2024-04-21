import { Controller } from "@hotwired/stimulus"

// const event = new CustomEvent("swipe");
// window.dispatchEvent(event);

let touchstartX = 0
let touchendX = 0

// Connects to data-controller="swiper"
export default class extends Controller {


  static targets = ['slideElement', 'multidotContainerElement', 'multidotElement', 'rightElement', 'leftElement', 'slidesContainerElement']

  connect() {
    if (this.hasSlidesContainerElementTarget) {
      this.slideElementTargets.length > 0 ? this.slidesContainerElementTarget.classList.remove('hidden') : this.slidesContainerElementTarget.classList.add('hidden')
    }
    this.multidotElementTargets.forEach((dot) => dot.remove())
    for(let i = 0; i < this.slideElementTargets.length; i++) {
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
    if ((touchendX < touchstartX) && (index < slideArray.length - 1)) {
      this.changeSlide("left", slide, slideArray, index)
    }
    if ((touchendX > touchstartX) && (index > 0)) {
      this.changeSlide("right", slide, slideArray, index)
    }
  }

  changeSlide(direction, slide, slideArray, index) {
    let newIndex = index

    if (direction == "left") {
      newIndex += 1
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
      newIndex -= 1
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

    this.selectDot(newIndex)
  }

  prev() {
    const slide = this.slideElementTargets.find((slide) => !slide.classList.contains('hidden'))
    const index = this.slideElementTargets.indexOf(slide) - 1
    this.changeSlide('left',slide ,this.slideElementTargets, index - 1)
    this.rightElementTarget.classList.remove('hidden')
    if (index < 1) {this.leftElementTarget.classList.add('hidden')}
  }

  next() {
    const slide = this.slideElementTargets.find((slide) => !slide.classList.contains('hidden'))
    const index = this.slideElementTargets.indexOf(slide) + 1
    this.changeSlide('right',slide ,this.slideElementTargets, index + 1)
    this.leftElementTarget.classList.remove('hidden')
    if (index === this.slideElementTargets.length - 1) {this.rightElementTarget.classList.add('hidden')}
  }

  selectDot(index) {
    this.multidotElementTargets.forEach((dot, i) => {
      if (dot.classList.contains('dark-dot')) {dot.classList.remove('dark-dot')}
      if (i === index) {dot.classList.add('dark-dot')}
    });
  }

  showSlidesContainer() {
    this.hasSlidesContainerElementTarget && this.slidesContainerElementTarget.classList.remove('hidden')
  }
}
