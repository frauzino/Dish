import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="survey"
export default class extends Controller {

  static targets = ["questionElement", "surveyElement", "progressBarElement", "buttonElement", "imageElement", "blockerElement"]

  connect() {
  }

  radioChecked() {
    for (let i = 0; i < this.questionElementTargets.length; i++) {
      if (event.target.dataset.index == i) {
        this.buttonElementTargets[i].classList.remove("button-disabled")
      }
    }
  }

  next() {
    for(let i = 0; i < this.questionElementTargets.length; i++) {
      if (event.target.id == `next${i}`) {
        this.questionElementTargets[i].classList.add("slide-out-left");
        this.questionElementTargets[i + 1].classList.add("slide-in-left");

        setTimeout(() => {
          this.questionElementTargets[i].classList.add("hidden");
          this.questionElementTargets[i + 1].classList.remove("hidden");
        }, 500);

        this.progress(i);
        break;
      };
    };
  }

  progress(index) {
    var sections = this.questionElementTargets.length;
    var increment = 100 / sections;
    var width = (index) * increment;
    if (index == sections) {
      var targetWidth = 100;
    } else {
      var targetWidth = (index + 1) * increment;
    };
    var bar = this.progressBarElementTarget;
    setInterval(grow, 10)

    function grow() {
      if (width <= targetWidth) {
        width ++
        bar.style.width = width + "%";
      };
    }
  }

  submit() {
    this.progress(this.questionElementTargets.length - 1);
    setTimeout(() => {
      this.surveyElementTarget.submit();
    }, 500);
  }

  toggleImageSize() {
     console.log('click', this.imageElementTarget)
    if (this.imageElementTarget.classList.contains('image-grow')) {
      this.imageElementTarget.classList.remove('image-grow');
      this.blockerElementTarget.classList.add('hidden');

    } else {
      this.imageElementTarget.classList.add('image-grow');
      this.blockerElementTarget.classList.remove('hidden');
    };
  };
}
