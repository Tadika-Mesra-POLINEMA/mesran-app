import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mesran_app/src/config/injectors/injector.dart';
import 'package:mesran_app/src/features/home/presentation/bloc/home_page_bloc.dart';
import 'package:mesran_app/src/features/home/presentation/widgets/home_page_content.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => getIt<HomePageBloc>(),
      child: const HomePageContent(),
    );
  }
}
