const API_NAME = 'api'
const API_VERSION = 'v1'
const API_BASE = `ads/cars`
const API_FORMAT = 'json'
const API_FULL_URL = `${API_NAME}/${API_VERSION}/${API_BASE}.${API_FORMAT}`

class FetchCars {
    static async getData(page, params = {}) {
        const response = await fetch(buildUrl({ page: page, ...params }))
        const data = await response.json()
        return data
    }
}

function buildUrl(params = null) {
    if (!params) return API_FULL_URL

    let urlSearch = new URLSearchParams()

    Object.keys(params).forEach(key => urlSearch.set(key, params[key]))

    return `${API_FULL_URL}?${urlSearch.toString()}`
}

export default FetchCars