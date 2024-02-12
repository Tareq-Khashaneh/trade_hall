

import '../../core/constants/typedef.dart';

class SessionModel{
  final String sessionId;
  final String sessionInfo;

  SessionModel({required this.sessionId, required this.sessionInfo});
  factory SessionModel.fromJson(parameters json)
  => SessionModel(sessionId: json['session_id'], sessionInfo: json['session_info']);
}