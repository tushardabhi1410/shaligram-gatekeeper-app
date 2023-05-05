

class StaffModal {

  String? id;
  StaffTypeModel? visitortype;
  ImageModel? image;
  ImageModel? image_other;
  CourierType? courier_type;
  StaffType? staff_type;
  String? max_checkout_time;
  bool? time_limit_exceeded;
  String? mobile_no;
  String? email;
  String? name;
  String? is_valid;
  bool? regular_visitor;
  bool? is_reported;
  bool? number_verified;
  String? checked_in_at;
  String? checked_out_at;
  String? expected_checkin_time;
  String? in_out_status;
  String? duration;
  String? vehicle_no;
  String? verification_msg;
  String? remark;
  String? flat_id;
  String? flat_no;
  String? building_id;
  String? building_name;
  String? project_id;
  String? project_name;
  String? gate_key;
  String? validated_by_name;
  String? reported_by_name;
  String? created_by;
  String? validation_date;


  StaffModal(
      {
        this.id,
        this.visitortype,
        this.image,
        this.image_other,
        this.courier_type,
        this.staff_type,
        this.max_checkout_time,
        this.time_limit_exceeded,
        this.mobile_no,
        this.email,
        this.name,
        this.is_valid,
        this.regular_visitor,
        this.checked_in_at,
        this.checked_out_at,
        this.expected_checkin_time,
        this.in_out_status,
        this.duration,
        this.vehicle_no,
        this.verification_msg,
        this.remark,
        this.flat_id,
        this.flat_no,
        this.building_id,
        this.building_name,
        this.project_id,
        this.project_name,
        this.gate_key,
        this.is_reported,
        this.number_verified,
        this.validated_by_name,
        this.reported_by_name,
        this.created_by,
        this.validation_date,
      });

  StaffModal.fromJson(Map<String, dynamic> json) {
    // debugger();
    id = json['id'].toString();
    max_checkout_time = json['max_checkout_time'].toString();
    time_limit_exceeded = json['time_limit_exceeded']!=null?json['time_limit_exceeded']:false;
    mobile_no = json['mobile_no'].toString();
    email = json['email'].toString();
    name = json['name'].toString();
    is_valid = json['is_valid'].toString();
    checked_in_at = json['checked_in_at'].toString();
    checked_out_at = json['checked_out_at'].toString();
    expected_checkin_time = json['expected_checkin_time'].toString();
    in_out_status = json['in_out_status'].toString();
    duration = json['duration'].toString();
    vehicle_no = json['vehicle_no'].toString();
    remark = json['remark'].toString();
    verification_msg = json['verification_msg'].toString();
    flat_id = json['flat_id'].toString();
    flat_no = json['flat_no'].toString();
    building_id = json['building_id'].toString();
    building_name = json['building_name'].toString();
    project_id = json['project_id'].toString();
    project_name = json['project_name'].toString();
    gate_key = json['gate_key'].toString();
    validated_by_name = json['validated_by_name'].toString();
    reported_by_name = json['reported_by_name'].toString();
    created_by = json['created_by'].toString();
    validation_date = json['validation_date'].toString();



    regular_visitor = json['regular_visitor']!=null?json['regular_visitor']:false;
    is_reported = json['is_reported']!=null?json['is_reported']:false;
    is_reported = json['number_verified']!=null?json['number_verified']:false;

    try{if (json['visitor_type'] != null) {
      // print(json['visitor_type']);
      visitortype = StaffTypeModel.fromJson(json['visitor_type']);
      // print(visitortype);
    }}catch(ex){print(ex);}
    try{if (json['image'] != null) {
      image = ImageModel.fromJson(json['image']);
    }}catch(ex){print(ex);}
    try{ if (json['image_other'] != null) {
      image_other = ImageModel.fromJson(json['image_other']);
    } }catch(ex){print(ex);}
    try{ if (json['courier_type'] != null) {
      courier_type = CourierType.fromJson(json['courier_type']);
    }}catch(ex){print(ex); }
    try{ if (json['staff_type'] != null) {
      staff_type = StaffType.fromJson(json['staff_type']);
    }}catch(ex){print(ex); }


  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['max_checkout_time'] = max_checkout_time;
    data['mobile_no'] = mobile_no;
    if (visitortype != null) {
      data['visitor_type'] = visitortype?.toJson();
    }
    if (image != null) {
      data['image'] = image?.toJson();
    }
    if (image_other != null) {
      data['image_other'] = image_other?.toJson();
    }
    if (courier_type != null) {
      data['courier_type'] = courier_type?.toJson();
    }
    if (staff_type != null) {
      data['staff_type'] = staff_type?.toJson();
    }
    return data;
  }
}

class StaffType {
  String? id;
  String? type;
  String? time_limit;

  StaffType(
      {this.id,
        this.type,
      });

  StaffType.fromJson(Map<String, dynamic> json) {
    id = json['id'].toString();
    type = json['type'].toString();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['type'] = type;
    return data;
  }
}

class StaffTypeModel {
  String? id;
  String? type;
  String? time_limit;

  StaffTypeModel(
      {this.id,
        this.type,
        this.time_limit,});

  StaffTypeModel.fromJson(Map<String, dynamic> json) {
    id = json['id'].toString();
    type = json['type'].toString();
    time_limit = json['time_limit'].toString();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['type'] = type;
    data['time_limit'] = time_limit;
    return data;
  }
}
class ImageModel {
  String? id;
  String? url;
  String? tag;

  ImageModel(
      {this.id,
        this.url,
        this.tag,});

  ImageModel.fromJson(Map<String, dynamic> json) {
    id = json['id'].toString();
    url = json['url'].toString();
    tag = json['tag'].toString();
  }
  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['url'] = url;
    data['tag'] = tag;
    return data;
  }
}
class CourierType {
  String? id;
  String? name;
  ImageModel? image;

  CourierType(
      {this.id,
        this.name,
        this.image,});

  CourierType.fromJson(Map<String, dynamic> json) {
    id = json['id'].toString();
    name = json['name'].toString();
    if(json['image']!=null) {
      image = ImageModel.fromJson(json['image']);
    }
  }
  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['name'] = name;
    data['image'] = image?.toJson();
    return data;
  }
}

