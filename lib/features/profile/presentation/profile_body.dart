import 'package:flutter/material.dart';
import 'package:ketaby/core/widgets/custom_button.dart';
import 'package:ketaby/core/widgets/custom_text_form_field.dart';

class ProfileBody extends StatelessWidget {
  final Map<String, dynamic> user;
  const ProfileBody({super.key, required this.user});

  @override
  Widget build(BuildContext context) {
    MediaQueryData mediaQueryData = MediaQuery.of(context);
    return Stack(children: [
      const SizedBox(
        height: double.infinity,
        width: double.infinity,
      ),
      Container(
        decoration: BoxDecoration(
            color: Theme.of(context).primaryColor,
            borderRadius: const BorderRadius.only(
                bottomLeft: Radius.elliptical(200, 75),
                bottomRight: Radius.elliptical(200, 75))),
        height: 140,
      ),
      Align(
        alignment: Alignment.topCenter,
        child: Container(
            margin: EdgeInsets.only(top: mediaQueryData.padding.top),
            child: SingleChildScrollView(
              child: Column(
                children: [
                  const Text(
                    "Profile",
                    style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                        fontSize: 35),
                  ),
                  const SizedBox(
                    height: 15,
                  ),
                  Container(
                    decoration: BoxDecoration(
                        border: Border.all(color: Colors.white, width: 4),
                        shape: BoxShape.circle),
                    child: CircleAvatar(
                      radius: 75,
                      backgroundImage: NetworkImage(user["image"]),
                    ),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    child: Column(
                      children: [
                        Container(
                          padding: const EdgeInsets.all(10),
                          decoration: BoxDecoration(
                              color: Colors.grey[200],
                              borderRadius: BorderRadius.circular(10)),
                          child: Column(
                            children: [
                              CustomTextFormField(
                                readOnly: true,
                                icon: Icons.person,
                                labelText: "name",
                                hintText: user['name'],
                              ),
                              const SizedBox(
                                height: 10,
                              ),
                              CustomTextFormField(
                                readOnly: true,
                                icon: Icons.email,
                                labelText: "email",
                                hintText: user['email'],
                              ),
                              const SizedBox(
                                height: 10,
                              ),
                              CustomTextFormField(
                                readOnly: true,
                                icon: Icons.phone,
                                labelText: "phone",
                                hintText: user['phone'] ?? "No Phone",
                              ),
                              const SizedBox(
                                height: 10,
                              ),
                              CustomTextFormField(
                                readOnly: true,
                                icon: Icons.location_city,
                                labelText: "city",
                                hintText: user['city'] ?? "No City",
                              ),
                              const SizedBox(
                                height: 10,
                              ),
                              CustomTextFormField(
                                readOnly: true,
                                icon: Icons.location_on_outlined,
                                labelText: "address",
                                hintText: user['address'] ?? "No Address",
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        CustomButton(
                            content: const Text(
                              "Edit Profile",
                              style: TextStyle(fontWeight: FontWeight.bold),
                            ),
                            onTap: () {})
                      ],
                    ),
                  ),
                ],
              ),
            )),
      ),
      Positioned(
        top: mediaQueryData.padding.top,
        right: 5,
        child: IconButton(
            onPressed: () {},
            icon: const Icon(Icons.logout, color: Colors.white)),
      )
    ]);
  }
}
