import { Controller } from '@hotwired/stimulus'

export default class extends Controller {
  static values = {
    isExpanded: Boolean,
  }

  initialize() {
    // use size accordingly with the initial size, need to separate the number from the unit (rem) to multiply
    // this.width = [this.element.style.width, this.element.style.width * 4]
    this.width = ['15rem', '45rem']
  }

  toggleExpansion() {
    const width = this.isExpanded ? this.width[0] : this.width[1]
    this.element.style.width = width
    // this.element.style.height = height
    this.isExpanded = !this.isExpanded
    this.element.style.transition = 'all .4s ease-in'
  }

  create() {
    // probably the best way to do this is by fetching the page and inserting it inside the innerHTML attribute
    // TODO: check if there is other ways of doing so!
    // TODO: Add spinner wheel while the card creator component is not completely rendered
  }
}