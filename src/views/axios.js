import axios from 'axios'

const baseURL = 'http://api.ticket.pupscan.com/'

export const HTTP = axios.create({baseURL: baseURL})
