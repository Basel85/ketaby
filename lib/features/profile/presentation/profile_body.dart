import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ketaby/core/utils/snack_bar_viewer.dart';
import 'package:ketaby/core/widgets/custom_button.dart';
import 'package:ketaby/core/widgets/custom_text_form_field.dart';
import 'package:ketaby/features/home/presentation/views/home_screen.dart';
import 'package:ketaby/features/profile/cubits/read_only_text_form_fields/read_only_text_form_fields_cubit.dart';
import 'package:ketaby/features/profile/cubits/read_only_text_form_fields/read_only_text_form_fields_states.dart';
import 'package:ketaby/features/profile/cubits/update_profile/update_profile_cubit.dart';
import 'package:ketaby/features/profile/cubits/update_profile/update_profile_states.dart';

class ProfileBody extends StatefulWidget {
  final Map<String, dynamic> user;
  const ProfileBody({super.key, required this.user});

  @override
  State<ProfileBody> createState() => _ProfileBodyState();
}

class _ProfileBodyState extends State<ProfileBody>
    with SnackBarViewer, AutomaticKeepAliveClientMixin {
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _phoneController = TextEditingController();
  final TextEditingController _cityController = TextEditingController();
  final TextEditingController _addressController = TextEditingController();
  final String _image = "";
  BlocBuilder<UpdateProfileCubit,
                                      UpdateProfileStates>(
                                  buildWhen: (previous, current) =>
                                      current is UpdateProfileErrorState,
                                  builder: (_, state) => Text(
                                        _getErrorMessage(
                                            state: state, key: 'address'),
                                        style:
                                            const TextStyle(color: Colors.red),
                                      )),

  @override
  bool get wantKeepAlive => true;

  @override
  void initState() {
    _nameController.text = widget.user['name'].toString();
    _emailController.text = widget.user['email'].toString();
    _phoneController.text = widget.user['phone'].toString();
    _cityController.text = widget.user['city'].toString();
    _addressController.text = widget.user['address'].toString();
    super.initState();
  }

  @override
  void dispose() {
    _nameController.dispose();
    _phoneController.dispose();
    _cityController.dispose();
    _addressController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    MediaQueryData mediaQueryData = MediaQuery.of(context);
    return BlocListener<UpdateProfileCubit, UpdateProfileStates>(
      listener: (context, state) {
        if (state is UpdateProfileSuccessState) {
          Navigator.pop(context);
          showSnackBar(
              context: context,
              message: "Profile Updated Successfully",
              backgroundColor: Colors.green);
          Navigator.pushReplacement(context, MaterialPageRoute(builder: (_) {
            return HomeScreen(
              user: state.user,
            );
          }));
        } else if (state is UpdateProfileErrorState) {
          Navigator.pop(context);
          showSnackBar(
              context: context,
              message: state.errorMessage,
              backgroundColor: Colors.red);
        } else {
          showDialog(
              barrierDismissible: false,
              context: context,
              builder: (_) => const Center(
                    child: CircularProgressIndicator(),
                  ));
        }
      },
      child: Stack(children: [
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
                      backgroundImage: NetworkImage(widget.user["image"]),
                    ),
                  ),
                  BlocBuilder<UpdateProfileCubit, UpdateProfileStates>(
                      buildWhen: (previous, current) =>
                          current is UpdateProfileErrorState,
                      builder: (_, state) => Text(
                            _getErrorMessage(state: state, key: 'image'),
                            style: const TextStyle(color: Colors.red),
                          )),
                  const SizedBox(
                    height: 10,
                  ),
                  Expanded(
                    child: ListView(
                      padding: const EdgeInsets.symmetric(horizontal: 20),
                      children: [
                        Container(
                          padding: const EdgeInsets.all(10),
                          decoration: BoxDecoration(
                              color: Colors.grey[200],
                              borderRadius: BorderRadius.circular(10)),
                          child: Column(
                            children: [
                              BlocBuilder<ReadOnlyTextFormFieldsCubit,
                                  ReadOnlyTextFormFieldsStates>(
                                builder: (_, state) => CustomTextFormField(
                                  readOnly: state
                                          is ReadOnlyTextFormFieldsChangedState
                                      ? false
                                      : true,
                                  icon: Icons.person,
                                  labelText: "name",
                                  hintText: "Enter your name",
                                  controller: _nameController,
                                ),
                              ),
                              BlocBuilder<UpdateProfileCubit,
                                      UpdateProfileStates>(
                                  buildWhen: (previous, current) =>
                                      current is UpdateProfileErrorState,
                                  builder: (_, state) => Text(
                                        _getErrorMessage(
                                            state: state, key: 'name'),
                                        style:
                                            const TextStyle(color: Colors.red),
                                      )),
                              const SizedBox(
                                height: 10,
                              ),
                              CustomTextFormField(
                                readOnly: true,
                                icon: Icons.email,
                                labelText: "email",
                                hintText: "Enter your email",
                                controller: _emailController,
                              ),
                              const SizedBox(
                                height: 10,
                              ),
                              BlocBuilder<ReadOnlyTextFormFieldsCubit,
                                  ReadOnlyTextFormFieldsStates>(
                                builder: (_, state) => CustomTextFormField(
                                  readOnly: state
                                          is ReadOnlyTextFormFieldsChangedState
                                      ? false
                                      : true,
                                  icon: Icons.phone,
                                  labelText: "phone",
                                  hintText: "Enter your phone",
                                  controller: _phoneController,
                                ),
                              ),
                              BlocBuilder<UpdateProfileCubit,
                                      UpdateProfileStates>(
                                  buildWhen: (previous, current) =>
                                      current is UpdateProfileErrorState,
                                  builder: (_, state) => Text(
                                        _getErrorMessage(
                                            state: state, key: 'phone'),
                                        style:
                                            const TextStyle(color: Colors.red),
                                      )),
                              const SizedBox(
                                height: 10,
                              ),
                              BlocBuilder<ReadOnlyTextFormFieldsCubit,
                                  ReadOnlyTextFormFieldsStates>(
                                builder: (_, state) => CustomTextFormField(
                                  readOnly: state
                                          is ReadOnlyTextFormFieldsChangedState
                                      ? false
                                      : true,
                                  icon: Icons.location_city,
                                  labelText: "city",
                                  hintText: "Enter your city",
                                  controller: _cityController,
                                ),
                              ),
                              BlocBuilder<UpdateProfileCubit,
                                      UpdateProfileStates>(
                                  buildWhen: (previous, current) =>
                                      current is UpdateProfileErrorState,
                                  builder: (_, state) => Text(
                                        _getErrorMessage(
                                            state: state, key: 'city'),
                                        style:
                                            const TextStyle(color: Colors.red),
                                      )),
                              const SizedBox(
                                height: 10,
                              ),
                              BlocBuilder<ReadOnlyTextFormFieldsCubit,
                                  ReadOnlyTextFormFieldsStates>(
                                builder: (_, state) => CustomTextFormField(
                                  readOnly: state
                                          is ReadOnlyTextFormFieldsChangedState
                                      ? false
                                      : true,
                                  icon: Icons.location_on_outlined,
                                  labelText: "address",
                                  hintText: "Enter your address",
                                  controller: _addressController,
                                ),
                              ),
                              BlocBuilder<UpdateProfileCubit,
                                      UpdateProfileStates>(
                                  buildWhen: (previous, current) =>
                                      current is UpdateProfileErrorState,
                                  builder: (_, state) => Text(
                                        _getErrorMessage(
                                            state: state, key: 'address'),
                                        style:
                                            const TextStyle(color: Colors.red),
                                      )),
                            ],
                          ),
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        BlocBuilder<ReadOnlyTextFormFieldsCubit,
                            ReadOnlyTextFormFieldsStates>(
                          builder: (_, state) => CustomButton(
                              content: Text(
                                state is ReadOnlyTextFormFieldsChangedState
                                    ? "Update"
                                    : "Edit Profile",
                                style: const TextStyle(
                                    fontWeight: FontWeight.bold,
                                    color: Colors.white),
                              ),
                              onTap: () {
                                state is ReadOnlyTextFormFieldsChangedState
                                    ? UpdateProfileCubit.get(context)
                                        .updateProfile(body: {
                                        "name": _nameController.text,
                                        "address": _addressController.text,
                                        "city": _cityController.text,
                                        "phone": _phoneController.text,
                                      })
                                    : ReadOnlyTextFormFieldsCubit.get(context)
                                        .changeReadOnlyValue();
                              }),
                        )
                      ],
                    ),
                  ),
                ],
              )),
        ),
        Positioned(
          top: mediaQueryData.padding.top,
          right: 5,
          child: IconButton(
              onPressed: () {},
              icon: const Icon(Icons.logout, color: Colors.white)),
        )
      ]),
    );
  }
}
