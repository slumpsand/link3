#!/usr/bin/env node

import { Config } from "../server/config";

const fs = require("fs");
const http = require("http");

const config = JSON.parse(fs.readFileSync("config.json", "utf8")) as Config;

console.log(`listening on ${config.bind.host}:${config.bind.port}`);
http.createServer(require("../server/app"))
  .listen(config.bind.port, config.bind.host);
