fastlane documentation
================
# Installation

Make sure you have the latest version of the Xcode command line tools installed:

```
xcode-select --install
```

Install _fastlane_ using
```
[sudo] gem install fastlane -NV
```
or alternatively using `brew cask install fastlane`

# Available Actions
## iOS
### ios code_cov
```
fastlane ios code_cov
```
Do a code coverage 
### ios discord_notification
```
fastlane ios discord_notification
```
Send notification on discord channel
### ios send_telegram
```
fastlane ios send_telegram
```
Sends Telegram notification
### ios tweet
```
fastlane ios tweet
```
Creates a tweet on new version
### ios screenshots
```
fastlane ios screenshots
```
Additionally, this will add device frames around the screenshots and add the correct titles
### ios email_notification
```
fastlane ios email_notification
```
Send email notifications for testers
### ios beta_testflight
```
fastlane ios beta_testflight
```
Deploy to TestFlight

----

This README.md is auto-generated and will be re-generated every time [fastlane](https://fastlane.tools) is run.
More information about fastlane can be found on [fastlane.tools](https://fastlane.tools).
The documentation of fastlane can be found on [docs.fastlane.tools](https://docs.fastlane.tools).
