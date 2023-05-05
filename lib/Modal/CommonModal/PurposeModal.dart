class CommonPurposeModal{
  String? id;
  String? purpose;



  CommonPurposeModal(
      {this.id,
        this.purpose,

      });

  CommonPurposeModal.fromJson(Map<String, dynamic> json) {
    id = json['id'].toString();
    purpose = json['name'];

  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.purpose;

    return data;
  }

  @override
  String toString() {
    // TODO: implement toString
    return "$purpose";
  }
}