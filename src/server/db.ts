import monk from "monk";

import config from "./config";

const coll = monk(`${config.bind}`).get("links");
export default coll;
