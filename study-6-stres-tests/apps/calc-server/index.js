const express = require("express");
const app = express();
const port = 4000;

app.get("/simple-response", (req, res) => {
  res.send("Hello World!");
});

app.get("/calculation", (req, res) => {
  const { from, to } = req.query;

  parsedFrom = parseInt(from);
  parsedTo = parseInt(to);

  const calculationTime =
    Math.random() * (parsedTo - parsedFrom) + parseInt(parsedFrom);

  const start = Date.now();
  const end = start + Math.round(calculationTime);

  while (end > Date.now()) {
    const calc = Math.random() * Math.random();
  }

  res.send(
    `End of calculation, time: ${(Math.round(calculationTime) / 1000).toFixed(
      4
    )} seconds`
  );
});
