import 'package:challenge_guia/app/ui/screens/dashboard/tabs/motels_list/motels_list_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';

import '../../../../../business_logic/cubits/motels/motels_cubit.dart';

class MotelsList extends StatelessWidget {
  const MotelsList({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => MotelsCubit(GetIt.I()),
      child: MotelsListScreen(),
    );
  }
}
