class OrderModel {
  final String idServiceProvider;
  final String nameService;
  final String nameUser;
  final String idOrder;
  final String idUser;
  final String nameServiceProvider;
  final String status;
  final String startDate;
  final String imageMother;
  final String token;
  final String endDate;
  final String startHour;
  final String endHour;

  OrderModel({
    required this.idServiceProvider,
    required this.nameService,
    required this.nameUser,
    required this.nameServiceProvider,
    required this.idUser,
    required this.token,
    required this.startDate,
    required this.idOrder,
    required this.endDate,
    required this.status,
    required this.imageMother,
    required this.startHour,
    required this.endHour,
  });

  factory OrderModel.fromMap(Map<String, dynamic> map) {
    return OrderModel(
      token: map['token'],
      idServiceProvider: map['idServiceProvider'],
      idOrder: map['idOrder'],
      imageMother: map['imageMother'],
      nameService: map['nameService'],
      nameServiceProvider: map['nameServiceProvider'],
      nameUser: map['nameUser'],
      status: map['status'],
      idUser: map['idUser'],
      startDate: map['startDate'],
      endDate: map['endDate'],
      startHour: map['startHour'],
      endHour: map['endHour'],
    );
  }
  Map<String, dynamic> toMap() {
    return {
      'idServiceProvider': idServiceProvider,
      'nameServiceProvider': nameServiceProvider,
      'nameService': nameService,
      'nameUser': nameUser,
      'idUser': idUser,
      'startDate': startDate,
      'status': status,
      "idOrder": idOrder,
      'endDate': endDate,
      'startHour': startHour,
      'endHour': endHour,
    };
  }
}
