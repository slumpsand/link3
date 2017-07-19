const router = require("express").Router();

router.get("/", (req, res) => {
  res.render("linklist", {});
});

module.exports = router;
