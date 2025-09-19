import axios from 'axios';

const api = axios.create({
  baseURL: "http://localhost:5001",  // <- must be localhost, not "backend"
  withCredentials: false,
});

export default api;
