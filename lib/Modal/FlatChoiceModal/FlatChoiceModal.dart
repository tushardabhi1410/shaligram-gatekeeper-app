import 'package:get/get.dart';

import 'FlatChoiceModal.dart';
import 'FlatChoiceModal.dart';

class FlatChoicesModal {
  String? id;
  String? name;
  String? status;
  List<Flats>? flats=[];


  FlatChoicesModal({this.id, this.name,this.status,this.flats});

  FlatChoicesModal.fromJson(Map<String, dynamic> json) {
    id = json['id'].toString();
    name = json['name']??"";
    status = json['status'].toString();
    if (json['flats'] != null && json['flats']!=[]) {
      flats = <Flats>[];
      json['flats'].forEach((v) {
        flats!.add(Flats.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['status'] = this.status;
    if (this.flats != null) {
      data['flats'] = this.flats?.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Flats {
  String? id;
  String? name;
  String? flat_no;
  String? status;
  String? floor;
  String? flat_status;
  String? owner_user_id;

  Flats(
      {this.id,
        this.name,
        this.flat_no,
        this.status,
        this.floor,
        this.flat_status,
        this.owner_user_id});

  Flats.fromJson(Map<String, dynamic> json) {
    id = json['id'].toString()??"";
    name = json['name']??"";
    flat_no = json['flat_no']??"";
    status = json['status'].toString()??"";
    floor = json['floor'] ?? "";
    flat_status = json['flat_status']??"";
    owner_user_id = json['owner_user_id'].toString()??"";
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['flat_no'] = this.flat_no;
    data['status'] = this.status;
    data['floor'] = this.floor;
    data['flat_status'] = this.flat_status;
    data['owner_user_id'] = this.owner_user_id;
    return data;
  }
}

class FlatChoicesModalWithCustomization {
  String? mainid;
  String? mainname;
  String? mainstatus;
  String? flatid;
  String? flatname;
  String? flatstatus;
  String? flatnumber;
  String? flatfloor;
  String? flatowneruserid;



  FlatChoicesModalWithCustomization({

   required this.mainid,
    required this.mainname,
    required this.mainstatus,
    required this.flatid,
    required this.flatname,
    required this.flatstatus,
    required this.flatnumber,
    required this.flatfloor,
    required this.flatowneruserid
  });


}


class VillaAndPlotAndUnitListModel {
  String? project_id;
  String? project_name;
  String? plot_id;
  String? plot_name;
  String? villa_id;
  String? vila_name;
  String? building_id;
  String? building_name;
  String? floor_id;
  String? floor_name;
  String? unit_id;
  String? unit_name;
  String? name;



  VillaAndPlotAndUnitListModel({this.project_id, this.project_name,this.plot_id,this.plot_name,this.building_name,this.name,this.building_id,this.floor_id,this.floor_name,this.unit_id,this.unit_name,this.vila_name,this.villa_id});

VillaAndPlotAndUnitListModel.fromJson(Map<String, dynamic> json) {
    project_id = json['project_id'];
    project_name = json['project_name'];
    plot_id = json['plot_id'];
    plot_name = json['plot_name'];
    villa_id = json['villa_id'];
    vila_name = json['vila_name'];
    building_id = json['building_id'];
    building_name = json['building_name'];
    floor_id = json['floor_id'];
    floor_name = json['floor_name'];
    unit_id = json['unit_id'];
    unit_name = json['unit_name'];
    name = json['name'];

  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if(project_id!=null)   data['project_id'] = this.project_id;
    if(project_name!=null)   data['project_name'] = this.project_name;
    if(plot_id!=null)  data['plot_id'] = this.plot_id;
    if(plot_name!=null) data['plot_name'] = this.plot_name;
    if(villa_id!=null) data['villa_id'] = this.villa_id;
    if(vila_name!=null) data['vila_name'] = this.vila_name;
    if(building_id!=null) data['building_id'] = this.building_id;
    if(building_name!=null) data['building_name'] = this.building_name;
    if(floor_id!=null) data['floor_id'] = this.floor_id;
    if(floor_name!=null) data['floor_name'] = this.floor_name;
    if(unit_id!=null) data['unit_id'] = this.unit_id;
    if(unit_name!=null) data['unit_name'] = this.unit_name;
    if(name!=null)  data['name'] = this.name;

    return data;
  }


}
