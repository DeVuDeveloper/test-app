import { Controller } from "@hotwired/stimulus";

export default class extends Controller {
  static targets = ["timer", "button", "ready", "empty"];
 
  connect() {
    this.fetchOvenStatus();
    this.startPolling();
  }

  startPolling() {
    this.pollingInterval = setInterval(() => {
      this.fetchOvenStatus();
    }, 5000);
  }

  
  async fetchOvenStatus() {
    try {
      const ovenId = this.data.get("ovenId");
      const response = await fetch(`/ovens/${ovenId}/oven_status`);
      const data = await response.json();
    
      if (data.ready || data.time_left <= 5) {
        this.updateTimer(0, true);
        clearInterval(this.pollingInterval);
      } else {
        this.updateTimer(data.time_left, false);
    
        if (data.cookies_empty) {
          this.buttonTarget.style.display = "none";
          this.readyTarget.style.display = "none"; 
          this.emptyTarget.style.display = "block";
        }
      }
    } catch (error) {
    }
  }
  
  updateTimer(remainingTime, ready) {
    this.timerTarget.textContent = `Remaining time: ${Math.round(remainingTime)} seconds`;

    if (ready) {
      this.timerTarget.style.display = "none";
      this.buttonTarget.style.display = "block";
      this.readyTarget.style.display = "block";
      this.emptyTarget.style.display = "none";
    } else {
      this.timerTarget.style.display = "block";
      this.buttonTarget.style.display = "none";
      this.readyTarget.style.display = "none";
      this.emptyTarget.style.display = "none";
    }
  }

  disconnect() {
    clearInterval(this.timerInterval);
    clearInterval(this.pollingInterval);
  }
}
