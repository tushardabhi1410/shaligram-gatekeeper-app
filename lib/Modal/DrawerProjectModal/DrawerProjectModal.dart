class DrawerProjectModal{
  String? id;
  String? name;
  String? status;
  String? mobile_view;
  String? website_url;
  String? project_share;
  String? whatsapp_number;
  String? whatsapp_share_text;
  String? call_number;


  DrawerProjectModal(
      {this.id,
        this.name,
        this.status,
        this.mobile_view,
        this.website_url,
        this.project_share,
        this.whatsapp_number,
        this.whatsapp_share_text,
        this.call_number,
        });

  DrawerProjectModal.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    status = json['status'];
    mobile_view = json['mobile_view'];
    website_url = json['website_url'];
    project_share = json['project_share'];
    whatsapp_number = json['whatsapp_number'];
    whatsapp_share_text = json['whatsapp_share_text'];
    call_number = json['call_number'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
  if(id!=null)  data['id'] = this.id;
  if(name!=null)  data['name'] = this.name;
  if(status!=null)   data['status'] = this.status;
  if(mobile_view!=null)  data['mobile_view'] = this.mobile_view;
  if(website_url!=null)  data['website_url'] = this.website_url;
  if(project_share!=null)  data['project_share'] = this.project_share;
  if(whatsapp_number !=null)  data['whatsapp_number'] = this.whatsapp_number;
  if(whatsapp_share_text!=null)  data['whatsapp_share_text'] = this.whatsapp_share_text;
  if(call_number!=null)  data['call_number'] = this.call_number;
    return data;
  }

  String toString() {
    // TODO: implement toString
    return "$name";
  }
}