class ChatModel {
  String idChat;
  String imageMother;
  String imageServiceProvider;
  String nameServiceProvider;
  String nameMother;
  String idMother;
  String idServiceProvider;

  ChatModel({
    required this.idChat,
    required this.imageMother,
    required this.imageServiceProvider,
    required this.nameServiceProvider,
    required this.nameMother,
    required this.idMother,
    required this.idServiceProvider,
  });

  factory ChatModel.fromJson(Map<String, dynamic> json) {
    return ChatModel(
      idChat: json["idChat"],
      imageMother: json['imageMother'],
      imageServiceProvider: json['imageServiceProvider'],
      nameServiceProvider: json['nameServiceProvider'],
      nameMother: json['nameMother'],
      idMother: json['idMother'],
      idServiceProvider: json['idServiceProvider'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'idChat': idChat,
      'imageMother': imageMother,
      'imageServiceProvider': imageServiceProvider,
      'nameServiceProvider': nameServiceProvider,
      'nameMother': nameMother,
      'idMother': idMother,
      'idServiceProvider': idServiceProvider,
    };
  }
}
