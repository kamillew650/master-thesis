const express = require("express");
const app = express();
const port = 3000;

app.get("/simple-response", (req, res) => {
  res.send("Hello World!");
});

app.get("/calculation-1", (req, res) => {
  let a = 1;
  let b = 2;
  let c;
  while (b < 10000) {
    c = a + b;
    a = b;
    b = c;
  }
  res.send("Hello World!");
});

app.get("/calculation-2", (req, res) => {
  let a = 0;
  while (a < 100000000) {
    let b = Math.random() * 300 * (Math.random() * 700);
    a += 1;
  }
  let response = Math.random();
  res.send(response.toString());
});

app.get("/file", (req, res) => {
  const file = `${__dirname}/files/100MB.file`;
  res.download(file);
});

app.listen(port, () => {
  console.log(`Example app listening on port ${port}`);
});
