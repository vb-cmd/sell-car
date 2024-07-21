import { Controller } from "@hotwired/stimulus"
import FetchUser from "../../helper/fetch_user"

// Connects to data-controller="user--profile"
export default class extends Controller {
  static targets = ["results"]

  async connect() {
    await FetchUser.check()
      .then((data) => {
        this.render_list(data)
      }).catch((message) => {
        this.render_error(message)
      })
  }

  render_list(user) {
    let profile = `<li class="list-group-item active">Name: ${user.name}</li>
      <li class="list-group-item">Email: ${user.email}</li>
      <li class="list-group-item">Phone Number: ${user.phone_number}</li>`

    this.resultsTarget.innerHTML = profile
  }

  render_error(message) {
    this.resultsTarget.innerHTML = `<li class="list-group-item text-danger">${message}</li>`
  }
}
