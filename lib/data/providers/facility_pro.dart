
import 'package:trade_hall/data/models/facility_info_model.dart';
import 'package:trade_hall/data/repositories/facility_repo.dart';

import '../../core/constants/typedef.dart';



class FacilityProvider {
  final FacilityRepository facilityRepository ;

  FacilityProvider({required this.facilityRepository});

  Future<FacilityInfoModel?> getFacilityInfo(parameters params) async {
    try {
      parameters? data = await facilityRepository.getInfo(params);
      if (data != null) {
        return FacilityInfoModel.fromJson(data);
      } else {
        return null;
      }
    } catch (e) {
      print("error in FacilityProvider  $e");
      return null;
    }
  }
}
