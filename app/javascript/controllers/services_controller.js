import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="services"
export default class extends Controller {
  handleChange(event) {
    if (event.detail.element.id === 'service_type') {
      document.getElementById('service-config')
        .setAttribute('src', '/services/new/config?type=' + event.detail.value)
    }
  }
}
