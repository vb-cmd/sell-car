import { Controller } from "@hotwired/stimulus"
import FetchUser from "../../helper/fetch_user"

// Connects to data-controller="user--edit-profile"
export default class extends Controller {
  connect() {
    FetchUser.check()
      .then((data) => {
        this.render_form(data)
      }).catch((message) => {
        this.render_status(message, 'danger')
      })
  }

  async send(event) {
    event.preventDefault()

   await FetchUser.update(
      event.target["user[email]"].value,
      event.target["user[password]"].value,
      event.target["user[phone_number]"].value,
      event.target["user[name]"].value)
      .then((data) => {
        this.render_status(data.message)
      }).catch((message) => {
        this.render_status(message, 'danger')
      })
  }

  render_status(message, status = "success") {
    this.element.innerHTML = `<div class="text-${status}">${message}</div>`
  }

  render_form(user) {
    this.element.innerHTML = `
    <form data-action="user--edit-profile#send">
    <div class="mb-3">
      <label for="user_email" class="form-label">Email address</label>
      <input type="email" class="form-control" id="user_email" value="${user.email}" name="user[email]">
    </div>
    <div class="mb-3">
      <label for="user_name" class="form-label">Name</label>
      <input type="text" class="form-control" id="user_name" value="${user.name}" name="user[name]">
    </div>
    <div class="mb-3">
      <label for="user_phone_number" class="form-label">Phone number</label>
      <input type="text" class="form-control" id="user_phone_number" value="${user.phone_number}" name="user[phone_number]">
    </div>
    <div class="mb-3">
      <label for="user_password" class="form-label">Password</label>
      <input type="password" class="form-control" id="user_password" name="user[password]">
    </div>
    <button type="submit" class="btn btn-primary">Submit</button>
  </form>`
  }
}
