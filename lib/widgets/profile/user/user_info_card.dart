import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:flutter/material.dart';
import 'package:lms/helpers/ThemeHelper.dart';
import 'package:lms/widgets/elements/user_information_input.dart';
import 'package:provider/provider.dart';

class UserInfoCard extends StatefulWidget {
  const UserInfoCard({super.key});

  @override
  State<UserInfoCard> createState() => _UserInfoCardState();
}

class _UserInfoCardState extends State<UserInfoCard> {
  void showInputDialog() {
    AwesomeDialog(
      context: context,
      dialogBackgroundColor: Theme.of(context).scaffoldBackgroundColor,
      dialogType: DialogType.info,
      animType: AnimType.scale,
      title: 'Input Dialog',
      desc: 'Please enter the required information:',
      body: Column(
        children: [
          const SizedBox(height: 15),
          Row(
            children: [
              Expanded(child: UserInformationInput(value: 'سینا', label: 'نام', onChanged: (value) {})),
              Expanded(child: UserInformationInput(value: 'حاجی‌پور', label: 'نام خانوادگی', onChanged: (value) {})),
            ],
          ),
          const SizedBox(height: 15),
          Row(
            children: [
              Expanded(child: UserInformationInput(value: '0640821324', label: 'کدملی', onChanged: (value) {})),
              Expanded(child: UserInformationInput(value: '09155613393', label: 'شماره موبایل', onChanged: (value) {})),
            ],
          ),
          const SizedBox(height: 15),
        ],
      ),
      btnOk: ElevatedButton(
        onPressed: () {},
        style: ButtonStyle(
          backgroundColor: MaterialStateProperty.all<Color>(Colors.blue),
        ),
        child: const Text('ذخیره'),
      ),
      btnCancel: ElevatedButton(
        onPressed: () {
          Navigator.of(context).pop();
        },
        style: ButtonStyle(
          backgroundColor: MaterialStateProperty.all<Color>(Colors.red),
        ),
        child: const Text('لغو'),
      ),
    ).show();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final themeMode = Provider.of<MyThemeModel>(context).themeMode;
    return SizedBox(
      height: 200,
      child: Card(
        elevation: 2,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20),
        ),
        child: Stack(
          children: [
            Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  ClipOval(
                    child: Container(
                      width: 90,
                      height: 90,
                      color: Colors.grey,
                      child: Image.asset('assets/images/avatar.png', fit: BoxFit.cover),
                    ),
                  ),
                  const SizedBox(height: 15),
                  Text('سیناحاجی‌پور', style: theme.textTheme.titleLarge),
                  const SizedBox(height: 5),
                  const Text('فراگیر', style: TextStyle(fontSize: 14, color: Colors.grey)),
                ],
              ),
            ),
            Positioned(
              top: 20,
              right: 20,
              child: InkWell(
                onTap: () => showInputDialog(),
                child: Image.asset(
                  'assets/images/icons/edit.png',
                  width: 20,
                  height: 20,
                  color: themeMode == ThemeMode.light ? Colors.blue : Colors.white,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}