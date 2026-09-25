import 'dart:convert';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:web_socket_channel/web_socket_channel.dart';

final webSocketProvider = StateNotifierProvider<WebSocketNotifier, WebSocketChannel?>((ref) {
  return WebSocketNotifier();
});

class WebSocketNotifier extends StateNotifier<WebSocketChannel?> {
  WebSocketNotifier() : super(null);

  void connect(String url, String apiKey) {
    final uri = Uri.parse(url);
    final wsUrl = 'wss://${uri.host}:${uri.port}/ws?token=$apiKey';
    
    state = WebSocketChannel.connect(Uri.parse(wsUrl));
    
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
