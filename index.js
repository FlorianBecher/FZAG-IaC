const express = require('express');
const app = express();

app.use(express.json());

const port = process.env.PORT || 3000;

app.get('/', (req, res) => {
    res.end('200: Working API Response for Testing');
});

app.listen(port, () => {
    console.log(`Server started on port ${port}`);
});