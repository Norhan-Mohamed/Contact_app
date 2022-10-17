import 'package:contactapp/Contact.dart';
import 'package:contactapp/contactUpdate.dart';
import 'package:flutter/material.dart';

import 'Helper.dart';

class Home extends StatefulWidget {
  @override
  _homeState createState() => _homeState();
}

class _homeState extends State<Home> {
  // @override
  List<Contact> contactList = [];
  TextEditingController nameController = TextEditingController();
  TextEditingController numberController = TextEditingController();
  TextEditingController urlController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        centerTitle: true,
        title: Text(
          'My Contacts',
          style: TextStyle(
              color: Colors.blue, fontWeight: FontWeight.bold, fontSize: 35),
        ),
      ),
      backgroundColor: Colors.white,
      body: Padding(
        padding: EdgeInsets.all(20),
        child: FutureBuilder<List<Contact>>(
            future: ContactProvider.instance.getContact(),
            builder: (context, snapshot) {
              if (snapshot.hasError)
                return Center(
                  child: Text(snapshot.error.toString()),
                );
              if (!snapshot.hasData) {
                return CircularProgressIndicator();
              } else {
                contactList = snapshot.data!;
                return GridView.builder(
                    gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
                        maxCrossAxisExtent: 200,
                        crossAxisSpacing: 20,
                        mainAxisSpacing: 20),
                    itemCount: contactList.length,
                    itemBuilder: (context, index) {
                      Contact contact = contactList[index];
                      return Container(
                          padding: const EdgeInsets.all(8),
                          child: Center(
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                IconButton(
                                  onPressed: () {
                                    Navigator.of(context).push(
                                        MaterialPageRoute(
                                            builder: (context) =>
                                                ContactUpdate(contact)));
                                  },
                                  icon: CircleAvatar(
                                    radius: 70,
                                    child: Image.network(contact.image),
                                  ),
                                ),
                                Text(
                                  maxLines: 3,
                                  contact.name,
                                  style: TextStyle(
                                      color: Colors.black,
                                      fontWeight: FontWeight.w600,
                                      fontSize: 20),
                                ),
                                Text(
                                  contact.number.toString(),
                                  style: TextStyle(
                                      color: Colors.black45,
                                      fontWeight: FontWeight.w400,
                                      fontSize: 20),
                                ),
                              ],
                            ),
                          ));
                    });
              }
            }),
      ),
      floatingActionButton: FloatingActionButton(
          child: Icon(Icons.add),
          onPressed: () async {
            await showModalBottomSheet(
              isScrollControlled: true,
              shape: RoundedRectangleBorder(
                  borderRadius:
                      BorderRadius.vertical(top: Radius.circular(25.0))),
              context: context,
              barrierColor: Colors.white70,
              backgroundColor: Colors.white,
              builder: (context) => Padding(
                padding: MediaQuery.of(context).viewInsets,
                child: Container(
                  child: Padding(
                      padding: EdgeInsets.symmetric(horizontal: 18.0),
                      child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Padding(
                              padding: EdgeInsets.symmetric(horizontal: 12.0),
                            ),
                            TextFormField(
                              controller: nameController,
                              decoration:
                                  InputDecoration(hintText: 'Contact Name'),
                              autofocus: true,
                            ),
                            TextFormField(
                              controller: numberController,
                              decoration:
                                  InputDecoration(hintText: 'Contact Number'),
                            ),
                            TextFormField(
                              controller: urlController,
                              decoration: InputDecoration(
                                  hintText: 'Contact Image URL'),
                            ),
                            SizedBox(
                              height: 10,
                            ),
                            Container(
                              width: 200,
                              height: 35,
                              child: ElevatedButton(
                                onPressed: () async {
                                  await ContactProvider.instance.insert(Contact(
                                      image: urlController.text,
                                      name: nameController.text,
                                      number:
                                          int.parse(numberController.text)));
                                  print(contactList);
                                  Navigator.pop(context);
                                },
                                child: Text(
                                  'ADD',
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
                            SizedBox(height: 20),
                          ])),
                ),
              ),
            );
            setState(() {});
          }),
    );
  }
}
