## Build
The Flutter SDK would be needed in order to run flutter. 

Further instructions can be found detailed here: https://flutter.dev/docs/get-started/install/macos
The most proper way to run the code and test out the mobile app is completely following through the instructions from the link above. While this is comparatively more complex and requires additional software installation, it is the recommended method for thoroughly testing the app. 

However, this can be irritating so for a faster way, the mobile app can also be built on the web.

### Web Build
This opens up a web build from your localhost. 

Run these commands: 
```
flutter channel beta
flutter upgrade
flutter config --enable-web
```

Check if a Chrome device is a connected device for flutter 

```
flutter devices
```

Run the web build to test it out! 
``` 
flutter web build
```

**Note that this application is optimized for mobile, so the drawing canvas functionality and fetching info from website/API functionality can perform inconsistently on the web build**


## Notes
This is an iOS mobile application and is tested out in an iOS emulator in debug mode. 

The star icon that toggles favorite is both a text label icon and a button with an image on it. 
Users can go back to the previous screen as you would on an iOS device, so by swiping back or clicking on the back button.
