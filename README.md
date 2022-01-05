# Analog Alarm Clock

This is a simple application of creating an alarm clock.

You can use either an Android Emulator or an Android device. This app is **not** optimize to run on iOS or any other Apple device.
How to test run the application:

- Clone this repository
- Open terminal or any CLI you use and move the current working directory to the folder of the repo you just cloned
- If you **have** Flutter environment setup, run `flutter pub get`, and then `flutter run`.
- If you **don't have** Flutter environment ready, follow this [Get Started](https://docs.flutter.dev/get-started/install) provided by Flutter Team.
- And the application should be running on your desired device.

You can check quick demo video of the app [here](https://youtu.be/t4E5XrFaDkE)

Limitation of the app

- The alarm is made to trigger on the same day. The app just change the time it will trigger.
- Triggered alarm have not disabled or continue to the next day
- The App cannot run in background. If the app is closed, a forced closed pop up will appear on the time it should be triggered.
