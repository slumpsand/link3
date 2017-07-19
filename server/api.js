const router = require("express").Router();

router.get("/", (req, res) => {
  res.send("Hello, World!\n");
});

module.exports = router;
