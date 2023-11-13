import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="survey"
export default class extends Controller {

  static targets = ["surveyElement"]

  // connect() {
  //   this.surveyElementTargets[0].classList.remove("hidden");
  //   this.surveyElementTargets[0].classList.add("show");
  //   console.log('test');
  // }

  next() {
    for(let i = 0; i < this.surveyElementTargets.length; i++ ) {
      if (event.target.id == `next${i}`) {
        this.surveyElementTargets[i].classList.add("hidden");

        this.surveyElementTargets[i+1].classList.remove("hidden");
        break;
      };
    }
  }
}
