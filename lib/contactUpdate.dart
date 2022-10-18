import 'package:flutter/material.dart';

import 'Contact.dart';
import 'Helper.dart';

class ContactUpdate extends StatefulWidget {
  Contact contact;
  ContactUpdate(this.contact);
  @override
  _CourseUpdateState createState() => _CourseUpdateState();
}

TextEditingController updatedName = TextEditingController();
TextEditingController updatedNumber = TextEditingController();
TextEditingController updatedImage = TextEditingController();

class _CourseUpdateState extends State<ContactUpdate> {
  @override
  void initState() {
    super.initState();
    updatedName.text = widget.contact.name;
    updatedNumber.text = widget.contact.number.toString();
    updatedImage.text = widget.contact.image;
    // widget.contact;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Contact Details',
          style: TextStyle(
              color: Colors.blue, fontWeight: FontWeight.bold, fontSize: 25),
        ),
        backgroundColor: Colors.transparent,
      ),
      body: Padding(
        padding: const EdgeInsets.all(15.0),
        child: Column(
          children: [
            SizedBox(
              height: 20,
            ),
            CircleAvatar(
              radius: 50,
            ),
            TextFormField(
              decoration: InputDecoration(label: Text(widget.contact.name)),
              controller: updatedName,
              autofocus: true,
            ),
            SizedBox(
              height: 10,
            ),
            TextFormField(
              decoration: InputDecoration(
                  label: Text(widget.contact.number.toString())),
              controller: updatedNumber,
            ),
            SizedBox(
              height: 10,
            ),
            TextFormField(
              decoration: InputDecoration(label: Text(widget.contact.image)),
              controller: updatedImage,
            ),
            SizedBox(
              height: 10,
            ),
            Container(
              color: Color(0xff0977cb),
              width: 200,
              height: 35,
              child: ElevatedButton(
                onPressed: () async {
                  print(widget.contact.toMap());
                  await ContactProvider.instance.update(Contact(
                      id: widget.contact.id,
                      image: updatedImage.text,
                      name: updatedName.text,
                      number: int.parse(updatedNumber.text)));
                  Navigator.pop(context);
                },
                child: Text(
                  'Save',
                  style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontSize: 15),
                ),
                style: ElevatedButton.styleFrom(
                  primary: Color(0xff0977cb),
                ),
              ),
            ),
            SizedBox(
              height: 10,
            ),
            Container(
              width: 200,
              height: 35,
              color: Colors.white,
              child: ElevatedButton(
                  child: Text(
                    'Delete',
                    style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 15,
                        color: Color(0xff0977cb)),
                  ),
                  onPressed: () {
                    showDialog(
                        context: context,
                        builder: (BuildContext context) {
                          return AlertDialog(
                            title: Text(
                              'Delete Contact',
                              style: TextStyle(
                                  color: Colors.black,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 35),
                            ),
                            content: Text(
                              'Are you sure you want to delete this Contact ?',
                              style: TextStyle(
                                  color: Colors.black45,
                                  fontSize: 20,
                                  fontWeight: FontWeight.w400),
                            ),
                            actions: [
                              ElevatedButton(
                                  onPressed: () {
                                    Navigator.of(context).pop();
                                  },
                                  child: Text(
                                    'Cancel',
                                    style: TextStyle(
                                        color: Colors.grey,
                                        fontWeight: FontWeight.bold,
                                        fontSize: 25),
                                  )),
                              ElevatedButton(
                                  onPressed: () async {
                                    if (contactId != null) {
                                      await ContactProvider.instance
                                          .delete(widget.contact.id);
                                    }
                                    Navigator.of(context).pop();
                                    setState(() {});
                                  },
                                  child: Text(
                                    'Yes',
                                    style: TextStyle(
                                        color: Colors.red,
                                        fontWeight: FontWeight.bold,
                                        fontSize: 25),
                                  )),
                            ],
                          );
                        });
                  },
                  style: ElevatedButton.styleFrom(
                    primary: Colors.white,
                  )),
            )
          ],
        ),
      ),
    );
  }
}
