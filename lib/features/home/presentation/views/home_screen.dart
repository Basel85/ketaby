import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ketaby/core/widgets/get_error_message.dart';
import 'package:ketaby/features/home/presentation/cubits/get_sliders/get_sliders_cubit.dart';
import 'package:ketaby/features/home/presentation/cubits/get_sliders/get_sliders_states.dart';

class HomeScreen extends StatefulWidget {
  final Map<String, dynamic>? user;
  const HomeScreen({super.key, this.user});
  static const String id = "HomeScreen";

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  late Map<String, dynamic> user;
  @override
  void didChangeDependencies() {
    try {
      user = ModalRoute.of(context)!.settings.arguments as Map<String, dynamic>;
    } catch (_) {
      user = widget.user!;
    } finally {
      GetSlidersCubit.get(context).getSliders();
    }

    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 100,
        elevation: 0,
        title: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          Text(
            "Hi, ${user['name']}",
            style: const TextStyle(fontWeight: FontWeight.bold),
          ),
          const Text(
            "What are you reading today?",
            style: TextStyle(color: Colors.grey, fontSize: 15),
          )
        ]),
        actions: [
          CircleAvatar(
            radius: 25,
            backgroundImage: NetworkImage(user['image']),
          ),
          const SizedBox(
            width: 18,
          ),
        ],
      ),
      drawer: const Drawer(),
      body: ListView(
        children: [
          const SizedBox(
            height: 10,
          ),
          BlocBuilder<GetSlidersCubit, GetSlidersStates>(builder: (_, state) {
            if (state is GetSlidersSuccessState) {
              return PageView.builder(
                itemBuilder: (_, index) => Image.network(
                  state.sliders[index]['image']!,
                  fit: BoxFit.cover,
                ),
                itemCount: state.sliders.length,
              );
            } else if (state is GetSlidersErrorState) {
              return GetErrorMessage(
                errorMessage: state.errorMessage,
                onPressed: () {
                  GetSlidersCubit.get(context).getSliders();
                },
              );
            } else {
              return const Center(
                child: CircularProgressIndicator.adaptive(),
              );
            }
          })
        ],
      ),
    );
  }
}
