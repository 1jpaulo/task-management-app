import { Controller } from '@hotwired/stimulus'

export default class extends Controller {
  static targets = ['newCard', 'createButton']
  static values = {
    isExpanded: Boolean,
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

  // TODO: change name
  transition() {
    this.newCardTarget.classList.toggle('max-h-[18rem]')
    this.newCardTarget.style.transition = 'all .4s ease-in'

    // a delay is needed to make turbo-stream request be made
    setTimeout(() => this.disableButton(), 100)
  }

  disableButton() {
    // TODO: enableButton again when losing focus of the card
    this.createButtonTarget.disabled = true
    this.createButtonTarget.classList.add('cursor-not-allowed', 'opacity-50')
    
  }
}