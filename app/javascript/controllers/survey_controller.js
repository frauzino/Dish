import { Controller } from "@hotwired/stimulus"

const luxandUrlAddPhoto = "https://api.luxand.cloud/photo"
const googleVisionApi = "https://vision.googleapis.com/v1/images:annotate"

// Connects to data-controller="survey"
export default class extends Controller {

  static values = {
    luxandApiKey: String,
    googleApiKey: String
  }

  static targets = ["questionElement", "surveyElement", "progressBarElement", "buttonElement", "imageElement", "blockerElement", 'imageInputElement', 'errorMessageElement', 'hiddenInputElement']

  connect() {
  }

  // Detect if selected image has a face, before continuing with the dish report and associating photo with this survey
  async faceDetect() {

    this.buttonLoading();
    const changeImageEvent = event
    const [file] = this.imageInputElementTarget.files
    const fileTypeError = 'Please ensure the uploaded image is of file type .jpg, .jpeg, or .png'
    const noFaceError = 'Please ensure your screenshot matches the example above, including a clear view of the face, and some descriptive text.'

    if (this.checkFileType(file)) {  // disables next button and shows user an error if wrong file format
      this.errorMessageElementTarget.classList.add('hidden')
    } else {
      this.errorMessageElementTarget.innerHTML = fileTypeError
      this.radioChecked(changeImageEvent, "disable")
      this.errorMessageElementTarget.classList.remove('hidden')
      return
    }

    const reader = new FileReader(); // turns image into a base64 string and removes path for Google Vision API
    reader.onload = function(event) {
      var base64String = event.target.result;
      base64String = base64String.substring(base64String.indexOf(",") + 1)
      sendBase64ToAPI(base64String)
    };
    reader.readAsDataURL(file)

    const sendBase64ToAPI = async (base64String) => {
      const googleUrl = `${googleVisionApi}?key=${this.googleApiKeyValue}`

      const data = await fetch(googleUrl, { // calls Google Vision API to check for face and text in uploaded image
        method: "POST",
        headers: {
          "Content-Type": 'application/json'
        },
        body: JSON.stringify({
          "requests": [
            {
              "image": {
                "content": base64String
              },
              "features": [
                {
                  "maxResults": 5,
                  "type": "FACE_DETECTION"
                },
                {
                  "type": "TEXT_DETECTION"
                }
              ]
            }
          ]
        })
      })
      .then(res => res.json())

      const faceExists = data.responses[0].faceAnnotations ? true : false
      const textExists = data.responses[0].textAnnotations ? true : false

      this.buttonFinishedLoading();
      // disables next button and shows user an error if image doesn't contain face or text
      faceExists && textExists ? [this.radioChecked(changeImageEvent), this.errorMessageElementTarget.classList.add('hidden')] : [this.radioChecked(changeImageEvent, "disable"), this.errorMessageElementTarget.innerHTML = noFaceError, this.errorMessageElementTarget.classList.remove('hidden')]
    }
  }

  checkFileType(file) { // Checks if file is acceptable format for upload to luxand
    const fileName = file.name
    const ext = fileName.slice(((fileName.lastIndexOf(".") - 1) >>> 0) + 2)
    if (['jpg', 'jpeg', 'png', ].includes(ext)) {return true}
  }

  // Adds photo to Luxand cloud database for face recognition functionality
  async addPhoto() {
    const [file] = this.imageInputElementTarget.files
    const headers = {
      "token": this.luxandApiKeyValue
    }
    const formData = new FormData();
    formData.append('photo', file)

    await fetch(luxandUrlAddPhoto, {
      method: 'POST',
      headers: headers,
      body: formData
    })
    .then(response => response.json())
    .then(data => this.hiddenInputElementTarget.value = data.uuid)
    .catch(error => console.log('error', error))
  }

  radioChecked(backupEvent, disable = false) { // decides state of "next" button after image change event, enabled or disabled
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

  progress(index) { // updates progress bar
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

  async submit() {
    event.preventDefault()
    this.progress(this.questionElementTargets.length - 1);
    await this.addPhoto()
    this.surveyElementTarget.submit()
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

  buttonLoading() {
    this.buttonElementTargets[0].classList.add('loading')
    this.buttonElementTargets[0].innerHTML = 'Loading'
  }

  buttonFinishedLoading() {
    this.buttonElementTargets[0].classList.remove('loading')
    this.buttonElementTargets[0].innerHTML = 'Next'
  }
}
