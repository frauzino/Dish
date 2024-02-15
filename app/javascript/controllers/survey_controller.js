import { Controller } from "@hotwired/stimulus"

const skyBiometryUrlDetect = 'https://api.skybiometry.com/fc/faces/detect.json'
const luxandUrlAddPhoto = "https://api.luxand.cloud/photo"

// Connects to data-controller="survey"
export default class extends Controller {

  static values = {
    skybioApiKey: String,
    skybioSecretKey: String,
    luxandApiKey: String
  }

  static targets = ["questionElement", "surveyElement", "progressBarElement", "buttonElement", "imageElement", "blockerElement", 'imageInputElement', 'errorMessageElement', 'hiddenInputElement']

  connect() {
  }

  // Detect if selected image has a face, before continuing with the dish report and associating photo with this survey
  async faceDetect() {
    const [file] = this.imageInputElementTarget.files
    const formData = new FormData();
    const changeImageEvent = event

    formData.append("api_key", this.skybioApiKeyValue)
    formData.append("api_secret", this.skybioSecretKeyValue)
    formData.append("attributes", "all")
    formData.append("file", file)

    const data = await fetch(skyBiometryUrlDetect, {
      method: "POST",
      body: formData
    })
    .then(res => res.json())

    const faceExists = data.photos[0].tags[0] ? true : false

    faceExists ? [this.radioChecked(changeImageEvent), this.addPhoto(), this.errorMessageElementTarget.classList.add('hidden')] : [this.radioChecked(changeImageEvent, "disable"), this.errorMessageElementTarget.classList.remove('hidden')]
    this.radioChecked(changeImageEvent)
  }

  // Adds photo to Luxand cloud database for face recognition functionality
  async addPhoto() {
    const [file] = this.imageInputElementTarget.files
    const headers = {
      "token": this.luxandApiKeyValue
    }
    const formData = new FormData();
    formData.append('photo', file)

    const data = await fetch(luxandUrlAddPhoto, {
      method: 'POST',
      headers: headers,
      body: formData
    })
    .then(response => response.json())
    .catch(error => console.log('error', error))

    const uuid = data.uuid
    this.hiddenInputElementTarget.value = uuid
    console.log('addPhoto Input element', this.hiddenInputElementTarget)
  }

  radioChecked(backupEvent, disable = false) {
    const liveEvent = event ? event : backupEvent
    for (let i = 0; i < this.questionElementTargets.length; i++) {
      if (liveEvent.target.dataset.index == i) {
        disable === false ? this.buttonElementTargets[i].classList.remove("button-disabled") : this.buttonElementTargets[i].classList.add("button-disabled")
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
