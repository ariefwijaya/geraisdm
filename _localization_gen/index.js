#!/usr/bin/env node

var program = require('commander');


program
  .version('0.0.1')
  .usage('[options] <file ...>')
  .option('-s, --simply', 'Custom by Arief Wijaya. LangCode only E.g en.json, id.json')
  .option('-p, --path [value]', 'output path, default: out', 'out')
  .option('-d, --delimeter [value]', 'delimeter between filename and lang', '.')
  .option('-t, --transpose', 'transpose input csv file')
  .option('-f, --fieldDelimiter [value]', 'delimiter between fields', ',')
  .option('-r, --readEncoding [value]', 'encoding to use to read files')
  .option('-w, --writeEncoding [value]', 'encoding to use to write files')
  .option('-m, --merge ', 'merge all csv files into a single json file')
  .parse(process.argv);

if (program.args.length === 0) {
   console.error('No files provided as argument!');
   process.exit(1);
}

var fs = require('fs');
var parse = require('csv-parse');
var path = require('path')
var merge = require('lodash.merge');
var objectPath = require('object-path');
var glob = require('glob');

const readOptions = (program.readEncoding ? { 'encoding': program.readEncoding } : null);
const writeOptions = (program.writeEncoding ? { 'encoding': program.writeEncoding } : null);
const parseOptions = { 'delimiter': program.fieldDelimiter || ',' };

let previousLangData = {};

const p = path.join(program.path);
require('mkdirp')(p);

program.args.forEach((arg) => {
  glob(arg, (err, files) => {
    if (err) {
      console.error('Error when reading path ' + arg + ' !', err);
      process.exit(1);
    }
    files.forEach((file) => {
      let content;
      try {
        content = fs.readFileSync(file, readOptions);
      } catch (error) {
        console.error('File ' + file + ' is not readable!', error);
        process.exit(1);
      }

      parse(content, parseOptions, function (err, trans) {
        if (program.transpose) {
          trans = require("lodash-transpose").transpose(trans);
        }

        var o_langs = trans.shift();
        o_langs.shift();

        var langs = o_langs.slice();
        var lang = '';

        var buffer = {};

        while (lang = langs.shift()) {
          lang = lang.toLowerCase();
          buffer[lang] = {};
        }

        var entry = [];
        var key = '';

        while (entry = trans.shift()) {
          key = entry.shift();

          langs = o_langs.slice();
          while (v = entry.shift(), lang = langs.shift()) {
            lang = lang.toLowerCase();
            objectPath.set(buffer[lang], key, v);
          }
        }


        var target_file = '';
        var target = '';

        langs = o_langs.slice();
        while (lang = langs.shift()) {
          lang = lang.toLowerCase();
          if (program.merge) {
            target = lang;
          } else {
            var title = file.split('.').slice(0, -1).join('.');
            if(program.simply){
                // var langSplit = lang.split("_");
                target =lang;// [langSplit[0], langSplit[1].toUpperCase()].join("-");
            }else{
               target = [title, lang].join(program.delimeter);

            }
          }
          target = [target, 'json'].join('.');

          target_file = path.join(p, path.basename(target));

          let currentFileLang = buffer[lang];
          if (program.merge) {
            try {
              if (!previousLangData[lang]) {
                console.log(target_file);
                previousLangData[lang] = {};
              }
              currentFileLang = merge(currentFileLang, previousLangData[lang]);
              previousLangData[lang] = currentFileLang; 
            } catch (err) { /* Do nothing  */ }
          } else {
            console.log(target_file)
          }
          fs.writeFileSync(target_file, JSON.stringify(buffer[lang], null, 2), writeOptions);
        }
        
      });
    })
  })
});
