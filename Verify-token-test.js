import axios from 'axios';
import jwt from 'jsonwebtoken';

axios.post('http://localhost:443/oauth/verify', {}, {
  headers: {
    'Content-Type': 'application/json',
    'Authorization': 'Bearer eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJjbGllbnRJZCI6IjV5WDRIdGMwYlR4QTU1LVo5S1Q4bVFHamZnbUpwLTFzbDZKeHpKalhoMXdDLWZQYjFoRkpIM2liZmg2Iiwic2NvcGUiOiJhbGwiLCJjbGllbnRTZWNyZXQiOiJGUUY0OExUd05JV0w4UVNTT0tPYjdRQkxyMVV2UHZxR0p6Q3NpTFBkZE5aTUEzY29kcSIsImlhdCI6MTczNDEwNjQ2NiwiZXhwIjoxNzM0MTkyODY2fQ.Cb6jCzImbVNXbOW3HKu2FVSz8X-qomAd6AX4NW7tBvM'
  }
})
.then((response) => {
  console.log('Response:', response.data);
  const responseToken= response.data.encodedResponse;
  const decodedTokenInfo=jwt.verify(responseToken,"b1aYx6aU4aWEN9YnvPMsYMuLV6mKdPEw9");
  console.log('Decoded Token Info:', decodedTokenInfo);
})
.catch((error) => {
  console.error('Error:', error);
});





// // Valor de expiración del token
// const exp = 1721362134;

// // Convertir el valor de expiración a una fecha legible
// const expirationDate = new Date(exp * 1000);

// // Obtener la fecha y hora actuales
// const currentDate = new Date();

// // Calcular la diferencia en segundos
// const differenceInSeconds = (expirationDate - currentDate) / 1000;

// // Convertir la diferencia a días, horas, minutos
// const days = Math.floor(differenceInSeconds / (3600 * 24));
// const hours = Math.floor((differenceInSeconds % (3600 * 24)) / 3600);
// const minutes = Math.floor((differenceInSeconds % 3600) / 60);

// console.log(`El token expira en ${days} días, ${hours} horas y ${minutes} minutos.`);