import { buildUrl } from './consts'
import CookieJWT from "../helper/cookie-jwt"

const API_SESSION = 'users/session'
const API_REGISTRATION = 'users/registration'
const API_PROFILE = 'users/profile'
const API_CARS = 'users/cars'

class FetchUser {
    static async create_car(form_element) {
        const response = await fetch(buildUrl(API_CARS), {
            method: 'POST',
            headers: {
                'Authorization': `Bearer ${CookieJWT.get()}`
            },
            body: new FormData(form_element)
        })

        const data = await response.json()

        if (response.ok) {
            return data
        } else if (response.status === 422 || response.status === 401 || response.status === 404) {
            throw new Error(data.errors)
        }
    }

    static async delete_car(id) {
        const response = await fetch(buildUrl(`${API_CARS}/${id}`), {
            method: 'DELETE',
            headers: {
                'Content-Type': 'application/json',
                'Authorization': `Bearer ${CookieJWT.get()}`
            }
        })

        const data = await response.json()

        if (response.ok) {
            return data
        } else if (response.status === 401) {
            throw new Error(data.errors)
        }
    }

    static async update_car(id, form_element) {
        const response = await fetch(buildUrl(`${API_CARS}/${id}`), {
            method: 'PATCH',
            headers: {
                'Authorization': `Bearer ${CookieJWT.get()}`
            },
            body: new FormData(form_element)
        })

        const data = await response.json()

        if (response.ok) {
            return data
        } else if (response.status === 422 || response.status === 401 || response.status === 404) {
            throw new Error(data.errors)
        }
    }

    static async car(id) {
        const response = await fetch(buildUrl(`${API_CARS}/${id}`), {
            headers: {
                'Content-Type': 'application/json',
                'Authorization': `Bearer ${CookieJWT.get()}`
            }
        })

        const data = await response.json()

        if (response.ok) {
            return data
        } else if (response.status === 401) {
            throw new Error(data.errors)
        }
    }

    static async cars(status = null) {
        const path = buildUrl(API_CARS) + (status ? `?status=${status}` : '')
        const response = await fetch(path, {
            headers: {
                'Content-Type': 'application/json',
                'Authorization': `Bearer ${CookieJWT.get()}`
            }
        })

        const data = await response.json()

        if (response.ok) {
            return data
        } else if (response.status === 401) {
            throw new Error(data.errors)
        }
    }

    static async update(email, password, phone_number, name) {
        let user = {}

        if (email) user.email = email
        if (password) user.password = password
        if (phone_number) user.phone_number = phone_number
        if (name) user.name = name

        const response = await fetch(buildUrl(API_PROFILE), {
            method: 'PATCH',
            headers: {
                'Content-Type': 'application/json',
                'Authorization': `Bearer ${CookieJWT.get()}`
            },
            body: JSON.stringify({
                user: user
            })
        })

        const data = await response.json()

        if (response.ok) {
            return data
        } else if (response.status === 401) {
            throw new Error(data.error)
        }
    }

    static async check() {
        const response = await fetch(buildUrl(API_PROFILE),
            {
                headers: {
                    'Content-Type': 'application/json',
                    "Authorization": `Bearer ${CookieJWT.get()}`
                }
            })
        const data = await response.json()

        if (response.ok) {
            return data
        } else if (response.status === 401) {
            throw new Error(data.error)
        }
    }

    static async login(email, password) {
        const response = await fetch(buildUrl(API_SESSION), {
            method: 'POST',
            headers: {
                'Content-Type': 'application/json'
            },
            body: JSON.stringify({
                user: {
                    email: email,
                    password: password
                }
            })
        })

        const data = await response.json()

        if (response.ok) {
            return data
        } else if (response.status === 401) {
            throw new Error(data.error)
        }
    }

    static async register(email, password, password_confirmation, phone_number, name) {
        const response = await fetch(buildUrl(API_REGISTRATION), {
            method: 'POST',
            headers: {
                'Content-Type': 'application/json'
            },
            body: JSON.stringify({
                user: {
                    email: email,
                    password: password,
                    password_confirmation: password_confirmation,
                    phone_number: phone_number,
                    name: name
                }
            })
        })

        const data = await response.json()

        if (response.ok) {
            return data
        } else if (response.status === 422) {
            throw new Error(data.errors.join(', '))
        }
    }
}

export default FetchUser