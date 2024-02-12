

import 'package:trade_hall/data/models/data_model.dart';
import 'package:trade_hall/data/repositories/init_repo.dart';

import '../../core/constants/typedef.dart';


class InitProvider {
  
    final InitRepository _initRepository = InitRepository();
    Future<DataModel?> getMainData(parameters params)async{
      try{
        Map<String,dynamic>? data = await _initRepository.getMainData(params);
        if(data != null){
          return DataModel.fromJson(data);
        }else{
          return null;
        }
      }catch(e){
        print("error in InitProvider  $e");
        return null;
      }

    
  }
}