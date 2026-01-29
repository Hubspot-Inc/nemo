const { globalMutableWebpackConfig: webpackConfig, merge } = require('shakapacker')

const customConfig = {
  module: {
    rules: [
      {
        test: /\.test\.js$/,
        use: ['ignore-loader']
      },
      {
        test: /node_modules\/(enketo-core|openrosa-xpath-evaluator)\//,
        use: ['babel-loader']
      }
    ]
  }
}

module.exports = merge(webpackConfig, customConfig)
