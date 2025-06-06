import 'dart:developer';
import 'package:socket_io_client/socket_io_client.dart' as IO;
import '../network/api/api_constants.dart';

//! Note: Use connected socket instance from OrderProvider
class SocketService {
  IO.Socket? _socket;

  IO.Socket get socket {
    if (_socket == null) {
      connectToSocket();
    }
    return _socket!;
  }

  void connectToSocket() {
    _socket = IO.io(
      BaseUrl.socketBaseUrl,
      IO.OptionBuilder()
          .setTransports(['websocket']) // Enable WebSocket transport
          .enableAutoConnect() // Auto connect
          .setReconnectionAttempts(5) // Retry 5 times
          .build(),
    );

    _socket?.onConnect((_) {
      log('Connected to the server');
    });

    _socket?.onDisconnect((_) {
      log('Disconnected from the server');
    });

    _socket?.onError((data) {
      log('Socket error: $data');
    });
  }

  void removeSpecificEventListener(String eventName) {
    _socket?.off(eventName); // Remove specific event listener
  }

  void emitEvent(String event, dynamic data) {
    if (_socket != null && _socket!.connected) {
      _socket!.emit(event, data);
    } else {
      connectToSocket();
    }
  }

  void listenToEvent(String event, Function(dynamic) callback) {
    _socket?.on(event, callback);
  }

  void offEvent(String eventName) {
    socket.off(eventName);
  }

  void disconnect() {
    _socket?.dispose();
    log('Socket disconnected');
  }
}
