import { Controller } from "@hotwired/stimulus"

const luxandUrlAddPhoto = "https://api.luxand.cloud/photo"
const luxandUrlSearch = "https://api.luxand.cloud/photo/search2"

// Connects to data-controller="face-recognition"
export default class extends Controller {

  static values = {
    luxandApiKey: String
  }

  static targets = ['fileUploadElement', 'imageElement', 'resultsScoreElement', 'resultsImagesContainerElement']

  connect() {
  }

  previewImage() {
    const [file] = this.fileUploadElementTarget.files
    if (file) {
      this.imageElementTarget.src = URL.createObjectURL(file)
    }
  }

  async searchGalleryForPerson() {
    event.preventDefault()
    const [file] = this.fileUploadElementTarget.files
    const headers = {
      "token": this.luxandApiKeyValue
    }
    const formData = new FormData()
    formData.append('photo', file)
    formData.append('all', 1) // returns all matching photos

    // const data = await fetch(luxandUrlSearch, {
    //   method: "POST",
    //   headers: headers,
    //   body: formData
    // })
    // .then(response => response.json())
    // .catch(error => console.log('error occured', error))
    // const photoUuids = data.map((photo) => photo.photo_uuid)

    const photoUuids = ["20e565fe-cb5c-11ee-8061-0242ac160003", "20e565fe-cb5c-11ee-8061-0242ac160003", "20e565fe-cb5c-11ee-8061-0242ac160003" ] // remove when live
    const results = await Promise.all(photoUuids.map((uuid) => this.returnMatchingSurveys(uuid)))
    console.log('results', results)

    results.forEach((result) => result ? this.resultsImagesContainerElementTarget.innerHTML += this.buildImageElement(result.photo_url) : '')

    const surveys = results.map((result) => result.survey)
    this.resultsScoreElementTarget.innerHTML = results.length ? `This person's Dish Date Score is: ${this.medianOfScores(surveys)}%` : "We don't have enough information on this person."

    this.dispatch("searchGalleryForPerson")
  }

  medianOfScores(surveys) {
    const scores = (surveys.map((survey) => survey.score))
    const half = Math.floor(scores.length / 2)
    return scores.length % 2 ? scores[half] : (scores[half - 1] + scores[half]) / 2
  }

  buildImageElement(photo_url, index) {
    return `<img src=${photo_url} class="survey-result-image profile-image swiper-slide animated" data-swiper-target="slideElement">`
  }

  async returnMatchingSurveys(uuid) {
    const url = `/surveys?uuid=${uuid}`
    return await fetch(url, {
      method: "GET",
      headers: {
        accept: "application/json"
      }
    })
    .then(response => response.json())
  }

  getPhotos() {
    const headers = {
      "token": this.luxandApiKeyValue
    }

    fetch(luxandUrlAddPhoto, {
      method: "GET",
      headers: headers
    })
    .then(response => response.json())
    .then(data => console.log(data))
    .catch(error => console.log('error', error))
  }
}
