import { Controller } from "@hotwired/stimulus";

export default class extends Controller {
  static targets = ["button", "selectedFilling"];
  lastSelectedButton = null;

  connect() {
    this.buttonTargets.forEach(button => {
      button.addEventListener("click", this.selectFilling.bind(this));
    });

    const initialSelectedFilling = this.selectedFillingTarget.value;
  
    if (initialSelectedFilling) {
      const initialButton = this.buttonTargets.find(
        button => button.getAttribute("data-filling") === initialSelectedFilling
      );
      if (initialButton) {
        this.lastSelectedButton = initialButton;
        initialButton.classList.add("active");
      }
    }
  }

  selectFilling(event) {
    const button = event.currentTarget;
    const filling = button.getAttribute("data-filling");
    this.selectedFillingTarget.value = filling;

    if (this.lastSelectedButton) {
      this.lastSelectedButton.classList.remove("active");
    }

    button.classList.add("active");
    this.lastSelectedButton = button;
  }
}
