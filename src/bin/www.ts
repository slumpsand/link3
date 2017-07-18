#!/usr/bin/env node

import * as http from "http";

import config from "../server/config";
import app from "../server/app";

console.log(`listening on ${config.bind}`);
http.createServer(app)
  .listen(config.bind.port, config.bind.host);
