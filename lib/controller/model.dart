import 'package:sqlapi/controller/Apiclass.dart';

class Apimodel {
  int? postId;
  int? id;
  String? name;
  String? email;
  String? body;

  Apimodel({this.postId, this.id, this.name,this.email, this.body});

  Apimodel apiFactory(Map map) {
    return Apimodel(
        postId: map['postId'],
        id: map['id'],
        name: map['name'],
        email: map['email'],
        body: map['body']);
  }
}
