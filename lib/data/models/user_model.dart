class UserModel {
  final int id;
  late final String userName;
  final String pin;
  final String? perm;
  final int? sessionNumber;
  final int? sessionStatus;

  UserModel(
      {required this.id,
      required this.userName,
      required this.pin,
      required this.perm,
      required this.sessionNumber,
      required this.sessionStatus});

  factory UserModel.fromJson(Map<String, dynamic> data) => UserModel(
      id: data['id'],
      userName: data['username'],
      pin: data['pin'],
      perm: data['perm'],
      sessionNumber: data['session_number'],
      sessionStatus: data['session_status']);
}
