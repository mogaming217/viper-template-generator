'use strict';
const util = require("util");
const fs = require("fs");

const PROJ_NAME = "yusuke-mitsumoto-line";
const DOMAIN = process.argv[2];
const today = new Date();

const print = (message) => {
  console.log(message);
};

const replaceList = [
  ["DOMAIN", DOMAIN],
  ["PROJ_NAME", PROJ_NAME],
  ["TODAY", `${today.getFullYear()}/${today.getMonth() + 1}/${today.getDate()}`]
];

const TEMPLATE_PATH = "./template";
const DESTINATION_PATH = `./generated/${DOMAIN}`;

const generate = (template, fileName) => {
  let temp = template;
  replaceList.forEach(array => {
    const target = "#{" + array[0] + "}";
    const regExp = new RegExp(target, "g");
    temp = temp.replace(regExp, array[1]);
  });

  fs.writeFileSync(`${DESTINATION_PATH}/${fileName}`, temp, "utf8");
};

// MAIN

if (!DOMAIN) {
  print("Generator usage: node generator.js DOMAIN_NAME");
  return;
}

if (!fs.existsSync(DESTINATION_PATH)) {
  fs.mkdirSync(DESTINATION_PATH);
}

const files = fs.readdirSync(TEMPLATE_PATH);
files.forEach(file => {
  if (!file.includes(".temp")) {
    return;
  }

  const template = fs.readFileSync(`${TEMPLATE_PATH}/${file}`, "utf8");
  const array = file.split(".");
  const fileName = `${DOMAIN}${array[0]}.${array[1]}`;
  generate(template, fileName);
});
