const express = require("express");
const pug = require("pug");
const body_parser = require("body-parser");

const config = require("./config");
const db = require("./db");

const app = express();

app.set("view engine", "pug");

app.use("/", express.static("public/"));
app.use("/", require("./views"));
app.use("/api", require("./api"));

module.exports = app;
