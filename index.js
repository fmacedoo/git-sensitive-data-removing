const fs = require('fs');

const files = fs.readdirSync('.');

files.map(o => console.log(o));