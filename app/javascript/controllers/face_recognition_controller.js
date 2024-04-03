import { Controller } from "@hotwired/stimulus"

const luxandUrlSearch = "https://api.luxand.cloud/photo/search2"
const googleVisionApi = "https://vision.googleapis.com/v1/images:annotate"

// Connects to data-controller="face-recognition"
export default class extends Controller {

  static values = {
    luxandApiKey: String,
    googleApiKey: String
  }

  static targets = [
    'fileUploadElement',
    'imageElement',
    'resultsScoreElement',
    'resultsImagesContainerElement',
    'inputLabelElement',
    'searchButtonElement',
    'errorNotificationElement',
    'errorMessageElement'
  ]

  connect() {
  }

  previewImage() { //updates Dom with a preview of the search image
    this.buttonLoading()
    const [file] = this.fileUploadElementTarget.files
    const fileTypeError = 'Please ensure the uploaded image is of file type .jpg, .jpeg, or .png'

    if (file) {
      if (this.checkFileType(file)) {
        this.imageElementTarget.src = URL.createObjectURL(file)
        this.errorMessageElementTarget.classList.add('hidden')
      } else {
        this.errorMessageElementTarget.innerHTML = fileTypeError
        this.buttonFinishedLoading(false)
        this.errorMessageElementTarget.classList.remove('hidden')
        return
      }
      this.faceDetect(file)
    } else {
      this.buttonFinishedLoading(false)
    }
  }

  async faceDetect (file) { // detect if selected image has face
    const noFaceError = 'Please ensure your screenshot includes a clear view of the face.'

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
                }
              ]
            }
          ]
        })
      })
      .then(res => res.json())

      const faceExists = data.responses[0].faceAnnotations ? true : false

      if (faceExists) {
        this.errorMessageElementTarget.classList.add('hidden');
        this.buttonFinishedLoading(true);
      } else {
        this.errorMessageElementTarget.innerHTML = noFaceError;
        this.errorMessageElementTarget.classList.remove('hidden');
        this.buttonFinishedLoading(false)
      }
    }
  }

  checkFileType(file) { // Checks if file is acceptable format for upload to luxand
    const fileName = file.name
    const ext = fileName.slice(((fileName.lastIndexOf(".") - 1) >>> 0) + 2)
    if (['jpg', 'jpeg', 'png', ].includes(ext)) {return true}
  }

  async searchGalleryForPerson() { // searches Luxand database for matching photos, then updates the DOM with relevant information
    event.preventDefault()
    this.buttonLoading()

    this.resultsImagesContainerElementTarget.innerHTML = '' //removes any previously returned images from the DOM

    const [file] = this.fileUploadElementTarget.files
    const headers = {
      "token": this.luxandApiKeyValue
    }
    const formData = new FormData()
    formData.append('photo', file)
    formData.append('all', 1) // returns all matching photos

    const data = await fetch(luxandUrlSearch, { // Luxand API call searching for matching photos
      method: "POST",
      headers: headers,
      body: formData
    })
    .then(response => response.json())
    .catch(error => console.log('error occured', error))
    const photoUuids = data.map((photo) => photo.photo_uuid)

    const results = (await Promise.all(photoUuids.map((uuid) => this.returnMatchingSurveys(uuid)))).filter((r) => r == 0 || r) // results are hashes with surveys with uuids that match returned Luxand photos and cloudinary photo urls {survey: survey, photo_url: cloudinary_photo_url}

    results.forEach((result) => result ? this.resultsImagesContainerElementTarget.innerHTML += this.buildImageElement(result.photo_url) : '') // injects img element into DOM

    const surveys = results.map((result) => result ? result.survey : '')
    this.resultsScoreElementTarget.innerHTML = results.length ? `This person's Dish Date Score is: ${this.medianOfScores(surveys)}%` : "We don't have enough information on this person."
    this.inputLabelElementTarget.innerHTML = 'Search for another profile?'

    this.checkUserSearchDateAccessed() // Updates search_date_accessed column with a timestamp. also checks if there are >1 timestamps already

    this.dispatch("searchGalleryForPerson") // calls swiper#connect(check search_date.html line: 4) to refresh the swiper_controller.js with the new DOM

    this.buttonFinishedLoading(false)
  }

  async returnMatchingSurveys(uuid) { // returns surveys from our DB with uuids that match the photos returned from Luxand
    const url = `/surveys?uuid=${uuid}`
    return await fetch(url, {
      method: "GET",
      headers: {
        accept: "application/json"
      }
    })
    .then(response => response.json())
    .catch(error => console.error(error))
  }

  medianOfScores(surveys) {
    const scores = (surveys.map((survey) => survey ? survey.score : 1))
    const half = Math.floor(scores.length / 2)
    return scores.length % 2 ? scores[half] : (scores[half - 1] + scores[half]) / 2
  }

  buildImageElement(photo_url) { // builds img tag with the cloudinary photo url. ensures element is connected to swiper_controller.js through stimulus syntax
    return `<img src=${photo_url} class="survey-result-image profile-image swiper-slide animated" data-swiper-target="slideElement">`
  }

  async checkUserSearchDateAccessed() { // calls users_controller.rb to update user's search_date_accessed array. Returns user.
    const url = '/users/update_access'
    const data = await fetch(url, {
      method: "GET",
      headers: {
        accept: "application/json"
      }
    })
    .then(response => response.json())
    .catch(error => console.log("error", error))

    if (data.search_date_accessed.length > 1 && !data.is_admin) { // checks to see if user has used the Search Date feature twice within 24 hrs and disables if true.
      this.searchButtonElementTarget.classList.add('button-disabled')
      this.errorNotificationElementTarget.innerHTML = "Sorry, you've already used this feature twice today, please try again tomorrow."
    }
  }

  buttonLoading() {
    this.searchButtonElementTarget.classList.remove('button-disabled')
    this.searchButtonElementTarget.classList.add('loading')
    this.searchButtonElementTarget.innerHTML = 'Loading'
  }

  buttonFinishedLoading(enable) {
    if (enable) {
      this.searchButtonElementTarget.classList.remove('loading')
      this.searchButtonElementTarget.innerHTML = 'Search'
    } else {
      this.searchButtonElementTarget.classList.remove('loading')
      this.searchButtonElementTarget.classList.add('button-disabled')
      this.searchButtonElementTarget.innerHTML = 'Search'
    }
  }
}
