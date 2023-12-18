const express = require("express");
const app = express();
const cors = require("cors");

app.use(cors());
app.get("/", (req, res) => {
  console.log("access is arived!!");
  const data = [
    { image_name: "パンダさん", image_data: "16789sdr6yrgfuug2" },
    { image_name: "ライオンさん", image_data: "16789sdr6yrgfuug3" },
    { image_name: "カバさん", image_data: "16789sdr6yrgfuug4" },
  ];
  res.send(data);
});

app.listen(8080, () => {
  console.log("server is running");
});
