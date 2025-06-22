class LoginResponseModel {
  final String token;
  final int userId;
  final String nomeCompleto;

  LoginResponseModel({
    required this.token,
    required this.userId,
    required this.nomeCompleto,
  });

  factory LoginResponseModel.fromJson(Map<String, dynamic> json) {
    return LoginResponseModel(
      token: json['token'] as String,
      userId: int.parse(json['userId'].toString()),
      nomeCompleto: json['nomeCompleto'] as String,
    );
  }

  @override
  String toString() {
    return 'LoginResponseModel(userId: $userId, nomeCompleto: $nomeCompleto)';
  }
}