import 'package:flutter/material.dart';

class HSDeviceModel {
  String? deviceIcon;
  String? deviceName;
  String? status;
  bool? isOn = false;
  bool? isFav = false;
  int? deviceId;

  HSDeviceModel({this.deviceIcon, this.deviceName, this.status, this.isOn, this.isFav, this.deviceId});
}

class HsBrightnessModel {
  Color? color;

  HsBrightnessModel({this.color});
}

class HSRoomListModel {
  String? roomName;
  String? status;
  bool? isOn = false;

  HSRoomListModel({this.roomName, this.status, this.isOn});
}

class HSUserProfileModel {
  String? image;
  String? name;

  HSUserProfileModel({this.image, this.name});
}

class HSNewSceneModel {
  String? deviceName;
  String? device;
  bool? isOn = false;
  bool? isAdd = false;

  HSNewSceneModel({this.deviceName, this.device, this.isOn, this.isAdd});
}
