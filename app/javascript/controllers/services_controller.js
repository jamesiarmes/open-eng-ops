import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="services"
export default class extends Controller {
  initialize() {
    console.log("Stimulus at your service!")
  }

  connect() {
    console.log("connected to forms controller");
  }

  handleChange(event) {
    document.getElementById('service-config').setAttribute('src', '/services/new/config?type=' + event.detail.value)
    console.log(event.detail.value);
  }
}
