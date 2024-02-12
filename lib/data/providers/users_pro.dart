
import 'package:trade_hall/data/repositories/users_repo.dart';
import '../../core/constants/typedef.dart';
import '../models/user_model.dart';

class UserProvider {
  final UserRepository _userRepo = UserRepository();
   Future<List<UserModel>?> getUsers(parameters params)async{
     try{
       List<UserModel> users = [];
       var data = await _userRepo.getUsers(params);
       List<UserModel> temp = [];
       if(data != null){
         for (var u in data) {
           temp.add(UserModel.fromJson(u));
         }
         users = temp;
       }
       return users;
     }catch(e){
       print("error in product provider $e");
        return null;
     }

  }
}