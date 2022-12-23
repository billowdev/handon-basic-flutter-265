const express = require('express');

const app = express()

app.route('api/login', (req, res) => {
	res.json()
})

app.listen(3000)
console.log('====================================');
console.log('listening on 3000');
console.log('====================================');
