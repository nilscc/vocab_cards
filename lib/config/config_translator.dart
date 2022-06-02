class ConfigTranslator {
  String from = 'ru';
  String to = 'de';

  ConfigTranslator();

  Map<String, dynamic> toJson() => {
    "from": from,
    "to": to,
  };

  ConfigTranslator.fromJson(Map<String, dynamic> map)
      : from = map["from"],
        to = map["to"];
}