const express = require("express");
const app = express();
const PORT = process.env.PORT || 3000;
const VERSION = process.env.APP_VERSION || "v1";

app.get("/", (req, res) => {
  res.json({
    message: "Hello from " + VERSION,
    timestamp: new Date().toISOString(),
    uptime: process.uptime().toFixed(1) + "s"
  });
});

app.get("/health", (req, res) => {
  res.status(200).json({ status: "ok", version: VERSION });
});

app.listen(PORT, () => {
  console.log("[" + VERSION + "] App started on port " + PORT);
});