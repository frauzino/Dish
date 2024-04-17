import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="fetch-cities"
export default class extends Controller {

  static targets = ['citiesDropdownElement', 'stateFieldElement']

  connect() {
  }

  fetchCities = () => {
    fetch(`/get_cities?state=${this.stateFieldElementTarget.value}`)
    .then(response => response.json())
    .then(data => {
      this.citiesDropdownElementTarget.innerHTML = '';
      data.forEach(city => {
        const option = new Option(city, city);
        this.citiesDropdownElementTarget.add(option);
      })
    })
    .catch(error => console.error('error fetching cities:', error))
  }
}
