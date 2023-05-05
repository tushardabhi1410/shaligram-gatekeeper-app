class CommonModal{
  String? id;
  String? name;



  CommonModal(
      {this.id,
        this.name,

      });

  CommonModal.fromJson(Map<String, dynamic> json) {
    id = json['id'].toString();
    name = json['name'];

  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;

    return data;
  }

  @override
  String toString() {
    // TODO: implement toString
    return "$name";
  }
}