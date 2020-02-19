#!/usr/bin/env node
var express = require('express')
var app = express()

app.get('/', function (req, res) {
  res.send('Hello stinking World!')
})

app.get('/dog', function (req, res) {
  res.send('Dos is Ullses!')
})

app.listen(1642, function () {
  console.log('Example app listening on port 1642!')
})