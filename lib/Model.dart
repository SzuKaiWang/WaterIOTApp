import 'dart:convert';

DeviceData DeviceDataFromJson(String str) => DeviceData.fromJson(json.decode(str));

class DeviceData {
  List<String> value;
  String id;
  String deviceId;
  String time;

  DeviceData({
    this.value,
    this.id,
    this.deviceId,
    this.time,
  });

  factory DeviceData.fromJson(Map<String, dynamic> json) => new DeviceData(
    value: new List<String>.from(json["value"].map((x) => x.toString())),
    id:  json["id"],
    deviceId:  json["deviceId"],
    time:  json["time"],
  );

  Map<String, dynamic> toJson() => {
    "value": new List<String>.from(value.map((x) => x.toString())),
    "id": id.toString(),
    "deviceId": deviceId.toString(),
    "time": time.toString(),
  };
}
