const http = require("http");

const config = require("../server/config");
const app = require("../server/app");

console.log(`listening on ${config.bind.uri}`);
http.createServer(app).listen(config.bind.port, config.bind.host);
