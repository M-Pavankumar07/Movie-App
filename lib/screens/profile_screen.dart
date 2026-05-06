import 'package:flutter/material.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        title: const Text("Profile", style: TextStyle(color: Colors.white)),
        backgroundColor: Colors.black,
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            const SizedBox(height: 20),

            const CircleAvatar(
              radius: 50,
              backgroundImage: AssetImage("assets/Logo.png"),
            ),

            const SizedBox(height: 15),

            const Text(
              "Pavan Kumar",
              style: TextStyle(
                color: Colors.white,
                fontSize: 22,
                fontWeight: FontWeight.bold,
              ),
            ),

            const SizedBox(height: 5),

            const Text("Movie Lover", style: TextStyle(color: Colors.grey)),

            const SizedBox(height: 30),

            buildTile(
              icon: Icons.dark_mode,
              title: "Dark Mode",
              trailing: Switch(value: true, onChanged: (val) {}),
            ),

            buildTile(
              icon: Icons.info,
              title: "About App",
              onTap: () {
                showAboutDialog(
                  context: context,
                  applicationName: "Movie App",
                  applicationVersion: "1.0.0",
                  children: const [Text("Built using flutter")],
                );
              },
            ),

            buildTile(
              icon: Icons.logout,
              title: "Logout",
              onTap: () {},
            ),
          ],
        ),
      ),
    );
  }

  Widget buildTile({required IconData icon, required String title, Widget? trailing, VoidCallback? onTap}) {
    return ListTile(
      leading: Icon(icon, color: Colors.red),
      title: Text(title, style: const TextStyle(color: Colors.white)),
      trailing: trailing ?? const Icon(Icons.arrow_forward_ios, color: Colors.grey),
      onTap: onTap,
    );
  }
}
