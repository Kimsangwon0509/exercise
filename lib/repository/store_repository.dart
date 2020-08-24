import 'package:http/http.dart' as http;
import 'package:latlong/latlong.dart';
import 'dart:convert';
import 'package:mask/model/store.dart';

class StoreRepository {
  final _distance =Distance();

  Future<List<Store>> fetch(double lat, double lng) async {
      final stores = List<Store>();
      //fianl stores = List<Store>();
      //var stores = List<Store>();
//    setState(() {
//      isLoading = true;
//    });
        print(lat);
        print(lng);
      var url ='https://8oi9s0nnth.apigw.ntruss.com/corona19-masks/v1/storesByGeo/json?lat=37.5014&lng=126.8826&m=3000';
        //위도 경도에 $lat, $lng넣으면 되야 되는데 안됨 왜?ㅋㅋ
      var response = await http.get(url);
      //print(response);
      final jsonResult = jsonDecode(utf8.decode(response.bodyBytes));
      //print(utf8.decode(response.bodyBytes));
      //print(jsonDecode(utf8.decode(response.bodyBytes)));
      final jsonStores = jsonResult['stores'];
      //print(jsonStores);
      //setState(() {
      stores.clear();//값이 담겨 있으면 지워주는 역활
      jsonStores.forEach((e){
        //print(e);
        final store =Store.fromJson(e);
        final km = _distance.as(
            LengthUnit.Kilometer,
            LatLng(store.lat, store.lat),
            LatLng(lat,lng));
        store.km = km;
        stores.add(store);
        // });
        //isLoading = false;
      });
      //print('Response status: ${response.statusCode}');
      //print('Response body: ${jsonDecode(utf8.decode(response.bodyBytes))}');
      //print(jsonResult['count']);
      //print(jsonResult['stores']);
      print('팻치완료');
      return stores.where((element) {
        return element.remainStat =='plenty' ||
            element.remainStat =='some'||
            element.remainStat =='few';
      }).toList()..sort((a,b)=>b.km.compareTo(a.km));
  }
}//데이터를 가져오는 처리