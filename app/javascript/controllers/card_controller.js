import { Controller } from '@hotwired/stimulus'

export default class extends Controller {
  static targets = ['newCard', 'createButton']
  static values = {
    isExpanded: Boolean,
    isNew: Boolean,
  }

  /**
   * Dispatches a card added event when state is new is true,
   * which will disable the create button until the card is added to the workspace
   */
  connect() {
    if (this.isNewValue) {
      this.element.dispatchEvent(new CustomEvent("card:added", { bubbles: true }))
      // remove state of new card since it was already added
      this.isNewValue = false
    } else {
      this.element.addEventListener("card:added", this.disableButton.bind(this))
    }
  }

  initialize() {
    this.width = ['15rem', '45rem']
  }

  toggleExpansion() {
    const width = this.isExpanded ? this.width[0] : this.width[1]
    this.element.style.width = width
    this.isExpanded = !this.isExpanded
    this.element.style.transition = 'all .4s ease-in'
  }

  toggleCreateSlide() {
    this.newCardTarget.classList.toggle('max-h-[18rem]')
    this.newCardTarget.style.transition = 'all .4s ease-in'
  }

  disableButton() {
    // TODO: enableButton again when losing focus of the card
    this.createButtonTarget.disabled = true
    this.createButtonTarget.classList.add('cursor-not-allowed', 'opacity-50')
  }
}