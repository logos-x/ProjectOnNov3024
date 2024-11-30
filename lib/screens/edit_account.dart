import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';

class EditAccountScreen extends StatefulWidget {
  final String username;
  final String email;
  final String phoneNumber;
  final String address;
  final String profilePicture;

  const EditAccountScreen({
    super.key,
    required this.username,
    required this.email,
    required this.phoneNumber,
    required this.address,
    required this.profilePicture,
  });

  @override
  _EditAccountScreenState createState() => _EditAccountScreenState();
}

class _EditAccountScreenState extends State<EditAccountScreen> {
  late TextEditingController usernameController;
  late TextEditingController emailController;
  late TextEditingController phoneController;
  late TextEditingController addressController;
  File? _selectedImage;

  @override
  void initState() {
    super.initState();
    usernameController = TextEditingController(text: widget.username);
    emailController = TextEditingController(text: widget.email);
    phoneController = TextEditingController(text: widget.phoneNumber);
    addressController = TextEditingController(text: widget.address);
  }

  Future<void> _pickImage() async {
    final ImagePicker picker = ImagePicker();
    final XFile? image = await picker.pickImage(source: ImageSource.gallery);

    if (image != null) {
      setState(() {
        _selectedImage = File(image.path);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
        title: const Text("Edit Account"),
    ),
    body: Padding(
    padding: const EdgeInsets.all(16.0),
    child: SingleChildScrollView(
    child: Column(
    children: [
    // Profile Picture
    GestureDetector(
    onTap: _pickImage, // Allow user to pick an image
    child: CircleAvatar(
    radius: 50,
    backgroundImage: _selectedImage != null
    ? FileImage(_selectedImage!)
        : NetworkImage(widget.profilePicture) as ImageProvider,
    ),
    ),
    const SizedBox(height: 16),
    const Text("Tap to change profile picture"),
    const SizedBox(height: 24),
    TextField(
    controller: usernameController,
    decoration: const InputDecoration(labelText: "Username"),
    ),
    const SizedBox(height: 16),
    TextField(
    controller: emailController,
    decoration: const InputDecoration(labelText: "Email"),
    ),
    const SizedBox(height: 16),
    TextField(
    controller: phoneController,
    decoration: const InputDecoration(labelText: "Phone Number"),
    ),
    const SizedBox(height: 16),
    TextField(
    controller: addressController,decoration: const InputDecoration(labelText: "Address"),
    ),
      const SizedBox(height: 24),
      ElevatedButton(
        onPressed: () {
          // Pass updated data and selected image back to AccountScreen
          Navigator.pop(context, {
            "username": usernameController.text,
            "email": emailController.text,
            "phoneNumber": phoneController.text,
            "address": addressController.text,
            "profilePicture": _selectedImage?.path ?? widget.profilePicture,
          });
        },
        child: const Text("Save Changes"),
      ),
    ],
    ),
    ),
    ),
    );
  }
}