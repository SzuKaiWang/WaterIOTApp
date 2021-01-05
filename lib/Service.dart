import 'dart:io';
import 'dart:convert';
import 'package:flutterapptest123/Model.dart';

class CHTIotAPI {
  static const String defaultUrl='https://iot.cht.com.tw/iot/v1/';

  var httpClient;

  CHTIotAPI() {
    httpClient = new HttpClient();
  }

  /// orp 氧化還原ORP
  /// do 溶氧量DO
  /// ec 導電度EC
  /// ntu 混濁度
  /// temp 溫度
  /// hw 水深
  /// target 綜合指標
  ///
  /// https://iot.cht.com.tw/iot/v1/device/24757820442/rawdata
  /// String endPoint = 'https://iot.cht.com.tw/iot/v1/device/24757820442/sensor/ph/rawdata/saved';
  ///
  /// 『 M1 』設備資訊 (編號:24757820442)
  /// M1: DK2RZHFSWUXGYK0KKT
  ///
  /// 『 M2 』設備資訊 (編號:25159678769)
  /// M2: DKUMGHA9H2XH09KSHK
  ///
  /// 『 M3 』設備資訊 (編號:25586812231)
  /// M3: DK031HZ9GTKAP1EPE9
  ///

  Future<String> getFeaturedDeviceData() async {
    String endPoint = 'https://iot.cht.com.tw/iot/v1/device/25159678769/rawdata';
    Map<String,String> headers = {
      'CK':'DKUMGHA9H2XH09KSHK'
    };
    try {
      var request = await httpClient.getUrl(Uri.parse(endPoint));
      var headers = Map<String, String>();
      headers['CK'] = 'DKUMGHA9H2XH09KSHK';
      request.headers.add('CK', 'DKUMGHA9H2XH09KSHK');
      var response = await request.close();
      if (response.statusCode == HttpStatus.OK) {
        var json = await response.transform(utf8.decoder).join();
        // var data = jsonDecode(json);
        // List<DeviceData> value = data.map((model) => new DeviceData.fromJson(model)).toList();
        // // return DeviceDataFromJson(json);
        // print(value);
        return json;
      } else {
        // return List<DeviceData>();
        // return 'Error getting IP address:\nHttp status ${response.statusCode}';
      }
    } catch (exception) {
      // return 'Failed getting IP address';
    }
    // return DeviceDataFromJson(response.body);
  }


  Future<String> postFeaturedData(String id, String time, String value) async {
    String endPoint = 'https://iot.cht.com.tw/iot/v1/device/25159678769/rawdata';
    Map<String,String> headers = {
      'CK':'DKUMGHA9H2XH09KSHK'
    };

    Map<String, Object> jsonMap = {
      'id':id,
      'time':time,
      'save': true,
      'value':[value]
    };

    List jsonList = [
      jsonMap
    ];

    try {
      var client = HttpClient();
      var request = await client.postUrl(Uri.parse(endPoint));
      // var headers = Map<String, String>();
      // headers['CK'] = 'DKUMGHA9H2XH09KSHK';
      request.headers.add('CK', 'DKUMGHA9H2XH09KSHK');
      // request.headers.set(HttpHeaders.contentTypeHeader, "application/json; charset=UTF-8");
      var test = '[{"id":$id,"time":$time,"save": ${true}, "value":${[value]}}]';
      //request.write(test);
       request.add(utf8.encode(json.encode(jsonList)));

      var response = await request.close();
      print(response.statusCode);
      if (response.statusCode == HttpStatus.OK) {
        //var json = await response.transform(utf8.decoder).join();
        // var data = jsonDecode(json);
        // List<DeviceData> value = data.map((model) => new DeviceData.fromJson(model)).toList();
        // // return DeviceDataFromJson(json);
        // print(value);
        return "OK";
      } else {
        // return List<DeviceData>();
        // return 'Error getting IP address:\nHttp status ${response.statusCode}';
      }
    } catch (exception) {
      // return 'Failed getting IP address';
    }
    // return DeviceDataFromJson(response.body);
  }
}