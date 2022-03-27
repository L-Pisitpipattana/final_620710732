class Quiz{
  final String image;
  final String answer;
  final List<String> choices;

  Quiz({
    required this.image,
    required this.answer,
    required this.choices,
  });
  factory Quiz.fromJson(Map<String, dynamic> json){
    return Quiz(
      image: json["image"],
      answer: json["answer"],
      choices: List<String>.from(json['choice_list']),
    );
  }
}