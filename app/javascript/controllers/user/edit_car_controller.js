import { Controller } from "@hotwired/stimulus"
import FetchUser from "../../helper/fetch_user"

// Connects to data-controller="user--edit-car"
export default class extends Controller {
  static values = {
    id: Number
  }

  async connect() {
    await FetchUser.car(this.idValue)
      .then((data) => {
        this.render_form(data)
      }).catch((message) => {
        this.render_status(message, 'danger')
      })
  }

  async edit(event) {
    event.preventDefault()

    await FetchUser.update_car(this.idValue, event.target)
      .then((data) => {
        this.render_status(data.message)
      }).catch((message) => {
        this.render_status(message, 'danger')
      })
  }

  render_form(car) {
    this.element.innerHTML = `
    <form data-action="user--edit-car#edit">
    <div class="mb-3">
      <label for="car_make" class="form-label">Make</label>
      <input type="text" class="form-control" id="car_make" name="car[make]" value="${car.make}">
    </div>
    <div class="mb-3">
      <label for="car_model" class="form-label">Model</label>
      <input type="text" class="form-control" id="car_model" name="car[model]" value="${car.model}">
    </div>
    <div class="mb-3">
      <label for="car_body_type" class="form-label">Body Type</label>
      <input type="text" class="form-control" id="car_body_type" name="car[body_type]" value="${car.body_type}">
    </div>
    <div class="mb-3">
      <label for="car_mileage" class="form-label">Mileage</label>
      <input type="number" min="0" class="form-control" id="car_mileage" name="car[mileage]" value="${car.mileage}">
    </div>
    <div class="mb-3">
      <label for="car_color" class="form-label">Color</label>
      <input type="text" class="form-control" id="car_color" name="car[color]" value="${car.color}">
    </div>
    <div class="mb-3">
      <label for="car_price" class="form-label">Price</label>
      <input type="number" min="0" class="form-control" id="car_price" name="car[price]" value="${car.price}">
    </div>
    <div class="mb-3">
      <label for="car_fuel_type" class="form-label">Fuel Type</label>
      <input type="text" class="form-control" id="car_fuel_type" name="car[fuel_type]" value="${car.fuel_type}">
    </div>
    <div class="mb-3">
      <label for="car_year" class="form-label">Year</label>
      <input type="number" min="1900" max="2100" class="form-control" id="car_year" name="car[year]" value="${car.year}">
    </div>
    <div class="mb-3">
      <label for="car_engine_volume" class="form-label">Engine Volume</label>
      <input type="text" class="form-control" id="car_engine_volume" name="car[engine_volume]" value="${car.engine_volume}">
    </div>
    <div class="mb-3">
      <label for="car_image" class="form-label">Engine Volume</label>
      <input type="file" class="form-control" id="car_image" name="car[image]">
    </div>

    <button type="submit" class="btn btn-primary">Submit</button>
  </form>`
  }

  render_status(message, status = "success") {
    this.element.innerHTML = `<p class="text-${status}">${message}</p>`
  }
}
