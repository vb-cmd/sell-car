import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="user-profile"
export default class extends Controller {
  connect() {
    this.element.innerHTML = this.render()
  }

  render() {
    let modal = this.render_modal("signInUp", "Sign In/Up", "...")
    let button = this.render_button("signInUp", "Sign In/Up")

    return button + modal
  }

  render_button() {
    return `<button class="btn btn-primary" data-bs-toggle="modal" data-bs-toggle="modal" data-bs-target="#signInUpModal">Sign In/Up</button>`
  }

  render_modal() {
    return `
    <div class="modal fade" id="signInUpModal" tabindex="-1" aria-labelledby="exampleModalLabel" aria-hidden="true">
      <div class="modal-dialog">
        <div class="modal-content">
          <div class="modal-header">
            <h1 class="modal-title fs-5" id="exampleModalLabel">Sign In/Up</h1>
            <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
          </div>
          <div class="modal-body">
          <h2> Sign In </h2>
          ${this.render_form_sign_in()}
          </div>
          <div class="modal-body border-top">
          <h2> Sign Up </h2>
            ${this.render_form_sign_up()}
          </div>
        </div>
      </div>
    </div>`
  }

  render_form_sign_in() {
    return `
    <form>
      <div class="mb-3">
        <label for="email" class="form-label">Email address</label>
        <input type="email" class="form-control" id="email" aria-describedby="emailHelp">
      </div>
      <div class="mb-3">
        <label for="password" class="form-label">Password</label>
        <input type="password" class="form-control" id="password">
      </div>
      <button type="submit" class="btn btn-primary">Submit</button>
    </form>`
  }

  render_form_sign_up() {
    return `
    <form>
      <div class="mb-3">
        <label for="email" class="form-label">Email address</label>
        <input type="email" class="form-control" id="email" aria-describedby="emailHelp">
      </div>
      <div class="mb-3">
        <label for="password" class="form-label">Password</label>
        <input type="password" class="form-control" id="password">
      </div>
      <button type="submit" class="btn btn-primary">Submit</button>
    </form>`
  }
}
