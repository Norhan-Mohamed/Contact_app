import 'Helper.dart';

class Contact {
  late int? id;
  late String name;
  late int number;
  late String image;

  Contact({
    this.id,
    required this.name,
    required this.number,
    required this.image,
  });
  Contact.fromMap(Map<String, dynamic> map) {
    this.image = map[contactImage];
    if (map[contactId] != null) this.id = map[contactId];
    this.name = map[contactName];
    this.number = map[contactNumber];
  }
  Map<String, dynamic> toMap() {
    Map<String, dynamic> map = {};
    map[contactImage] = this.image;
    if (this.id != null) map[contactId] = this.id;
    map[contactName] = this.name;
    map[contactNumber] = this.number;
    return map;
  }
}
