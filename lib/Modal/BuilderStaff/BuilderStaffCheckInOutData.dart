class BuilderStaffCheckInOutData {
  String? id;
  String? builderstatffId;
  String? personname;
  String? role;
  String? contact;
  int? badgeno;
  String? checkinTime;
  String? checkinDateTime;
  String? checkoutTime;
  String? checkoutDate;
  String? totaldurations;
  String? profile;

  BuilderStaffCheckInOutData(
      {this.id,
        this.builderstatffId,
        this.personname,
        this.role,
        this.contact,
        this.badgeno,
        this.checkinTime,
        this.checkoutTime,
        this.profile,
        this.checkinDateTime,
        this.totaldurations});

  BuilderStaffCheckInOutData.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    builderstatffId = json['builderstatff_id'];
    personname = json['personname'];
    role = json['role'];
    contact = json['contact'];
    badgeno = json['badgeno'];
    checkinTime = json['checkin_time'];
    checkoutTime = json['checkout_time'];
    totaldurations = json['totaldurations'];
    profile = json['profile'];
    checkinDateTime = json['checkin_datetime'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['builderstatff_id'] = this.builderstatffId;
    data['personname'] = this.personname;
    data['role'] = this.role;
    data['contact'] = this.contact;
    data['badgeno'] = this.badgeno;
    data['checkin_time'] = this.checkinTime;
    data['checkout_time'] = this.checkoutTime;
    data['totaldurations'] = this.totaldurations;
    data['profile'] = this.profile;
    data['checkin_datetime'] = this.checkinDateTime;
    return data;
  }
}