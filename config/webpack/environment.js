const { environment } = require("@rails/webpacker");
const webpack = require("webpack");

environment.plugins.append(
  "Provide",
  new webpack.ProvidePlugin({
    $: "jquery",
    jQuery: "jquery",
    Popper: ["popper.js", "default"], // Popper.jsの設定
  })
);

module.exports = environment;
