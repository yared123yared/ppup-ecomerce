# README #

This README would normally document whatever steps are necessary to get your application up and running.

### What is this repository for? ###

* Quick summary
* Version
Gigpoint app is built on Flutter 2.5.2 (stable)
* [Learn Markdown](https://bitbucket.org/tutorials/markdowndemo)

### How do I get set up? ###

#### Summary of set up
##### Step1:
Clone the repo from ```Repo Url```
##### Step2:
Go to project root and execute the following command in console to get the required dependencies:
```sh
flutter pub get 
```
##### Step3:
This project uses inject library that works with code generation, execute the following command to generate files:
```sh
flutter packages pub run build_runner build --delete-conflicting-outputs
```
or watch command in order to keep the source code synced automatically:
```sh 
flutter packages pub run build_runner watch
```
#### Configuration
Add ```configuration.yaml``` file in the project root folder.
This configuration yaml should contain the following keys.
```sh
api_base_url: Base Url for GigPoint GraphQl API.
api_key: Access key provided by GigPoint GraphQl API.

banking_url: Url provided by Rellevate for Banking services
insurance_url: Url provided by Decisely for Insurance services
forgot_password_url: Url provided by PointPickup for Reset password

support_email: Email provided by PointPickup for app support.
support_number: Contact Number provided by PointPickup for app support.

terms_and_conditions: https://www.pointpickup.com/gigpoint-terms-condition/
privacy_policy: https://www.pointpickup.com/gigpointprivacy/
```
#### Dependencies
Go to project root and execute the following command in console to get the required dependencies:
```sh
flutter pub get 
```
#### Database configuration
None
#### How to run tests
Coming up post MVP release
#### Deployment instructions
##### For Android:

```sh
1. Increament the versionCode and versionName in /gigpoint-app/android/app/build.gradle 
2. flutter clean
3. flutter pub get
4. flutter build apk -release
    output: /gigpoint-app/build/app/outputs/flutter-apk/app-release.apk
```
##### For iOS:
Use XCode to setup the project provisioning profiles
In the Xcode, go to Signing & Capabilities tab and use Provisioning profiles section to import profiles for your account.
Use Xcode to generate app builds.
### Contribution guidelines ###

* Writing tests
* Code review
* Other guidelines

### Who do I talk to? ###
If any support needed from [x]cube LABS, please reach out to:
Pranith Gottigundala - pranith.gottigundala@xcubelabs.com
Naveen Aluri - naveen.aluri@xcubelabs.com
* Repo owner or admin
* Other community or team contact


## Folder Structure

```
📦lib
 ┣ 📂bloc
 ┣ 📂config
 ┣ 📂dialog
 ┣ 📂main
 ┣ 📂model
 ┣ 📂screens
 ┃ ┣ 📂account
 ┃ ┃ ┣ 📂address
 ┃ ┃ ┣ 📂profile
 ┃ ┃ ┗ 📂purchases
 ┃ ┣ 📂authentication
 ┃ ┣ 📂banking
 ┃ ┣ 📂general
 ┃ ┃ ┣ 📂onboarding
 ┃ ┃ ┣ 📂settings
 ┃ ┃ ┣ 📂splash
 ┃ ┃ ┣ 📂support
 ┃ ┃ ┗ 📂terms_conditions
 ┃ ┣ 📂home
 ┃ ┣ 📂insurance
 ┃ ┗ 📂shop
 ┣ 📂services
 ┣ 📂utils
 ┣ 📂webservices
 ┣ 📂widgets
```