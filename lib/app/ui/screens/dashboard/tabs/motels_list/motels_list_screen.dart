import 'package:challenge_guia/app/business_logic/cubits/motels/motels_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class MotelsListScreen extends StatefulWidget {
  const MotelsListScreen({super.key});

  @override
  State<MotelsListScreen> createState() => _MotelsListScreenState();
}

class _MotelsListScreenState extends State<MotelsListScreen> {
  @override
  void initState() {
    super.initState();
    BlocProvider.of<MotelsCubit>(context).getAllPaginated();
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [
          IconButton(
            onPressed: () {
              BlocProvider.of<MotelsCubit>(context).getAllPaginated();
            },
            icon: Icon(Icons.star),
          ),
        ],
      ),
    );
  }
}
