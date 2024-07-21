import { buildUrl } from './consts'

const API_CARS = 'ads/cars'
const API_FULL_URL = `${buildUrl(API_CARS)}`

class FetchCars {
    static async getData(page, params = {}) {
        const response = await fetch(buildSearchParams({ page: page, ...params }))
        const data = await response.json()
        return data
    }
}

function buildSearchParams(params = null) {
    if (!params) return API_FULL_URL

    let urlSearch = new URLSearchParams()

    Object.keys(params).forEach(key => urlSearch.set(key, params[key]))

    return `${API_FULL_URL}?${urlSearch.toString()}`
}

export default FetchCars