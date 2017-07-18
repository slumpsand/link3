import express from "express";

import config from "./config";
import db from "./db";

const app = express();

app.use(require("./routes"));

export default app;
