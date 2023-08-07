import { Controller } from "@hotwired/stimulus";

export default class extends Controller {
  static targets = ["form"];

  afterSubmit(event) {
    if (this.formTarget.contains(event.target)) {
      location.reload();
    }
  }
}


