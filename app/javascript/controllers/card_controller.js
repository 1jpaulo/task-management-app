import { Controller } from '@hotwired/stimulus'

export default class extends Controller {
  static targets = [
    'title', 'text', 'titleInput', 'textInput'
  ]

  static values = {
    isExpanded: Boolean,
    isNew: Boolean,
  }

  connect() {
    if (!this.isNewValue) return

    this.titleTarget.focus()
    this.element.addEventListener('focusout', this.#dismissOnFocusOut.bind(this))
    this.element.dispatchEvent(new CustomEvent('card:added', { bubbles: true }))
    this.addKeyMapping()
  }

  disconnect() {
    if (this.isNewValue) {
      document.dispatchEvent(new CustomEvent('card:saved', { bubbles: true}))
    }
  }

  initialize() {
    this.width = {
      'small': '15rem',
      'large': '45rem'
    }
  }

  expandCard() {
    if (!this.isNewValue) return
    this.element.style.width = this.width['large']
    // FIXME: not working with class toggle.
    // this.element.classList.toggle(`w-[${this.width['small']}]`)
    // this.element.classList.toggle(`w-[${this.width['large']}]`)
    this.isExpanded = !this.isExpanded
  }

  addKeyMapping() {
    // TODO: instead of keydown (that can't be 'enter' because of newline), trigger pushcard sending over like websocket or SSE
    // as the user type OR when element lose focus (esc pressed - could use some mapping elsewhere and only grab a dict for that)
    // or by clicking outside
    this.element.addEventListener('keydown', (evt) => {
      if (evt.keyCode === 27) this.pushCard()
    })
  }

  pushCard() {
    this.#copyContentFromEditableDiv()
    if (this.#validateForm()) this.element.requestSubmit()
  }

  #validateForm() {
    if (this.titleInputTarget.value.trim() !== '' || this.textInputTarget.value.trim() !== '') return true

    this.#dismissCard('#validateForm')
    return false
  }

  #copyContentFromEditableDiv() {
    this.titleInputTarget.value = this.titleTarget.innerText
    this.textInputTarget.value = this.textTarget.innerText
  }

  #dismissOnFocusOut(event) {
    // only dismiss when the next target element is not within the new card, so tab focus change won't break the form
    if (event.relatedTarget && this.element.contains(event.relatedTarget)) return

    this.#dismissCard('dismissOnFocus')
  }

  #dismissCard() {
    // schedule DOM changes in a user supplied callback so it won't have focusout/blur bubbling problems with removal
    requestAnimationFrame(() => {
      this.element.remove()
    })
  }
}
