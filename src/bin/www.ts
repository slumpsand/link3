#!/usr/bin/env node

import { Config } from "../server/config";

const fs = require("fs");
const http = require("http");

const config = JSON.parse(fs.readFileSync("../config.json", "utf8")) as Config;

http.createServer(require("../server/app"))
  .on("error", (err: Error) => {
    if (err.syscall != "listen")
      throw err;

    switch (err.code) {
      case "EACCES":
        console.error("can't bind port, need elevated privileges");
        process.exit(1);
        break;
      case "EADDRINUSE":
        console.error("can't bind port, address in use");
        process.exit(1);
        break;

      default:
        throw err;
    }
  })
  .on("listen", () => {
    console.log(`listening on ${config.bind.host}:${config.bind.port}`);
  });
