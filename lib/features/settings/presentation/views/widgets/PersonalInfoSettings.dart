import 'package:flutter/material.dart';

import '../../../../../core/functions/Container_decoration.dart';
import '../../../../../core/functions/getLocalUser.dart';
import '../../../../../core/services/get_it_service.dart';
import '../../../../auth/domain/entities/user_entity.dart';

class PersonalInfoSettings extends StatefulWidget {
  const PersonalInfoSettings({super.key});

  @override
  State<PersonalInfoSettings> createState() => _PersonalInfoSettingsState();
}

class _PersonalInfoSettingsState extends State<PersonalInfoSettings> {
  UserEntity? user;
  late TextEditingController nameController;
  late TextEditingController phoneController;
  late TextEditingController emailController;
  late TextEditingController jobController;
  late TextEditingController bioController;

  @override
  void initState() {
    super.initState();
    nameController = TextEditingController();
    phoneController = TextEditingController();
    emailController = TextEditingController();
    jobController = TextEditingController();
    bioController = TextEditingController();
    getuser();
  }

  getuser() async {
    user = getIt<UserService>().user;
    nameController.text = user?.name ?? '';
    phoneController.text = user?.name ?? '';
    emailController.text = user?.email ?? '';
    jobController.text = user?.name ?? '';
    bioController.text = user?.name ?? '';
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
                  controller: nameController,
                ),
              ),
              SizedBox(width: 16),
              Expanded(
                child: TextFormField(
                  decoration: InputDecoration(labelText: "Phone Number"),
                  controller: phoneController,
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
                  controller: emailController,
                ),
              ),
              SizedBox(width: 16),
              Expanded(
                child: TextFormField(
                  decoration: InputDecoration(labelText: "Job Title"),
                  controller: jobController,
                ),
              ),
            ],
          ),
          SizedBox(height: 16),
          TextFormField(
            maxLines: 3,
            decoration: InputDecoration(labelText: "Bio"),
            controller: bioController,
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
