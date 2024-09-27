import 'package:flutter/material.dart';
import 'package:juju/screens/community/authenticate/screens/login.dart';
import 'package:juju/screens/community/authenticate/theme.dart';
import 'package:juju/screens/community/authenticate/widgets/checkbox.dart';
import 'package:juju/screens/community/authenticate/widgets/primary_button.dart';
import 'package:juju/screens/community/authenticate/widgets/signup_form.dart';
import 'package:get/get.dart';

class SignUpScreen extends StatelessWidget {
  const SignUpScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios),
          onPressed: () {
            Get.back();
          },
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(
              height: 70,
            ),
            Padding(
              padding: kDefaultPadding,
              child: Text(
                'Create Account',
                style: titleText,
              ),
            ),
            const SizedBox(
              height: 5,
            ),
            Padding(
              padding: kDefaultPadding,
              child: Row(
                children: [
                  Text(
                    'Already a member?',
                    style: subTitle,
                  ),
                  const SizedBox(
                    width: 5,
                  ),
                  GestureDetector(
                    onTap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => const LogInScreen()));
                    },
                    child: Text(
                      'Log In',
                      style: textButton.copyWith(
                        decoration: TextDecoration.underline,
                        decorationThickness: 1,
                      ),
                    ),
                  )
                ],
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            const Padding(
              padding: kDefaultPadding,
              child: SignUpForm(),
            ),
            const SizedBox(
              height: 20,
            ),
            const Padding(
              padding: kDefaultPadding,
              child: CheckBox('Agree to terms and conditions.'),
            ),
            const SizedBox(
              height: 20,
            ),
            const Padding(
              padding: kDefaultPadding,
              child: CheckBox('I have at least 18 years old.'),
            ),
            const SizedBox(
              height: 20,
            ),
            const Padding(
              padding: kDefaultPadding,
              child: PrimaryButton(buttonText: 'Sign Up'),
            ),
            const SizedBox(
              height: 20,
            ),
            Padding(
              padding: kDefaultPadding,
              child: Text(
                'Or log in with:',
                style: subTitle.copyWith(color: kBlackColor),
              ),
            ),
            const SizedBox(
              height: 20,
            ),
          ],
        ),
      ),
    );
  }
}
