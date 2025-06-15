import { Controller } from '@hotwired/stimulus'

export default class extends Controller {
  static targets = [
    'title', 'text', 'titleInput', 'textInput'
  ]

  static values = {
    isExpanded: Boolean,
    isNew: Boolean,
  }

  /**
   * Dispatches a card added event when state is new is true,
   * which will disable the create button until the card is added to the workspace
   */
  connect() {
    if (!this.isNewValue) return;

    this.element.dispatchEvent(new CustomEvent("card:added", { bubbles: true }))
    this.addKeyMapping()
  }

  disconnect() {
    if (this.isNewValue) {
      document.dispatchEvent(new CustomEvent("card:saved", { bubbles: true}))
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

  addKeyMapping() {
    // TODO: instead of keydown (that can't be 'enter' because of newline), trigger pushcard sending over like websocket or SSE
    // as the user type OR when element lose focus (esc pressed - could use some mapping elsewhere and only grab a dict for that)
    // or by clicking outside
    this.element.addEventListener('keydown', (evt) => {
      if (evt.keyCode === 27) this.pushCard()
    })
  }

  pushCard() {
    this.copyContentFromEditableDiv()
    this.element.requestSubmit()
  }

  copyContentFromEditableDiv() {
    // TODO: Validation needed.
    this.titleInputTarget.value = this.titleTarget.innerText
    this.textInputTarget.value = this.textTarget.innerText
  }
}
