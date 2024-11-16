import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:yourhand/common_widgets/textField.dart';

class AddServiceScreen extends StatefulWidget {
  const AddServiceScreen({super.key});

  @override
  State<AddServiceScreen> createState() => _AddServiceScreenState();
}

class _AddServiceScreenState extends State<AddServiceScreen> {
   @override
  void initState() {
    super.initState();
    _showEditProfileDialog(context); // Call your method here
  }
  @override
  Widget build(BuildContext context) {
    return  InkWell(child: Container());
  }

  
  void _showEditProfileDialog(BuildContext context) async {
    await showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return AlertDialog(
          // title: Text(''),
          content: Form(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                CustomTextFieldWithoutIcon( 
                        onIconPressed: () {},
                        title: "الاسم", 
                        keyboardType: TextInputType.name,
                        obscureText: false,
                      ),
                      SizedBox(height: 10),
                      CustomTextFieldWithoutIcon( 
                        onIconPressed: () {},
                        title: " البريد الإلكتروني",
                        controller: TextEditingController(),
                        keyboardType: TextInputType.name,
                        obscureText: false,
                      ), 
                      SizedBox(height: 10),
                      CustomTextFieldWithoutIcon( 
                        onIconPressed: () {},
                        title: "كلمة السر ",
                        controller: TextEditingController(),
                        keyboardType: TextInputType.name,
                        obscureText: false,
                      ),
                      
              ],
            ),
          ),
          actions: <Widget>[
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                TextButton(
              child: Text('ألغاء'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            TextButton(
              child: Text('حفظ'),
              onPressed: () {
                 Navigator.of(context).pop();
              },
            ),
              ],
            )
          ],
        );
      },
    );
  }

}