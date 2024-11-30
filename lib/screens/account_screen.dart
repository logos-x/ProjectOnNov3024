import 'dart:io';
import 'package:buoi4/screens/edit_account.dart';
import 'package:flutter/material.dart';


class AccountScreen extends StatefulWidget {
  const AccountScreen({super.key});

  @override
  _AccountScreenState createState() => _AccountScreenState();
}

class _AccountScreenState extends State<AccountScreen> {
  String username = "Quang Vinh";
  String email = "vinhcbs1tg.com";
  String phoneNumber = "+1234567890";
  String address = "123 Main St, Springfield";
  String profilePicture = 'assets/images/user_avatar.png'; // Default profile picture

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Account Details"),
        backgroundColor: Colors.blueAccent,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Profile Picture
              Center(
                child: GestureDetector(
                  onTap: () {
                    // Optionally implement a feature to change the profile picture
                  },
                  child: CircleAvatar(
                    radius: 60,
                    backgroundColor: Colors.grey.shade300,
                    backgroundImage: AssetImage(profilePicture),
                  ),
                ),
              ),
              const SizedBox(height: 16),
              // User Information
              Center(
                child: Text(
                  username,
                  style: const TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              const SizedBox(height: 8),
              Center(
                child: Text(
                  email,
                  style: const TextStyle(
                    fontSize: 16,
                    color: Colors.grey,
                  ),
                ),
              ),
              const SizedBox(height: 24),
              const Text(
                "Account Details:",
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 8),
              _buildAccountDetailTile("Username", username),
              _buildAccountDetailTile("Phone Number", phoneNumber),
              _buildAccountDetailTile("Address", address),
              const SizedBox(height: 24),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  ElevatedButton(
                    onPressed: () async {
                      // Navigate to Edit Account Screen and wait for updated data
                      final updatedData = await Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => EditAccountScreen(
                            username: username,
                            email: email,
                            phoneNumber: phoneNumber,
                            address: address,
                            profilePicture: profilePicture,
                          ),
                        ),
                      );

                      if (updatedData != null) {
                        setState(() {
                          username = updatedData["username"];
                          email = updatedData["email"];
                          phoneNumber = updatedData["phoneNumber"];
                          address = updatedData["address"];
                          profilePicture = updatedData["profilePicture"];
                        });
                      }
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.blueAccent,
                      padding: const EdgeInsets.symmetric(
                          horizontal: 20, vertical: 12),
                      textStyle: const TextStyle(fontSize: 16),
                    ),
                    child: const Text("Edit Account"),
                  ),
                  ElevatedButton(
                    onPressed: () {
                      // Implement logout functionality
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.redAccent,
                      padding: const EdgeInsets.symmetric(
                          horizontal: 20, vertical: 12),
                      textStyle: const TextStyle(fontSize: 16),
                    ),
                    child: const Text("Logout"),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildAccountDetailTile(String title, String subtitle) {
    return Card(
      margin: const EdgeInsets.symmetric(vertical: 8.0),
      elevation: 2,
      child: ListTile(
        title: Text(title),
        subtitle: Text(subtitle),
      ),
    );
  }
}
