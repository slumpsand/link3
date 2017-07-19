const monk = require("monk");

const config = require("./config");

module.exports = monk(`${config.bind.uri}/${config.db.name}`).get(config.db.collection);
