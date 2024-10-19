// ignore_for_file: avoid_print

import 'dart:isolate';

void main() async {
  // Create a ReceivePort for the main isolate
  ReceivePort mainReceivePort = ReceivePort();

  // Spawn a new isolate and pass it the main SendPort
  await Isolate.spawn(isolateEntryPoint, mainReceivePort.sendPort);

  // Wait for the isolate to send us its SendPort
  SendPort? isolateSendPort;
  mainReceivePort.listen(
    (message) {
      if (message is SendPort) {
        isolateSendPort = message; // Capture the isolate's SendPort
      } else {
        print('User count updated: $message'); // Print user count from isolate
      }
    },
  );

  // Wait for isolate's SendPort to be available
  await Future.delayed(const Duration(seconds: 1));

  // Adding users via isolate
  isolateSendPort?.send('addUser'); // Add user 1
  await Future.delayed(const Duration(seconds: 1));

  isolateSendPort?.send('addUser'); // Add user 2
  await Future.delayed(const Duration(seconds: 1));

  // Isolate sends the updated user count back after each operation
}

// Singleton class
class UsersWithIsolatedSingleton {
  // Private constructor
  UsersWithIsolatedSingleton._();

  // Singleton instance
  static UsersWithIsolatedSingleton? _instance;

  // Getter for the singleton instance
  static UsersWithIsolatedSingleton get instance {
    _instance ??= UsersWithIsolatedSingleton._();
    return _instance!;
  }

  // User count
  int userCounts = 0;

  // Method to add a new user
  void addNewUser() {
    userCounts++;
  }
}

// The isolateEntryPoint function creates a singleton within the isolate and listens
// for messages from the main isolate.
void isolateEntryPoint(SendPort mainSendPort) {
  // Creating the singleton instance in the isolate
  UsersWithIsolatedSingleton user = UsersWithIsolatedSingleton.instance;

  // The ReceivePort listens for messages from the main isolate,
  // and a SendPort is used to send messages back to the main isolate.
  ReceivePort isolateReceivePort = ReceivePort();

  // Send the port to the main isolate so it can communicate
  mainSendPort.send(isolateReceivePort.sendPort);

  // Listen for messages from the main isolate
  isolateReceivePort.listen(
    (message) {
      if (message == 'addUser') {
        // Add a new user in the isolate
        user.addNewUser();
        // Send the updated count back to main
        mainSendPort.send(user.userCounts);
      }
    },
  );
}
