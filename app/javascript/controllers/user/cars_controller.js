import { Controller } from "@hotwired/stimulus"
import FetchUser from "../../helper/fetch_user"

// Connects to data-controller="user--cars"
export default class extends Controller {
  static targets = ["cards", "buttons"]

  async connect() {
    this.render_buttons_group()

    await FetchUser.cars()
      .then((data) => {
        this.render_cards(data)
      }).catch((message) => {
        this.cardsTarget.innerHTML = this.render_status(message, 'danger')
      })
  }

  async delete(event) {
    const id = event.params.id
    const car = document.getElementById(`car-${id}`)

    await FetchUser.delete_car(id)
      .then((data) => {
        car.outerHTML = this.render_status(data.message)
      }).catch((message) => {
        car.innerHTML = this.render_status(message, 'danger')
      })
  }

  filter_by_status(event) {
    const status = event.params.status

    FetchUser.cars(status)
      .then((data) => {
        this.render_cards(data)
      }).catch((message) => {
        this.cardsTarget.innerHTML = this.render_status(message, 'danger')
      })
  }

  convert(status) {
    switch (status) {
      case "approved":
        return "success"
      case "rejected":
        return "danger"
      case "pending":
        return "warning"
      default:
        return "secondary"
    }
  }

  render_status(message, status = "success") {
    return `<p class="text-${status}">${message}</p>`
  }

  render_cards(cars) {
    let cars_html = cars.map((car) => {
      return `<div class="card mb-3" id="car-${car.id}">
  <div class="row g-0">
    <div class="col-md-4">
      <img src="${car.image_url}" class="img-fluid rounded-start" alt="${car.make + ' ' + car.model}">
    </div>
    <div class="col-md-8">
      <div class="card-body">
      <a href="${car.edit_url}" role="button" class="btn btn-primary">Edit</a>
      <button class="btn btn-danger" data-action="user--cars#delete" data-user--cars-id-param="${car.id}">Delete</button>
         <ul class="list-group list-group-flush">
          <li class="list-group-item"><span class="badge text-bg-${this.convert(car.status)}">Status: ${car.status}</span></li>
          <li class="list-group-item">Make: ${car.make}</li>
          <li class="list-group-item">Model: ${car.model}</li>
          <li class="list-group-item">Body Type: ${car.body_type}</li>
          <li class="list-group-item">Mileage: ${car.mileage}</li>
          <li class="list-group-item">Color: ${car.color}</li>
          <li class="list-group-item">Price: ${car.price}</li>
          <li class="list-group-item">Fuel Type: ${car.fuel_type}</li>
          <li class="list-group-item">Year: ${car.year}</li>
          <li class="list-group-item">Engine Volume: ${car.engine_volume}</li>
        </ul>
      </div>
    </div>
  </div>
</div>`}).join('')

    this.cardsTarget.innerHTML = cars_html
  }

  render_buttons_group() {
    this.buttonsTarget.innerHTML = `
    <div class="btn-group" role="group">
      <button class="btn btn-primary" data-action="user--cars#filter_by_status" data-user--cars-status-param="approved">Approved</button>
      <button class="btn btn-primary" data-action="user--cars#filter_by_status" data-user--cars-status-param="rejected">Rejected</button>
      <button role="button" class="btn btn-primary" data-action="user--cars#filter_by_status" data-user--cars-status-param="pending">Pending</button>
      <button role="button" class="btn btn-primary" data-action="user--cars#filter_by_status">All</button>
    </div>`
  }

}
