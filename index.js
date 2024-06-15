require("dotenv").config();
const express = require("express");
const morgan = require("morgan");
const app = express();
const httpProxy = require("http-proxy");
const proxy = httpProxy.createProxyServer();
// Essential Middlewares
app.use(express.json());
app.use(express.urlencoded({ extended: true }));
app.use(morgan("tiny"));

app.use((req, res) => {
  proxy.web(req, res, { target: req.url });
});

app.use("/healthcheck", (req, res) => {
  res.send("Server is up and running");
});

const PORT = 9000 || process.env.PORT;
app.listen(PORT, () => {
  console.log(`Listening on port `);
});
