import { Controller } from "@hotwired/stimulus"
import FetchCars from "../helper/fetch_cars"

export default class extends Controller {
  static targets = ["cars"]

  async connect() {
    await this.fetchCars(1)
  }

  async fetchCars(page, params = {}) {
    await FetchCars.getData(page, params)
      .then((data) => {
        this.carsTarget.innerHTML = this.render(data)
      }).catch((error) => {
        console.error(error)
      })
  }

  async manipulatePages(event) {
    await this.fetchCars(event.params.page)
  }

  async search(event) {
    event.preventDefault();
console.info(event)
    let params = {
      make_cont_any: event.target["car[make_cont_any]"].value,
      model_cont_any: event.target["car[model_cont_any]"].value,
      body_type_cont_any: event.target["car[body_type_cont_any]"].value,
      mileage_gt: event.target["car[mileage_gt]"].value,
      mileage_lt: event.target["car[mileage_lt]"].value,
      color_cont_any: event.target["car[color_cont_any]"].value,
      price_gt: event.target["car[price_gt]"].value,
      price_lt: event.target["car[price_lt]"].value,
      fuel_type_cont_any: event.target["car[fuel_type_cont_any]"].value,
      year_gt: event.target["car[year_gt]"].value,
      year_lt: event.target["car[year_lt]"].value,
      engine_volume_cont_any: event.target["car[engine_volume_cont_any]"].value
    }

    Object.keys(params).forEach(key => params[key] == "" && delete params[key])

    await this.fetchCars(1, params)
  }

  render(data) {
    let cars = data.data.map(car => this.render_card(car)).join('')
    let pagination = this.render_pagination(data.page)

    return cars + pagination
  }

  render_card(car) {
    return `
       <div class="card m-1">
        <img src="${car.image_url}" class="card-img-top" alt="${car.make + ' ' + car.model}">
        <div class="card-body" style="padding:0;">
          <h5 class="card-title">${car.make + ' ' + car.model}</h5>
          <ul class="list-group list-group-flush">
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
          <div class="card-footer text-body-secondary">
            User: ${car.user.name} | Phone Number: ${car.user.phone_number} 
          </div>
        </div>
      </div>
    `
  }

  render_pagination(page) {
    return `
    <nav>
      <ul class="pagination justify-content-center">
        <li class="page-item ${page.prev ? '' : 'disabled'}"><button class="page-link" data-action="cards#manipulatePages" data-cards-page-param="${page.prev}">Previous</button></li>
        ${page.prev ? `<li class="page-item"><button class="page-link" data-action="cards#manipulatePages" data-cards-page-param="${page.prev}">${page.prev}</button></li>` : ''}
        ${page.current ? `<li class="page-item active"><button class="page-link" data-action="cards#manipulatePages" data-cards-page-param="${page.current}">${page.current}</button></li>` : ''}
        ${page.next ? `<li class="page-item"><button class="page-link" data-action="cards#manipulatePages" data-cards-page-param="${page.next}">${page.next}</button></li>` : ''}
        <li class="page-item ${page.next ? '' : 'disabled'}"><button class="page-link" data-action="cards#manipulatePages" data-cards-page-param="${page.next}">Next</a></li>
        <li class="page-item disabled">
          <span class="page-link">Total: ${page.total}</span>
        </li>
      </ul>
    </nav>`
  }
}
