import { Controller } from "@hotwired/stimulus"
import FetchUser from "../../helper/fetch_user"
import CookieJWT from '../../helper/cookie-jwt'

// Connects to data-controller="user--sign-in-up"
export default class extends Controller {
  static targets = ["errors", "text"]

  async connect() {
    await FetchUser.check()
      .then((data) => {
        this.render_profile(data)
      }).catch(() => {
        this.render_sign_in_up()
      })
  }

  logout() {
    CookieJWT.remove()
    this.render_sign_in_up()
  }

  async login(event) {
    event.preventDefault()

    let email = event.target["email"].value
    let password = event.target["password"].value

    await FetchUser.login(email, password)
      .then((data) => {
        CookieJWT.set(data.token, 10)

        this.render_profile(data.user)

      }).catch((error) => {
        this.errorsTarget.innerText = error
      })
  }

  async register(event) {
    event.preventDefault()

    let email = event.target["user[email]"].value
    let password = event.target["user[password]"].value
    let password_confirmation = event.target["user[password_confirmation]"].value
    let phone_number = event.target["user[phone_number]"].value
    let name = event.target["user[name]"].value

    await FetchUser.register(email, password, password_confirmation, phone_number, name)
      .then((data) => {
        CookieJWT.set(data.token, 10)

        this.render_profile(data.user)
      }).catch((error) => {
        this.errorsTarget.innerText = error
      })
  }

  render_sign_in_up() {
    let modal_sign_in = this.render_modal("signIn", "Sign in", this.render_form_sign_in())
    let modal_sign_up = this.render_modal("signUp", "Sign up", this.render_form_sign_up())
    let buttons = this.render_buttons_group()

    this.element.innerHTML = buttons + modal_sign_in + modal_sign_up
  }

  render_modal(id, title, content) {
    return `
          <div class="modal fade" id="${id}Modal" tabindex="-1" aria-labelledby="${id}Label" aria-hidden="true">
            <div class="modal-dialog">
              <div class="modal-content">
                <div class="modal-header">
                  <h1 class="modal-title fs-5" id="${id}Label">${title}</h1>
                  <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
                </div>
                <div class="modal-body">
                  <div class="text-danger" data-user--sign-in-up-target="errors"></div>
                  <div class="text-success" data-user--sign-in-up-target="text"></div>
                  ${content}
                </div>
              </div>
            </div>
          </div>
    `
  }

  render_form_sign_in() {
    return `
     <form data-action="user--sign-in-up#login">
                    <div class="mb-3">
                      <label for="login_email" class="form-label">Email address</label>
                      <input type="email" class="form-control" id="login_email" name="email">
                    </div>
                    <div class="mb-3">
                      <label for="login_password" class="form-label">Password</label>
                      <input type="password" class="form-control" id="login_password" name="password">
                    </div>
                    <button type="submit" class="btn btn-primary">Submit</button>
                  </form>
    `
  }

  render_form_sign_up() {
    return `
     <form data-action="user--sign-in-up#register">
                    <div class="mb-3">
                      <label for="user_email" class="form-label">Email address</label>
                      <input type="email" class="form-control" id="user_email" name="user[email]">
                    </div>
                    <div class="mb-3">
                      <label for="user_password" class="form-label">Password</label>
                      <input type="password" class="form-control" id="user_password" name="user[password]">
                    </div>
                    <div class="mb-3">
                      <label for="user_password_confirmation" class="form-label">Password Confirmation</label>
                      <input type="password" class="form-control" id="user_password_confirmation" name="user[password_confirmation]">
                    </div>
                    <div class="mb-3">
                      <label for="user_phone_number" class="form-label">Phone Number</label>
                      <input type="phone" class="form-control" id="user_phone_number" name="user[phone_number]">
                    </div>
                    <div class="mb-3">
                      <label for="user_name" class="form-label">Name</label>
                      <input type="text" class="form-control" id="user_name" name="user[name]">
                    </div>
                    <button type="submit" class="btn btn-primary">Submit</button>
                  </form>
    `
  }

  render_buttons_group() {
    return `
          <div class="btn-group" role="group">
            <button class="btn btn-primary" data-bs-toggle="modal" data-bs-toggle="modal" data-bs-target="#signInModal">Sign In</button>
            <button class="btn btn-success" data-bs-toggle="modal" data-bs-toggle="modal" data-bs-target="#signUpModal">Sign Up</button>
          </div>`
  }

  render_profile(user) {
    let profile = `
    <div class="dropdown">
    <button class="btn btn-primary dropdown-toggle" type="button" data-bs-toggle="dropdown" aria-expanded="false">
      Hello, ${user.name}
    </button>
    <a type="button" class="btn btn-primary" href="/users/cars">Cars</a>
      <ul class="dropdown-menu">
        <li><a class="dropdown-item" href="/users/profile">My profile</a></li>
        <li><a class="dropdown-item" href="/users/profile/edit">Edit</a></li>
        <li><button type="submit" class="btn dropdown-item" data-action="user--sign-in-up#logout">Sign Out</button></li>
      </ul>
    </div>`


    this.element.innerHTML = profile
  }
}
