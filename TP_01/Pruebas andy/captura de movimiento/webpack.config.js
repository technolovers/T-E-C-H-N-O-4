const path = require("path");
require("babel-polyfill");
const mode = [ 'development', 'production' ]

module.exports = {
    mode: mode[0],
    entry: ["babel-polyfill", "./src/app.js"],
    output: {
      path: path.join(__dirname, "/public/"),
      filename: "app.js"
    },
    module: {
      rules: [
        {
          test: /\.js$/,
          exclude: /(node_modules)/,
          use: {
            loader: "babel-loader",
            options: {
              presets: ["babel-preset-env"],
            }
          }
        }
      ]
    }
  };
