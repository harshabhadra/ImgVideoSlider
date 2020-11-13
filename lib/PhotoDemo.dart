class PhotoDemo {
  List<Photos> photos;

  PhotoDemo({this.photos});

  PhotoDemo.fromJson(Map<String, dynamic> json) {
    if (json['photos'] != null) {
      photos = new List<Photos>();
      json['photos'].forEach((v) {
        photos.add(new Photos.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.photos != null) {
      data['photos'] = this.photos.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Photos {
  String fileId;
  String fileName;
  bool useCoverFormat;
  String fileUrl;
  String attachType;
  String fileType;
  String extension;
  String thumpUrl;
  String previewUrl;

  Photos(
      {this.fileId,
      this.fileName,
      this.useCoverFormat,
      this.fileUrl,
      this.attachType,
      this.fileType,
      this.extension,
      this.thumpUrl,
      this.previewUrl});

  Photos.fromJson(Map<String, dynamic> json) {
    fileId = json['fileId'];
    fileName = json['fileName'];
    useCoverFormat = json['useCoverFormat'];
    fileUrl = json['fileUrl'];
    attachType = json['attachType'];
    fileType = json['fileType'];
    extension = json['extension'];
    thumpUrl = json['thumpUrl'];
    previewUrl = json['previewUrl'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['fileId'] = this.fileId;
    data['fileName'] = this.fileName;
    data['useCoverFormat'] = this.useCoverFormat;
    data['fileUrl'] = this.fileUrl;
    data['attachType'] = this.attachType;
    data['fileType'] = this.fileType;
    data['extension'] = this.extension;
    data['thumpUrl'] = this.thumpUrl;
    data['previewUrl'] = this.previewUrl;
    return data;
  }
}
