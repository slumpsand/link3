const fs = require("fs");

let config = JSON.parse(fs.readFileSync("config.json", "utf8"));

config.bind.uri = `${config.bind.host}:${config.bind.port}`;

module.exports = config;
