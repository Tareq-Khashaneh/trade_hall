
import 'package:trade_hall/data/models/session_details_model.dart';
import 'package:trade_hall/data/models/session_model.dart';
import 'package:trade_hall/data/repositories/session_repo.dart';

import '../../core/constants/typedef.dart';

class SessionProvider {
  final SessionsRepository _sessionsRepo ;

  SessionProvider({required SessionsRepository sessionsRepo}) : _sessionsRepo = sessionsRepo;

  Future<List<SessionModel>?> getAllSessions(parameters params) async {
    try {
      List<SessionModel>? sessions;
      List<dynamic>? data = await _sessionsRepo.getAllSessions(params);
      List<SessionModel> temp = [];
      if (data != null) {
        for (var s in data) {
          temp.add(SessionModel.fromJson(s));
        }
        sessions = temp;
      }
      return sessions;
    } catch (e) {
      print("error in SessionProvider $e");
      return null;
    }
  }

  Future<SessionDetailsModel?> getSessionById(parameters params) async {
    try {
      parameters? data = await _sessionsRepo.getSessionById(params);
      if (data != null) {
        return SessionDetailsModel.fromJson(data);
      }
      return null;
    } catch (e) {
      print("error in SessionProvider $e");
      return null;
    }
  }
}
