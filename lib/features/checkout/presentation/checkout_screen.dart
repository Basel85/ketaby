import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ketaby/core/cubits/bottom_navigation_bar/bottom_navigation_bar_cubit.dart';
import 'package:ketaby/core/utils/snack_bar_viewer.dart';
import 'package:ketaby/core/widgets/custom_button.dart';
import 'package:ketaby/core/widgets/custom_text_form_field.dart';
import 'package:ketaby/core/widgets/get_error_message.dart';
import 'package:ketaby/features/checkout/cubits/get_governorates/get_governorates_cubit.dart';
import 'package:ketaby/features/checkout/cubits/get_governorates/get_governorates_states.dart';
import 'package:ketaby/features/checkout/cubits/place_order/place_order_cubit.dart';
import 'package:ketaby/features/checkout/cubits/place_order/place_order_states.dart';

class CheckoutScreen extends StatefulWidget {
  final Map<String, dynamic> cart;
  const CheckoutScreen({super.key, this.cart = const {}});
  static const String id = "checkout_screen";

  @override
  State<CheckoutScreen> createState() => _CheckoutScreenState();
}

class _CheckoutScreenState extends State<CheckoutScreen> with SnackBarViewer {
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _phoneController = TextEditingController();
  final TextEditingController _addressController = TextEditingController();
  int _cityId = 0;

  String _getErrorMessage(
      {required PlaceOrderStates state, required String key}) {
    return state is PlaceOrderErrorState &&
            state.errors != null &&
            state.errors!.containsKey(key)
        ? state.errors![key][0].toString()
        : "";
  }

  @override
  void initState() {
    GetGovernoratesCubit.get(context).getGovernorates();

    super.initState();
  }

