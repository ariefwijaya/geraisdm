#!/bin/bash
cd "$(dirname "$0")"
cd _localization_gen
npm install
node index 'in/langs.csv' -p '../assets/localization' -s
cd ../
if ! command -v fvm &> /dev/null
then
    flutter clean
    flutter pub get
    flutter pub run build_runner build --delete-conflicting-outputs
    flutter pub run easy_localization:generate -S "assets/localization" -f keys -O "lib/constant" -o "localizations.g.dart"
    
else
    fvm flutter clean
    fvm flutter pub get
    fvm flutter pub run build_runner build --delete-conflicting-outputs
    fvm flutter pub run easy_localization:generate -S "assets/localization" -f keys -O "lib/constant" -o "localizations.g.dart"
fi

#To generate code coverages
#brew instal lcov
#genhtml -o coverage coverage/lcov.info
