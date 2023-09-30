import { Controller } from "@hotwired/stimulus"
import * as mdb from 'mdb-ui-kit';

// Connects to data-controller="turbo-modal"
export default class extends Controller {
  connect() {
    this.modal = new mdb.Modal(this.element);
    this.modal.show();
  }

  hideModal() {
    this.modal.hide();
    this.element.parentElement.removeAttribute('src');
    this.element.remove();
  }

  // hide modal on successful form submission
  // action: "turbo:submit-end->turbo-modal#submitEnd"
  submitEnd(e) {
    if (e.detail.success) {
      this.hideModal()
    }
  }
}
