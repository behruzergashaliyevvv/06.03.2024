import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ProfileScreen extends StatefulWidget {
  @override
  _ProfileScreenState createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  String name = 'John';
  String surname = 'Doe';
  String phone = '+123456789';

  @override
  void initState() {
    super.initState();
    _loadProfile();
  }

  Future<void> _loadProfile() async {
    final prefs = await SharedPreferences.getInstance();
    setState(() {
      name = prefs.getString('name') ?? 'John';
      surname = prefs.getString('surname') ?? 'Doe';
      phone = prefs.getString('phone') ?? '+123456789';
    });
  }

  Future<void> _updateProfile(String newName, String newSurname, String newPhone) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('name', newName);
    await prefs.setString('surname', newSurname);
    await prefs.setString('phone', newPhone);

    setState(() {
      name = newName;
      surname = newSurname;
      phone = newPhone;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Profile')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: <Widget>[
            CircleAvatar(
              radius: 50,
              backgroundImage: AssetImage('assets/profile.jpg'), // Add your profile image
            ),
            SizedBox(height: 16),
            Text('Name: $name'),
            Text('Surname: $surname'),
            Text('Phone: $phone'),
            SizedBox(height: 16),
            ElevatedButton(
              onPressed: () {
                showModalBottomSheet(
                  context: context,
                  isScrollControlled: true, // This ensures the modal can adjust its height
                  builder: (context) {
                    return ProfileEditSheet(
                      name: name,
                      surname: surname,
                      phone: phone,
                      onSave: _updateProfile,
                    );
                  },
                );
              },
              child: Text('Edit Profile'),
            ),
          ],
        ),
      ),
    );
  }
}

class ProfileEditSheet extends StatelessWidget {
  final String name;
  final String surname;
  final String phone;
  final void Function(String, String, String) onSave;

  ProfileEditSheet({
    required this.name,
    required this.surname,
    required this.phone,
    required this.onSave,
  });

  final nameController = TextEditingController();
  final surnameController = TextEditingController();
  final phoneController = TextEditingController();
  final FocusNode nameFocusNode = FocusNode();
  final FocusNode surnameFocusNode = FocusNode();
  final FocusNode phoneFocusNode = FocusNode();

  @override
  Widget build(BuildContext context) {
    nameController.text = name;
    surnameController.text = surname;
    phoneController.text = phone;

    return Padding(
      padding: EdgeInsets.only(
        bottom: MediaQuery.of(context).viewInsets.bottom, // Adjusts padding when keyboard is open
      ),
      child: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              TextField(
                controller: nameController,
                focusNode: nameFocusNode,
                decoration: InputDecoration(labelText: 'Name'),
                textInputAction: TextInputAction.next,
                onSubmitted: (_) {
                  FocusScope.of(context).requestFocus(surnameFocusNode);
                },
              ),
              TextField(
                controller: surnameController,
                focusNode: surnameFocusNode,
                decoration: InputDecoration(labelText: 'Surname'),
                textInputAction: TextInputAction.next,
                onSubmitted: (_) {
                  FocusScope.of(context).requestFocus(phoneFocusNode);
                },
              ),
              TextField(
                controller: phoneController,
                focusNode: phoneFocusNode,
                decoration: InputDecoration(labelText: 'Phone'),
                keyboardType: TextInputType.phone,
              ),
              SizedBox(height: 16),
              ElevatedButton(
                onPressed: () {
                  onSave(
                    nameController.text,
                    surnameController.text,
                    phoneController.text,
                  );
                  Navigator.of(context).pop();
                },
                child: Text('Update'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
