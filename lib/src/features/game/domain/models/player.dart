import 'dart:ui';

import 'package:meme_card_game/src/extensions/color_extension.dart';
import 'package:meme_card_game/src/features/game/domain/enums/presence_object_type.dart';

import '../../../../constants/app_constants.dart' as app_constants;
import 'card_choice.dart';

class Player {
  // base parameters
  late final String id;
  late final String login;
  late final Color color;
  late final Color backgroundColor;

  /// [isCurrentUser] only in player's memory
  late final bool isCurrentUser;
  late bool isCreator;
  late bool isConfirm;
  late int? points;
  late Map<String, dynamic>? additionalInfo;

  /// [cardsChoiceHistory] only in player's memory
  late List<CardChoice> cardsChoiceHistory;

  Player({
    required this.id,
    required this.login,
    required this.isCurrentUser,
    this.isCreator = false,
    this.isConfirm = false,
    Color? color,
    Color? backgroundColor,
    this.points = 0,
    this.additionalInfo,
    List<CardChoice>? cardsChoiceHistory,
  }) {
    this.color = color ?? ColorExtension.fromHex(app_constants.baseColorInHex);
    this.backgroundColor = backgroundColor ??
        ColorExtension.fromHex(app_constants.baseBackgroundColorInHex);
    this.cardsChoiceHistory = cardsChoiceHistory ?? [];
  }

  Player.fromMap(
    Map<String, dynamic> data,
    String currentUserId,
  ) {
    id = data["id"];
    login = data["login"];
    color =
        ColorExtension.fromHex(data["color"] ?? app_constants.baseColorInHex);

    backgroundColor = ColorExtension.fromHex(
        data["background_сolor"] ?? app_constants.baseBackgroundColorInHex);
    isCurrentUser = (id == currentUserId);
    isCreator = data["is_creator"] ?? false;
    isConfirm = data["is_confirm"] ?? false;

    points = data["points"] ?? 0;
    additionalInfo = data["additional_info"];
    // cardsChoiceHistory = data["cards_choice_history"]
    //     ? (data["cards_choice_history"] as List)
    //         .map((item) =>
    //             CardChoice.fromMap(item as Map<String, dynamic>, currentUserId))
    //         .toList()
    //     : [];
    cardsChoiceHistory = [];
  }

  Map<String, dynamic> toMap() {
    return {
      "object_type": PresenceObjectType.player.index,
      "id": id,
      "login": login,
      "color": color.toHex(),
      "background_сolor": backgroundColor.toHex(),
      "is_creator": isCreator,
      "is_confirm": isConfirm,
      "points": points,
      "additional_info": additionalInfo,
      // "cards_choice_history":
    };
  }

  @override
  String toString() {
    // TODO: implement toString
    return toMap().toString();
  }
}
