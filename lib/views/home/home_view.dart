import 'package:flutter/material.dart';

import 'package:animate_do/animate_do.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:virtual_assistant/utils/constants/app_enums.dart';
import 'package:virtual_assistant/views/home/bloc/home_bloc.dart';
import 'package:virtual_assistant/views/home/bloc/home_event.dart';
import 'package:virtual_assistant/views/home/bloc/home_state.dart';
import 'package:virtual_assistant/utils/helpers/helper_functions.dart';
import 'package:virtual_assistant/views/components/custom_app_bar.dart';
import 'package:virtual_assistant/utils/constants/theme/app_sizes.dart';
import 'package:virtual_assistant/views/home/components/app_drawer.dart';
import 'package:virtual_assistant/utils/constants/theme/app_text_strings.dart';
import 'package:virtual_assistant/views/home/components/initial_home.dart';
import 'package:virtual_assistant/views/home/components/response_bubble.dart';
import 'package:virtual_assistant/views/home/components/assistant_avatar.dart';
import 'package:virtual_assistant/views/home/components/bottom_navigation_widget.dart';

class HomeView extends StatelessWidget {
  const HomeView({super.key});

  @override
  Widget build(BuildContext context) {
    final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();

    context.read<HomeBloc>().add(InitialHomeEvent(context: context));

    return Scaffold(
      key: scaffoldKey,
      appBar: CustomAppBar(
        leading: IconButton(
          tooltip: 'Open drawer',
          onPressed: () => scaffoldKey.currentState!.openDrawer(),
          icon: Icon(
            Icons.menu_outlined,
            color: Theme.of(context).colorScheme.primary,
          ),
        ),
        title: BounceIn(child: const Text(AppTextStrings.homeViewTitle)),
      ),
      drawer: AppDrawer(),
      resizeToAvoidBottomInset: true,
      drawerEnableOpenDragGesture: false,
      backgroundColor: Theme.of(context).colorScheme.surface,
      bottomNavigationBar: BottomNavigationWidget(),
      body: BlocListener<HomeBloc, HomeState>(
        bloc: context.read<HomeBloc>(),
        listener: (context, state) {
          if (state is ErrorHomeState) {
            HelperFunctions.showSnackBar(
              context: context,
              type: SnackBarType.error,
              message: state.error,
            );
          }
        },
        child: BlocBuilder<HomeBloc, HomeState>(
          builder: (context, state) {
            if (state is InitialHomeState) {
              return const InitialHome();
            }
            if (state is LoadingHomeState) {
              return HelperFunctions.showLoadingScreen(context);
            } else if (state is LoadedHomeState) {
              return SingleChildScrollView(
                padding: const EdgeInsets.all(AppSizes.kDefaultPadding),
                child: Center(
                  child: Column(
                    children: <Widget>[
                      const AssistantAvatar(),
                      ResponseBubble(generatedContent: state.response),
                    ],
                  ),
                ),
              );
            }
            // This state will never exist...
            return const SizedBox.shrink();
          },
        ),
      ),
    );
  }
}
