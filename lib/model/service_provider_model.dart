// lib/models/service_info_model.dart

class ServiceInfoModel {
  final String name;
  final String aboutYou;
  final String idService;
  final String idUser;
  final String eachHour;
  final String eachDay;
  final String nameUser;

  ServiceInfoModel({
    required this.name,
    required this.aboutYou,
    required this.idService,
    required this.idUser,
    required this.nameUser,
    required this.eachHour,
    required this.eachDay,
  });

  factory ServiceInfoModel.fromJson(Map<String, dynamic> json) {
    return ServiceInfoModel(
      name: json['name'],
      aboutYou: json['aboutYou'],
      idService: json['idService'],
      idUser: json['idUser'],
      nameUser: json['nameUser'],
      eachHour: json['eachHour'],
      eachDay: json['eachDay'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'nameUser': nameUser,
      'aboutYou': aboutYou,
      'idService': idService,
      'idUser': idUser,
      'eachHour': eachHour,
      'eachDay': eachDay,
    };
  }
}
