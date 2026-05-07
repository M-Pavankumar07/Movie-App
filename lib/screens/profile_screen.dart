import 'package:flutter/material.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      appBar: AppBar(
        title: const Text("Profile",),
        backgroundColor: Theme.of(context).appBarTheme.backgroundColor,
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

            Text(
              "Pavan Kumar",
              style: TextStyle(
                color: Theme.of(context).textTheme.bodyMedium!.color,
                fontSize: 22,
                fontWeight: FontWeight.bold,
              ),
            ),

            const SizedBox(height: 5),

            Text("Movie Lover", style: TextStyle(color: Theme.of(context).textTheme.bodyMedium!.color)),

            const SizedBox(height: 30),

            buildTile(
              context: context,
              icon: Icons.dark_mode,
              title: "Dark Mode",
              trailing: Switch(value: true, onChanged: (val) {}),
            ),

            buildTile(
              context: context,
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
              context: context,
              icon: Icons.logout,
              title: "Logout",
              onTap: () {},
            ),
          ],
        ),
      ),
    );
  }

  Widget buildTile({required BuildContext context, required IconData icon, required String title, Widget? trailing, VoidCallback? onTap}) {
    return ListTile(
      leading: Icon(icon, color: Colors.red),
      title: Text(title, style: TextStyle(color: Theme.of(context).textTheme.bodyMedium!.color)),
      trailing: trailing ?? const Icon(Icons.arrow_forward_ios, color: Colors.grey),
      onTap: onTap,
    );
  }
}
