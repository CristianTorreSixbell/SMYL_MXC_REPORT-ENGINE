import axios from 'axios';

const clientId = "5yX4Htc0bTxA55-Z9KT8mQGjfgmJp-1sl6JxzJjXh1wC-fPb1hFJH3ibfh6";
const clientSecret = "FQF48LTwNIWL8QSSOKOb7QBLr1UvPvqGJzCsiLPddNZMA3codq";
const clientScope = "all";
const encodedData = Buffer.from(clientId + ':' + clientSecret + ':' + clientScope).toString('base64');

async function createToken() {
    try {
        const { data } = await axios.post(`http://127.0.0.1:443/oauth/token`, "grant_type=client_credentials", {
            headers: {
                'Content-Type': 'application/x-www-form-urlencoded',
                'Authorization': 'Basic ' + encodedData
            }
        });
        console.log('Token:', data);
        return data.access_token;
    } catch (error) {
        console.error('Error creating token:', error);
    }
}

createToken();