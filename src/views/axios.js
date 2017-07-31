import axios from 'axios'

const baseURL = 'https://api.ticket.pupscan.com/'

export const HTTP = axios.create({baseURL: baseURL})
