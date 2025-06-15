import { Controller } from '@hotwired/stimulus'

export default class extends Controller {
  static targets = [
    'newCard', 'createButton'
  ]

  connect() {
    this.element.addEventListener('card:added', this.toggleButtonDisabled.bind(this))
    document.addEventListener('card:saved', this.closeForm.bind(this))
  }

  closeForm() {
    this.toggleButtonDisabled(false)
    this.toggleSlide()
  }

  toggleButtonDisabled(disabled = true) {
    this.createButtonTarget.disabled = disabled
    const disabledClasses = ['cursor-not-allowed', 'opacity-50']
    if (disabled) {
      this.createButtonTarget.classList.add(...disabledClasses)
    } else {
      this.createButtonTarget.classList.remove(...disabledClasses)
    }
  }

  toggleSlide() {
    this.newCardTarget.classList.toggle('max-h-0')
    this.newCardTarget.classList.toggle('max-h-[18rem]')
  }
}