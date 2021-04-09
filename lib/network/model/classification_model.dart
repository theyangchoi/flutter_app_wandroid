/**
 * 分类 model
 */
class ClassificationModel{
  int courseId;
  int id;
  String name;
  int order;
  int parentChapterId;
  bool userControlSetTop;
  int visible;
  Object children;

  ClassificationModel({
    this.courseId,
    this.id,
    this.name,
    this.order,
    this.parentChapterId,
    this.userControlSetTop,
    this.visible,
    this.children});

  ClassificationModel.fromJson(Map<String,dynamic> json){
    courseId = json['courseId'];
    id = json['id'];
    name = json['name'];
    order = json['order'];
    parentChapterId = json['parentChapterId'];
    userControlSetTop = json['userControlSetTop'];
    visible = json['visible'];
    children = json['children'];
  }

  Map<String,dynamic> toJson(){
    final Map<String,dynamic> data = new Map<String,dynamic>();
    data['courseId'] =  this.courseId;
    data['id'] =  this.id;
    data['name'] =  this.name;
    data['order'] =  this.order;
    data['parentChapterId'] =  this.parentChapterId;
    data['userControlSetTop'] =  this.userControlSetTop;
    data['visible'] =  this.visible;
    data['children'] =  this.children;
    return data;
  }
}