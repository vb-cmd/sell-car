const API_NAME = 'api'
const API_VERSION = 'v1'
const API_BASE = `ads/cars`
const API_FORMAT = 'json'
const API_FULL_URL = `${API_NAME}/${API_VERSION}/${API_BASE}.${API_FORMAT}`

class FetchCars {
    static async getData(page) {
        const response = await fetch(`${API_FULL_URL}?page=${page}`)
        const data = await response.json()
        return data
    }
}

export default FetchCars