class ConfigPractice {
  int? defaultPracticeCards;
  bool shuffleBeforePractice = false;

  ConfigPractice();

  Map<String, dynamic> toJson() => {
        "defaultPracticeCards": defaultPracticeCards,
        "shuffleBeforePractice": shuffleBeforePractice,
      };

  ConfigPractice.fromJson(Map<String, dynamic> map)
      : defaultPracticeCards = map["defaultPracticeCards"],
        shuffleBeforePractice = map["shuffleBeforePractice"];
}
