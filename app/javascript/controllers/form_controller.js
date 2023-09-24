import { Controller } from '@hotwired/stimulus';
import * as mdb from 'mdb-ui-kit';
import 'select2';

export default class extends Controller {
  connect() {
    // Initialize input elements.
    this.element.querySelectorAll('.form-outline').forEach((el) => {
      new mdb.Input(el).init();
    });

    // Initialize select elements.
    this.element.querySelectorAll('select').forEach((el) => {
      $(el).select2({ theme: 'bootstrap-5', width: '100%' });
    });
    this.element.querySelectorAll('.select-outline').forEach((el) => {
      new mdb.Select(el).init();
    });
  }
};
