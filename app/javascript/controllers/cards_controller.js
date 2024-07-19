import { Controller } from "@hotwired/stimulus"
import FetchCars from "../helper/fetch_cars"

export default class extends Controller {
  static targets = ["cars"]

  async connect() {
    await FetchCars.getData(1)
      .then((data) => {
        this.carsTarget.innerHTML = this.render(data)
      }).catch((error) => {
        console.error(error)
      })
  }

  manipulatePages(event) {
    console.info('clicked')
    FetchCars.getData(event.params.page)
      .then((data) => {
        this.carsTarget.innerHTML = this.render(data)
      }).catch((error) => {
        console.error(error)
      })
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
