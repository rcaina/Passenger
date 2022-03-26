import 'package:flutter/material.dart';
import 'package:passenger/view/profile.dart';
import 'package:settings_ui/settings_ui.dart';

class Account extends StatefulWidget {
  const Account({Key? key}) : super(key: key);
  @override
  _AccountState createState() => _AccountState();
}

class _AccountState extends State<Account> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Account"),
      ),
      body: SettingsList(
        sections: [
          SettingsSection(
            title: Text('General'),
            tiles: <SettingsTile>[
              SettingsTile.navigation(
                leading: Icon(Icons.person),
                title: Text('Profile'),
                onPressed: (BuildContext context) {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => Profile()),
                  );
                },
              ),
              SettingsTile.navigation(
                leading: Icon(Icons.password),
                title: Text('Password'),
              ),
              SettingsTile.navigation(
                leading: Icon(Icons.notifications),
                title: Text('Notifications'),
              ),
              SettingsTile.navigation(
                leading: Icon(Icons.contacts),
                title: Text('Contact Info'),
              ),
            ],
          ),
          SettingsSection(
            title: Text('About'),
            tiles: <SettingsTile>[
              SettingsTile.navigation(
                leading: Icon(Icons.info_outline),
                title: Text('About'),
              ),
              SettingsTile.navigation(
                leading: Icon(Icons.article_outlined),
                title: Text('Terms and Conditions'),
              ),
              SettingsTile.navigation(
                leading: Icon(Icons.support),
                title: Text('Support'),
              ),
            ],
          ),
          SettingsSection(
            tiles: <SettingsTile>[
              SettingsTile.navigation(
                leading: Icon(Icons.logout),
                title: Text('Sign Out'),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
