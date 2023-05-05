class BuilderStaffTypesModal{
  String? id;
  String? type;



  BuilderStaffTypesModal(
      {this.id,
        this.type,

      });

  BuilderStaffTypesModal.fromJson(Map<String, dynamic> json) {
    id = json['id'].toString();
    type = json['type'];

  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['type'] = this.type;

    return data;
  }

  @override
  String toString() {
    // TODO: implement toString
    return "$type";
  }
}