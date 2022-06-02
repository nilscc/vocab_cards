import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:vocab/config/config_practice.dart';
import 'package:vocab/config/config_translator.dart';

class Config extends ChangeNotifier {
  final ConfigTranslator configTranslator;
  final ConfigPractice configPractice;

  Config()
      : configTranslator = ConfigTranslator(),
        configPractice = ConfigPractice();

  Map<String, dynamic> toJson() => {
        "configTranslator": configTranslator,
        "configPractice": configPractice,
      };

  Config.fromJson(Map<String, dynamic> map)
      : configTranslator = ConfigTranslator.fromJson(map["configTranslator"]),
        configPractice = ConfigPractice.fromJson(map["configPractice"]);

  static Future<String> _defaultPath() async => join(
    (await getApplicationDocumentsDirectory()).path,
    "config.json",
  );

  void save({String? path}) async {
    path ??= await _defaultPath();

    final f = File(path);
    final j = toJson();

    f.writeAsStringSync(jsonEncode(j));
  }

  static Future<Config> load({String? path}) async {
    path ??= await _defaultPath();

    final f = File(path);

    if (f.existsSync()) {
      final s = f.readAsStringSync();
      return Config.fromJson(jsonDecode(s));
    }
    else {
      return Config();
    }
  }
}
