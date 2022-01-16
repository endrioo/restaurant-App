import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:restaurant_app_submission1/common/colors.dart';

class UserPage extends StatelessWidget {
  static const routeName = "/user";
  const UserPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 12),
      child: SingleChildScrollView(
        child: Column(
          children: [
            const SizedBox(
              height: 10,
            ),
            const Center(
              child: Text(
                "My Profile",
                style: TextStyle(
                  color: whiteText,
                ),
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            Center(
              child: Column(
                children: [
                  ClipOval(
                    child: Image.asset(
                      'assets/image/avatar_images.jpg',
                      height: 100,
                      width: 100,
                      fit: BoxFit.cover,
                    ),
                  ),
                  const SizedBox(
                    height: 15,
                  ),
                  const Text(
                    "Saipudin",
                    style: TextStyle(
                      color: whiteText,
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(
              height: 25,
            ),
            UserDetail(
              icon: SvgPicture.asset(
                "assets/svg/bxs-phone.svg",
                color: specialText,
              ),
              title: "Phone Number",
              value: "01234567802",
            ),
            UserDetail(
              icon: SvgPicture.asset(
                "assets/svg/bxl-gmail.svg",
                color: specialText,
              ),
              title: "Email",
              value: "Gmail@gmail.com",
            )
          ],
        ),
      ),
    );
  }
}

class UserDetail extends StatelessWidget {
  final Widget icon;
  final String title;
  final String value;

  const UserDetail({
    Key? key,
    required this.icon,
    required this.title,
    required this.value,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 15),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            children: [
              Container(
                width: 50,
                height: 50,
                child: Padding(
                  padding: const EdgeInsets.all(13),
                  child: icon,
                ),
                decoration: const BoxDecoration(
                  borderRadius: BorderRadius.all(
                    Radius.circular(10),
                  ),
                  color: primaryColor,
                ),
              ),
              const SizedBox(
                width: 20,
              ),
              Column(
                children: [
                  SizedBox(
                    width: 150,
                    child: Text(
                      title,
                      textAlign: TextAlign.start,
                      style: const TextStyle(
                        color: secondaryColor,
                        fontSize: 12,
                      ),
                    ),
                  ),
                  SizedBox(
                    width: 150,
                    child: Text(
                      value,
                      style: const TextStyle(
                        color: whiteText,
                        fontSize: 15,
                      ),
                      textAlign: TextAlign.left,
                    ),
                  ),
                ],
              )
            ],
          ),
          IconButton(
            icon: const Icon(
              Icons.edit,
              color: specialText,
            ),
            onPressed: () {},
          )
        ],
      ),
    );
  }
}
