# React Native library testing with Travis CI

1. Create new RN project inside library folder
  ```
  react-native init example
  ```
2. Copy `scripts` and `example/scripts` folders

3. Go to example folder and update package.json
  ```json
    ...
    "scripts": {
      ...
      "preinstall": "node scripts/pre-install.js",
      "appium": "appium",
      "build:android": "scripts/build-android.sh",
      "build:ios": "scripts/build-ios.sh",
      "test:android": "appium-helper --platform android",
      "test:ios": "appium-helper --platform ios",
      "test": "jest",
      "test:local-e2e": "OS=both scripts/run-local-tests.sh",
      "run-emulator:android": "scripts/run-android-emulator.sh",
      "kill-emulator:android": "scripts/kill-android-emulator.sh"
      ...
    },
    "dependencies": {
      ...
      "your-rn-library": "file:../your-rn-library-latest.tgz"
    },
    "devDependencies": {
      "appium": "1.8.1",
      "babel-jest": "22.4.4",
      "babel-preset-env": "1.7.0",
      "babel-preset-react-native-stage-0": "1.0.1",
      "babel-preset-react-native": "4.0.0",
      "babel-preset-stage-0": "6.24.1",
      "jest": "22.4.4",
      "prop-types": "15.6.0",
      "react-test-renderer": "16.3.1",
      "tape-async": "2.1.1",
      "tipsi-appium-helper": "2.1.3",
      "webdriverio": "4.7.1"
    },
    "jest": {
      "preset": "react-native"
    }
  ```

4. Make testing app and add tests

5. In the root directory of your library, create a file named .travis.yml (see [example](https://github.com/densa/travis-react-native-boilerplate/blob/master/.travis.yml))
  - iOS build
  ```
  - os: osx
    language: objective-c
    osx_image: xcode9.4
  ```
  - Android build
  ```
    - os: linux
    language: android
    jdk: oraclejdk8
    sudo: required
    android:
      components:
        - platform-tools
        - tools
        - build-tools-26.0.3
        - android-21
        - android-26
        - sys-img-armeabi-v7a-android-21
        - extra-android-m2repository
        - extra-google-m2repository
        - extra-google-google_play_services
  ```
- If you need run test without RN
```
- language: node_js
  node_js:
    - "9"
```
6. Create `.travis` folder and copy files from this repo

7. Go to travis.org and add the repo that you want to use Travis with