  @override
  void dispose() {
    _nameController.dispose();
    _emailController.dispose();
    _phoneController.dispose();
    _addressController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: BlocListener<PlaceOrderCubit, PlaceOrderStates>(
      listener: (context, state) {
        if (state is PlaceOrderSuccessState) {
          Navigator.pop(context);
          showSnackBar(
              context: context,
              message: state.successMessage,
              backgroundColor: Colors.green);
          Navigator.pop(context);
          BottomNavigationBarCubit.get(context).update(index: 0);
        } else if (state is PlaceOrderErrorState) {
          Navigator.pop(context);
          showSnackBar(
              context: context,
              message: state.errorMessage,
              backgroundColor: Colors.red);
        } else {
          showDialog(
              context: context,
              builder: (_) => const Center(
                    child: CircularProgressIndicator.adaptive(),
                  ));
        }
      },
      child: Column(
        children: [
          Expanded(
            flex: 2,
            child: ListView(
              padding: const EdgeInsets.only(
                  top: kToolbarHeight + 10, left: 20, right: 20, bottom: 20),
              children: [
                CustomTextFormField(
                  icon: Icons.person,
                  labelText: "name",
                  hintText: "Enter your name",
                  controller: _nameController,
                ),
                BlocBuilder<PlaceOrderCubit, PlaceOrderStates>(
                    buildWhen: (previous, current) =>
                        current is PlaceOrderErrorState ||
                        current is PlaceOrderLoadingState,
                    builder: (_, state) => Text(
                          _getErrorMessage(state: state, key: 'name'),
                          style: const TextStyle(color: Colors.red),
                        )),
                CustomTextFormField(
                  icon: Icons.email,
                  labelText: "email",
                  hintText: "Enter your email",
                  controller: _emailController,
                ),
                BlocBuilder<PlaceOrderCubit, PlaceOrderStates>(
                    buildWhen: (previous, current) =>
                        current is PlaceOrderErrorState ||
                        current is PlaceOrderLoadingState,
                    builder: (_, state) => Text(
                          _getErrorMessage(state: state, key: 'email'),
                          style: const TextStyle(color: Colors.red),
                        )),
                CustomTextFormField(
                  icon: Icons.phone,
                  labelText: "phone",
                  hintText: "Enter your phone",
                  controller: _phoneController,
                ),
                BlocBuilder<PlaceOrderCubit, PlaceOrderStates>(
                    buildWhen: (previous, current) =>
                        current is PlaceOrderErrorState ||
                        current is PlaceOrderLoadingState,
                    builder: (_, state) => Text(
                          _getErrorMessage(state: state, key: 'phone'),
                          style: const TextStyle(color: Colors.red),
                        )),
                CustomTextFormField(
                  icon: Icons.location_on_outlined,
                  labelText: "address",
                  hintText: "Enter your address",
                  controller: _addressController,
                ),
                BlocBuilder<PlaceOrderCubit, PlaceOrderStates>(
                    buildWhen: (previous, current) =>
                        current is PlaceOrderErrorState ||
                        current is PlaceOrderLoadingState,
                    builder: (_, state) => Text(
                          _getErrorMessage(state: state, key: 'address'),
                          style: const TextStyle(color: Colors.red),
                        )),
                BlocBuilder<GetGovernoratesCubit, GetGovernoratesStates>(
                    builder: (_, state) {
                  if (state is GetGovernoratesSuccessState) {
                    return DropdownButtonFormField(
                      items: state.governorates
                          .map((governorate) => DropdownMenuItem(
                              value: governorate.id,
                              child: Text(governorate.governorateNameEn)))
                          .toList(),
                      onChanged: (value) {
                        _cityId = value!;
                      },
                      decoration: InputDecoration(
                        contentPadding: const EdgeInsets.symmetric(
                            horizontal: 10, vertical: 5),
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                            borderSide: const BorderSide(color: Colors.black)),
                      ),
                      hint: const Text(
                        "Select City",
                        style: TextStyle(
                            fontWeight: FontWeight.bold, color: Colors.black),
                      ),
                    );
                  } else if (state is GetGovernoratesErrorState) {
                    return GetErrorMessage(
                        errorMessage: state.errorMessage,
                        onPressed: () {
                          GetGovernoratesCubit.get(context).getGovernorates();
                        });
                  } else {
                    return const Center(
                      child: CircularProgressIndicator.adaptive(),
                    );
                  }
                }),
                BlocBuilder<PlaceOrderCubit, PlaceOrderStates>(
                    buildWhen: (previous, current) =>
                        current is PlaceOrderErrorState ||
                        current is PlaceOrderLoadingState,
                    builder: (_, state) => Text(
                          _getErrorMessage(state: state, key: 'governorate_id'),
                          style: const TextStyle(color: Colors.red),
                        )),
              ],
            ),
          ),
          const Divider(
            thickness: 1,
          ),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.only(left: 20, right: 20, bottom: 20),
              child: Column(
                children: [
                  Expanded(
                    child: ListView.separated(
                      separatorBuilder: (_, __) => const SizedBox(height: 10),
                      itemBuilder: (_, index) => Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              Expanded(
                                  child: Text(
                                widget.cart['cart_items'][index]
                                        ['item_product_name']
                                    .toString(),
                                style: const TextStyle(
                                    fontWeight: FontWeight.bold, fontSize: 18),
                              )),
                              Text(
                                widget.cart['cart_items'][index]['item_total']
                                    .toString(),
                                style: const TextStyle(
                                    fontWeight: FontWeight.bold),
                              ),
                            ],
                          ),
                          Text(
                            "quantity: ${widget.cart['cart_items'][index]['item_quantity']}",
                            style: const TextStyle(color: Colors.grey),
                          ),
                        ],
                      ),
                      itemCount: (widget.cart['cart_items']
                              as List<Map<String, dynamic>>)
                          .length,
                    ),
                  ),
                  CustomButton(
                      content: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "total price: ${widget.cart['total']}",
                        style: const TextStyle(
                            color: Colors.white, fontWeight: FontWeight.bold),
                      ),
                      BlocBuilder<GetGovernoratesCubit, GetGovernoratesStates>(
                        builder: (_, state) => ElevatedButton(
                            onPressed: state is GetGovernoratesSuccessState
                                ? () {
                                    PlaceOrderCubit.get(context)
                                        .placeOrder(body: {
                                      "name": _nameController.text,
                                      "governorate_id": _cityId.toString(),
                                      "phone": _phoneController.text,
                                      "address": _addressController.text,
                                      "email": _emailController.text,
                                    });
                                  }
                                : null,
                            child: Text(
                              "order Now!",
                              style: TextStyle(
                                  color: Theme.of(context).primaryColor),
                            )),
                      ),
                    ],
                  ))
                ],
              ),
            ),
          )
        ],
      ),
    ));
  }
}
