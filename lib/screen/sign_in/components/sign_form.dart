// import 'package:abdelrahman/components/primary_button.dart';
// import 'package:abdelrahman/routes.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_riverpod/flutter_riverpod.dart';
//
// import '../../../size_config.dart';
// import '../../../theme.dart';
//
// class SignForm extends StatefulWidget {
//   @override
//   _SignFormState createState() => _SignFormState();
// }
//
// class _SignFormState extends State<SignForm> {
//   final _formKey = GlobalKey<FormState>();
//   String? email;
//   String? password;
//   bool remember = false;
//   final List<String> errors = [];
//   bool _isButtonDisabled = false;
//
//   void addError({String? error}) {
//     if (!errors.contains(error))
//       setState(() {
//         errors.add(error!);
//       });
//   }
//
//   void removeError({String? error}) {
//     if (errors.contains(error))
//       setState(() {
//         errors.remove(error);
//       });
//   }
//
//   @override
//   Widget build(BuildContext context) {
//    // var pro = ChangeNotifierProvider((ref) => AuthProvider());
//
//     return Form(
//       key: _formKey,
//       child: Column(
//         children: [
//           buildEmailFormField(),
//           SizedBox(height: getScreenHeight(30)),
//           buildPasswordFormField(),
//           SizedBox(height: getScreenHeight(30)),
//           Row(
//             children: [
//               Checkbox(
//                 value: remember,
//                 activeColor: kPrimaryColor,
//                 onChanged: (value) {
//                   setState(() {
//                     remember = value!;
//                   });
//                 },
//               ),
//               Text("Remember me"),
//               Spacer(),
//               GestureDetector(
//                 //        onTap: () => Navigator.pushNamed(context, ForgotPasswordScreen.routeName),
//                 child: Text(
//                   "Forget the password",
//                   style: TextStyle(decoration: TextDecoration.underline),
//                 ),
//               )
//             ],
//           ),
//          // FormError(errors: errors),
//           SizedBox(height: getScreenHeight(20)),
//           SizedBox(height: 20.0),
//           _isButtonDisabled == true
//               ?     CircularProgressIndicator(color:kPrimaryColor)
//               : PrimaryButton(
//             title:    "Sign in",onPressed:  _isButtonDisabled ? null : _submit,
//
//
//           ),
//           SizedBox(height: 20.0),
//           SizedBox(height: getScreenHeight(20)),
//
//         ],
//       ),
//     );
//   }
//
//   TextFormField buildPasswordFormField() {
//     return TextFormField(
//       obscureText: true,
//       onSaved: (newValue) => password = newValue,
//       onChanged: (value) {
//         if (value.isNotEmpty) {
//           removeError(error: kPassNullError);
//         }
//         return null;
//       },
//       validator: (value) {
//         if (value!.isEmpty) {
//           addError(error: 'Enter yor password');
//           return "";
//         }
//         return null;
//       },
//       decoration: InputDecoration(
//         labelText: "كلمة السر",
//         hintText: "أدخل كلمة السر",
//         // If  you are using latest version of flutter then lable text and hint text shown like this
//         // if you r using flutter less then 1.20.* then maybe this is not working properly
//         floatingLabelBehavior: FloatingLabelBehavior.always,
//
//       ),
//     );
//   }
//
//   TextFormField buildEmailFormField() {
//     return TextFormField(
//       keyboardType: TextInputType.emailAddress,
//       onSaved: (newValue) => email = newValue,
//       onChanged: (value) {
//         if (value.isNotEmpty) {
//           removeError(error: kEmailNullError);
//         } else if (emailValidatorRegExp.hasMatch(value)) {
//           removeError(error: kInvalidEmailError);
//         }
//         return null;
//       },
//       validator: (value) {
//         if (value.isEmpty) {
//           addError(error: kEmailNullError);
//           return "";
//         } else if (!emailValidatorRegExp.hasMatch(value)) {
//           addError(error: kInvalidEmailError);
//           return "";
//         }
//         return null;
//       },
//       decoration: InputDecoration(
//         labelText: "الايميل",
//         hintText: "أدخل الايميل الخاص بك",
//         // If  you are using latest version of flutter then lable text and hint text shown like this
//         // if you r using flutter less then 1.20.* then maybe this is not working properly
//         floatingLabelBehavior: FloatingLabelBehavior.always,
//         suffixIcon: CustomSurffixIcon(svgIcon: "assets/icons/Mail.svg"),
//       ),
//     );
//   }
// }
