class DirectoryModal {

  String? id;
  StaffTypeModel? visitortype;
  // ImageModel? image;
  ImageModel? image_other;
  Profession? profession;
  User? user;
  CourierType? courier_type;
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
  String? user_type;
  String? gate_key;
  String? validated_by_name;
  String? reported_by_name;
  String? created_by;
  String? validation_date;


  DirectoryModal(
      {
        this.id,
        this.visitortype,
        // this.image,
        this.image_other,
        this.user,
        this.courier_type,
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
        this.user_type,
        this.gate_key,
        this.is_reported,
        this.number_verified,
        this.validated_by_name,
        this.reported_by_name,
        this.created_by,
        this.validation_date,
      });

  DirectoryModal.fromJson(Map<String, dynamic> json) {
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
    user_type = json['user_type'].toString();
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

    try{if (json['profession'] != null) {
      // print(json['visitor_type']);
      profession = Profession.fromJson(json['profession']);
      // print(visitortype);
    }}catch(ex){print(ex);}

    try{if (json['user'] != null) {
      // print(json['visitor_type']);
      user = User.fromJson(json['user']);
      // print(visitortype);
    }}catch(ex){print(ex);}
    // try{
    //   if (json['image'] != null) {
    //   print("image modal list");
    //   image = ImageModel.fromJson(json['image']);
    //   print(image?.url);
    //   print(name);
    // }}catch(ex){
    //   print("exception");
    //   print(ex);}
    try{ if (json['image_other'] != null) {
      image_other = ImageModel.fromJson(json['image_other']);
    } }catch(ex){print(ex);}
    try{ if (json['courier_type'] != null) {
      courier_type = CourierType.fromJson(json['courier_type']);
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
    // if (image != null) {
    //   data['image'] = image?.toJson();
    // }
    if (image_other != null) {
      data['image_other'] = image_other?.toJson();
    }
    if (courier_type != null) {
      data['courier_type'] = courier_type?.toJson();
    }
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

class Profession {
  String? id;
  String? name;
  ImageModel? image;

  Profession(
      {this.id,
        this.name,
        this.image
      });

  Profession.fromJson(Map<String, dynamic> json) {
    id = json['id'].toString();
    name = json['name'].toString();
    try{
      if (json['image'] != null) {
        print("image modal list");
        image = ImageModel.fromJson(json['image']);
        print(image?.url);
      }}catch(ex){
      print("exception");
      print(ex);}
  }
  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['name'] = name;
    if (image != null) {
      data['image'] = image?.toJson();
    }
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

class User {
  PersonalDetails? personal_details;
  String? id;
  String? name;
  ImageModel? image;

  User(
      {
        this.personal_details,
        this.id,
        this.name,
        this.image
      });

  User.fromJson(Map<String, dynamic> json) {
    id = json['id'].toString();
    name = json['name'].toString();
    try{
      if (json['image'] != null) {
        print("image modal list");
        image = ImageModel.fromJson(json['image']);
        print(image?.url);
      }}catch(ex){
      print("exception");
      print(ex);}
    try{
      if (json['personal_details'] != null) {
        print("image modal list");
        personal_details = PersonalDetails.fromJson(json['personal_details']);
        // print(personal_details?);
      }}catch(ex){
      print("exception");
      print(ex);}
  }
  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['name'] = name;
    if (image != null) {
      data['image'] = image?.toJson();
    }
    if (personal_details != null) {
      data['personal_details'] = personal_details?.toJson();
    }
    return data;
  }
}

class PersonalDetails {
  String? id;
  String? first_name;
  String? last_name;
  String? app_display_name;
  String? user_display_name;
  String? aadhaar_no;
  String? name;
  String? dob;
  String? email;
  String? mobile_no;
  String? marriage_anniversary;
  String? registration_date;
  String? tag;
  String? company;
  // ImageModel? image;

  PersonalDetails(
      {this.id,
        this.first_name,
        this.last_name,
        this.app_display_name,
        this.user_display_name,
        this.aadhaar_no,
        this.name,
        this.dob,
        this.email,
        this.mobile_no,
        this.marriage_anniversary,
        this.registration_date,
        this.tag,
        this.company,
        // this.image
      });

  PersonalDetails.fromJson(Map<String, dynamic> json) {
    id = json['id'].toString();
    first_name = json['first_name'].toString();
    last_name = json['last_name'].toString();
    app_display_name = json['app_display_name'].toString();
    user_display_name = json['user_display_name'].toString();
    aadhaar_no = json['aadhaar_no'].toString();
    name = json['name'].toString();
    dob = json['dob'].toString();
    email = json['email'].toString();
    mobile_no = json['mobile_no'].toString();
    marriage_anniversary = json['marriage_anniversary'].toString();
    registration_date = json['registration_date'].toString();
    tag = json['tag'].toString();
    company = json['company'].toString();
    // try{
    //   if (json['image'] != null) {
    //     print("image modal list");
    //     image = ImageModel.fromJson(json['image']);
    //     print(image?.url);
    //   }}catch(ex){
    //   print("exception");
    //   print(ex);}
  }
  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['first_name'] = first_name;
    data['last_name'] = last_name;
    data['app_display_name'] = app_display_name;
    data['user_display_name'] = user_display_name;
    data['aadhaar_no'] = aadhaar_no;
    data['name'] = name;
    data['dob'] = dob;
    data['email'] = email;
    data['mobile_no'] = mobile_no;
    data['marriage_anniversary'] = marriage_anniversary;
    data['registration_date'] = registration_date;
    data['tag'] = tag;
    data['company'] = company;
    // data['name'] = name;
    // if (image != null) {
    //   data['image'] = image?.toJson();
    // }
    return data;
  }
}



class DirectoryModalNew {
  String? id;
  int? number;
  String? type;
  String? projectid;
  String? projectname;
  String? flatid;
  String? flatname;
  String? contact;
  String? email;
  String? personname;
  String? image;

  DirectoryModalNew(
      {this.id,
        this.number,
        this.type,
        this.projectid,
        this.projectname,
        this.flatid,
        this.flatname,
        this.contact,
        this.email,
        this.personname,
        this.image});

  DirectoryModalNew.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    number = json['number'];
    type = json['type'];
    projectid = json['projectid'];
    projectname = json['projectname'];
    flatid = json['flatid'];
    flatname = json['flatname'];
    contact = json['contact'];
    email = json['email'];
    personname = json['personname'];
    image = json['image'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['number'] = this.number;
    data['type'] = this.type;
    data['projectid'] = this.projectid;
    data['projectname'] = this.projectname;
    data['flatid'] = this.flatid;
    data['flatname'] = this.flatname;
    data['contact'] = this.contact;
    data['email'] = this.email;
    data['personname'] = this.personname;
    data['image'] = this.image;
    return data;
  }
}

