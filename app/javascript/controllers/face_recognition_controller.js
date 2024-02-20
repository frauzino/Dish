import { Controller } from "@hotwired/stimulus"

const luxandUrlAddPhoto = "https://api.luxand.cloud/photo"
const luxandUrlSearch = "https://api.luxand.cloud/photo/search2"

// Connects to data-controller="face-recognition"
export default class extends Controller {

  static values = {
    luxandApiKey: String
  }

  static targets = ['fileUploadElement', 'imageElement', 'resultsScoreElement', 'resultsImagesContainerElement', 'inputLabelElement']

  connect() {
  }

  previewImage() { //updates Dom with a preview of the search image
    const [file] = this.fileUploadElementTarget.files
    if (file) {
      this.imageElementTarget.src = URL.createObjectURL(file)
    }
  }

  async searchGalleryForPerson() { // searches Luxand database for matching photos, then updates the DOM with relelvant information
    event.preventDefault()
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

    this.dispatch("searchGalleryForPerson") // calls swiper#connect(check search_date.html line: 4) to refresh the swiper_controller.js with the new DOM
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
    const scores = (surveys.map((survey) => survey.score))
    const half = Math.floor(scores.length / 2)
    return scores.length % 2 ? scores[half] : (scores[half - 1] + scores[half]) / 2
  }

  buildImageElement(photo_url) { // builds img tag with the cloudinary photo url. ensures element is connected to swiper_controller.js through stimulus syntax
    return `<img src=${photo_url} class="survey-result-image profile-image swiper-slide animated" data-swiper-target="slideElement">`
  }

  async updateUserSearchDateAccessed() {
    event.preventDefault()
    console.log('hello')
    const url = '/users/update_access'
    await fetch(url, {
      method: "GET",
      headers: {
        accept: "application/json"
      }
    })
    .then(response => response.json())
    .then(data => console.log("updated", data))
    .catch(error => console.log("error", error))
  }
}
