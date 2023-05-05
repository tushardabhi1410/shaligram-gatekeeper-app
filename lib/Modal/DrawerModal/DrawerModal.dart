class DrawerModal{
  String? id;
  String? menuname;
  String? ismainmenu;
  String? menuicon;
  String? displayorder;
  String? isactive;
  String? timestamp;
  String? entryUid;
  String? entryDate;
  String? icon;
  String? uniquename;

  DrawerModal(
      {this.id,
        this.menuname,
        this.ismainmenu,
        this.menuicon,
        this.displayorder,
        this.isactive,
        this.timestamp,
        this.entryUid,
        this.entryDate,
        this.icon,this.uniquename});

  DrawerModal.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    menuname = json['menuname'];
    ismainmenu = json['ismainmenu'];
    menuicon = json['menuicon'];
    displayorder = json['displayorder'];
    isactive = json['isactive'];
    timestamp = json['timestamp'];
    entryUid = json['entry_uid'];
    entryDate = json['entry_date'];
    icon = json['icon'];
    uniquename =json['uniquename'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['menuname'] = this.menuname;
    data['ismainmenu'] = this.ismainmenu;
    data['menuicon'] = this.menuicon;
    data['displayorder'] = this.displayorder;
    data['isactive'] = this.isactive;
    data['timestamp'] = this.timestamp;
    data['entry_uid'] = this.entryUid;
    data['entry_date'] = this.entryDate;
    data['icon'] = this.icon;
    data['uniquename'] = this.uniquename;
    return data;
  }
}