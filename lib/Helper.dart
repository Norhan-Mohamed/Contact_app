import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

import 'Contact.dart';

String contactName = 'name';
final String contactId = 'id';
final String contactNumber = 'number';
final dynamic contactImage = 'image';

class ContactProvider {
  late Database db;
  static final ContactProvider instance = ContactProvider._internal();

  factory ContactProvider() {
    return instance;
  }
  ContactProvider._internal();

  Future open() async {
    db = await openDatabase(join(await getDatabasesPath(), 'contacts.db'),
        version: 1, onCreate: (Database db, int version) async {
      await db.execute('''
create table ContactTable ( 
  $contactId integer primary key autoincrement,
  $contactName text not null,
  $contactNumber integer not null,
  $contactImage text not null
  )
''');
    });
  }

  Future<Contact> insert(Contact contact) async {
    contact.id = await db.insert('ContactTable', contact.toMap());
    return contact;
  }

  Future<List<Contact>> getContact() async {
    List<Map<String, dynamic>> maps = await db.query('ContactTable');
    if (maps.isEmpty)
      return [];
    else {
      List<Contact> contacts = [];
      maps.forEach((element) {
        contacts.add(Contact.fromMap(element as Map<String, dynamic>));
      });
      return contacts;
    }
  }

  Future<int> delete(int? id) async {
    return await db
        .delete('ContactTable', where: '$contactId = ?', whereArgs: [id]);
  }

  Future<int> update(Contact contact) async {
    return await db.update('ContactTable', contact.toMap(),
        where: '$contactId = ?', whereArgs: [contact.id]);
  }

  Future close() async => db.close();
}
