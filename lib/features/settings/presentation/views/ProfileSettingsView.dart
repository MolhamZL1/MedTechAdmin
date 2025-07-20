import 'package:flutter/material.dart';
import 'package:med_tech_admin/features/auth/domain/entities/user_entity.dart';

import '../../../../core/functions/Container_decoration.dart';
import '../../../../core/functions/getLocalUser.dart';

class ProfileSettingsView extends StatelessWidget {
  const ProfileSettingsView({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        ProfilePictureSettings(),
        SizedBox(height: 32),
        PersonalInfoSettings(),
      ],
    );
  }
}

class PersonalInfoSettings extends StatefulWidget {
  const PersonalInfoSettings({super.key});

  @override
  State<PersonalInfoSettings> createState() => _PersonalInfoSettingsState();
}

class _PersonalInfoSettingsState extends State<PersonalInfoSettings> {
  UserEntity? user;

  @override
  void initState() {
    super.initState();
    getuser();
  }

  getuser() async {
    user = await getLocalUser();
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(32),
      decoration: containerDecoration(context),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Personal Information",
            style: Theme.of(context).textTheme.headlineSmall,
          ),
          SizedBox(height: 24),
          Row(
            children: [
              Expanded(
                child: TextFormField(
                  decoration: InputDecoration(labelText: "Name"),
                  initialValue: user?.name,
                ),
              ),
              SizedBox(width: 16),
              Expanded(
                child: TextFormField(
                  decoration: InputDecoration(labelText: "Phone Number"),
                  initialValue: user?.name,
                ),
              ),
            ],
          ),
          SizedBox(height: 16),
          Row(
            children: [
              Expanded(
                child: TextFormField(
                  decoration: InputDecoration(labelText: "Email"),
                  initialValue: user?.email,
                ),
              ),
              SizedBox(width: 16),
              Expanded(
                child: TextFormField(
                  decoration: InputDecoration(labelText: "Job Title"),
                  initialValue: user?.name,
                ),
              ),
            ],
          ),
          SizedBox(height: 16),
          TextFormField(
            maxLines: 3,
            decoration: InputDecoration(labelText: "Bio"),
            initialValue: user?.name,
          ),
          SizedBox(height: 16),
          Align(
            alignment: Alignment.centerRight,
            child: ElevatedButton.icon(
              onPressed: () {},
              icon: const Icon(Icons.save_outlined, size: 20),
              label: Text(
                "Save Changes",
                style: Theme.of(
                  context,
                ).textTheme.bodyMedium!.copyWith(color: Colors.white),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class ProfilePictureSettings extends StatelessWidget {
  const ProfilePictureSettings({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(32),
      decoration: containerDecoration(context),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Profile Picture",
            style: Theme.of(context).textTheme.headlineSmall,
          ),
          SizedBox(height: 24),
          Row(
            children: [
              CircleAvatar(
                radius: 50,
                child: Icon(Icons.file_upload_outlined, size: 50),
              ),
              SizedBox(width: 24),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Upload new picture",
                    style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  SizedBox(height: 16),
                  Row(
                    children: [
                      ElevatedButton(
                        onPressed: () {},
                        child: Text("Upload Photo"),
                      ),
                      SizedBox(width: 16),
                      TextButton(onPressed: () {}, child: Text("Remove")),
                    ],
                  ),
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }
}
