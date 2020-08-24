import 'package:flutter/foundation.dart';
import 'package:geolocator/geolocator.dart';
import 'package:mask/model/store.dart';
import 'package:mask/repository/location_repository.dart';
import 'package:mask/repository/store_repository.dart';
import 'package:provider/provider.dart';

class StoreModel with ChangeNotifier {

  var isLoading = true;

  //with 는 상속이랑 비슷한 사용법.
  List<Store> stores= [];


  final _storeRepository =StoreRepository();//스토어 레포지토리를 알고 연결해줌
         //_ 언더바는 private로 view에서는 절대 알수 없게 만듬.
  final _locationRepository = LocationRepository();

  StoreModel(){
    fetch();
  }

  Future fetch() async {
    isLoading = false;
    notifyListeners();

    Position position = await _locationRepository.getCurrentLocation();

    stores = await _storeRepository.fetch(
        position.latitude,
        position.longitude
    );
    isLoading = true;
    notifyListeners();//다 됬다고 통지를 함.
  }//view 에서는 fetch를 통해서 함.한다리 건너서 함.
}