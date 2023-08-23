import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  resetForm(event) {
    const form = event.currentTarget;
    setTimeout(() => {
      form.reset();
    }, 1000);
  }
}