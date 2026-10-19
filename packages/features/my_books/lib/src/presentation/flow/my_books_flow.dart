import 'dart:async';

import 'package:core_di/core_di.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:material_ui/material_ui.dart';
import 'package:my_books/src/domain/di/di_init.dart';
import 'package:my_books/src/presentation/cubits/my_books_cubit/my_books_cubit.dart';
import 'package:my_books/src/presentation/view/pages/my_books_page.dart';

class MyBooksFlow extends StatefulWidget {
  const new({super.key});

  @override
  State<MyBooksFlow> createState() => _MyBooksFlowState();
}

class _MyBooksFlowState extends State<MyBooksFlow> {
  @override
  void initState() {
    super.initState();
    initialize();
  }

  @override
  void dispose() {
    unawaited(deinitialize());
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => getIt<MyBooksCubit>()..watchShelf(),
      child: const MyBooksPage(),
    );
  }
}
