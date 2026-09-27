import 'dart:convert';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:web_socket_channel/web_socket_channel.dart';

final webSocketProvider = StateNotifierProvider<WebSocketNotifier, WebSocketChannel?>((ref) {
  return WebSocketNotifier();
});

class WebSocketNotifier extends StateNotifier<WebSocketChannel?> {
  WebSocketNotifier() : super(null);

  void connect(String url, String username, String password) {
    final uri = Uri.parse(url);
    final credentials = base64Encode(utf8.encode('$username:$password'));
    final wsScheme = uri.scheme == 'https' ? 'wss' : 'ws';
    final wsUrl = '$wsScheme://${uri.host}:${uri.port}/ws';
    
    state = WebSocketChannel.connect(
      Uri.parse(wsUrl),
      protocols: null,
      headers: {
        'Authorization': 'Basic $credentials',
      },
    );
    
    state!.stream.listen(
      (message) {
        // Handle incoming messages
        final data = jsonDecode(message);
        // Process message
      },
      onError: (error) {
        // Handle error
        state = null;
      },
      onDone: () {
        // Handle connection closed
        state = null;
      },
    );
  }

  void sendMessage(Map<String, dynamic> message) {
    state?.sink.add(jsonEncode(message));
  }

  void disconnect() {
    state?.sink.close();
    state = null;
  }

  @override
  void dispose() {
    disconnect();
    super.dispose();
  }
}
