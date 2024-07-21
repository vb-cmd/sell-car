const API_NAME = 'api'
const API_VERSION = 'v1'
const API_FORMAT = 'json'

function buildUrl(base) {
    return `/${API_NAME}/${API_VERSION}/${base}.${API_FORMAT}`
}

export { API_NAME, API_VERSION, API_FORMAT, buildUrl }