import 'package:flutter/foundation.dart';
import 'package:meme_card_game/src/models/realtime_exception.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class GameApiService {
  static final _client = Supabase.instance.client;

  static Future<RealtimeChannel?> createRoom(
      String roomTitle, String roomId) async {
    try {
      final channel = _client.channel(
        roomId,
        opts: RealtimeChannelConfig(
          key: _client.auth.currentUser!.id,
          ack: true,
          self: true,
        ),
      );

      // channel.presence
      // print('channel.presence: ${channel.presence}');

      // print(
      //     'channel.presenceState(): ${channel.presenceState()}');

      // channel.presence.onJoin((key, currentPresences, newPresences) {});

      // channel
      //     .on(RealtimeListenTypes.presence, ChannelFilter(event: 'sync'),
      //         (payload, [ref]) {
      //   final onlineUsers = channel.presenceState();
      //   print('onlineUsers : $onlineUsers');
      //   // handle sync event
      // });

      // channel.subscribe();

      // await channel.send(
      //   type: RealtimeListenTypes.presence,
      //   payload: {
      //     "user_id": _client.auth.currentUser,
      //     "points": 0,
      //     "lastThrownCardId": 0,
      //   },
      // );

      // print(
      //     'channel.presence.state - ${channel.presence.state}');

      // todo: how to write data in the channel?
      // todo: how to react to the changes in the channel
      // channel.on(
      //   RealtimeListenTypes.presence,
      //   ChannelFilter(event: 'sync'),
      //   (payload, [ref]) {
      //     print(payload);
      //     print(channel.presenceState());

      //   },
      // );

      if (channel.isErrored) {
        throw RealtimeException(
          "Room creation error",
          "Channel hasn't been created.",
        );
      }

      return channel;
    } catch (e) {
      if (kDebugMode) {
        print("GameApiService - createRoom - e: $e");
        rethrow;
      }
    }
  }

// todo throwCard
  static Future<void> throwCard(String roomId, String cardId) async {
    try {
      final channel = _client.channel(
        roomId,
        opts: RealtimeChannelConfig(key: roomId),
      );

      await channel.send(
        type: RealtimeListenTypes.presence,
        event: 'throwCard',
        payload: {
          "user_id": _client.auth.currentUser,
          "throwCard": cardId,
        },
      );
    } catch (e) {
      if (kDebugMode) {
        print("GameApiService - createRoom - e: $e");
        rethrow;
      }
    }
  }

  static Future<void> removeRoom(String id) async {
    try {
      await _client.removeChannel(_client.channel(id));
    } catch (e) {
      if (kDebugMode) {
        print("GameApiService - createRoom - e: $e");
        rethrow;
      }
    }
  }

  static Future<RealtimeChannel?> joinRoom(String roomId) async {
    try {
      final channel = _client.realtime.channel(
        roomId,
        RealtimeChannelConfig(
          key: _client.auth.currentUser!.id,
          ack: true,
          self: true,
        ),
      );

      return channel;
    } catch (e) {
      if (kDebugMode) {
        print("GameApiService - createRoom - e: $e");
        rethrow;
      }
    }
  }
}
