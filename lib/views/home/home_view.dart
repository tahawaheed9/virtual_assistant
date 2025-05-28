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
import 'package:virtual_assistant/views/home/components/chat_bubble.dart';
import 'package:virtual_assistant/utils/constants/theme/text_strings.dart';
import 'package:virtual_assistant/views/home/components/initial_home.dart';
import 'package:virtual_assistant/views/home/components/assistant_avatar.dart';
import 'package:virtual_assistant/views/home/components/bottom_navigation_widget.dart';

class HomeView extends StatelessWidget {
  const HomeView({super.key});

  @override
  Widget build(BuildContext context) {
    final homeBloc = context.read<HomeBloc>();
    final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();

    homeBloc.add(InitialHomeEvent(context: context));
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
      drawerEnableOpenDragGesture: false,
      body: BlocConsumer<HomeBloc, HomeState>(
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
        builder: (context, state) {
          if (state is LoadingHomeState) {
            return HelperFunctions.showLoadingScreen(context);
          } else if (state is LoadedHomeState) {
            return SingleChildScrollView(
              padding: const EdgeInsets.all(AppSizes.kDefaultPadding),
              child: Center(
                child: Column(
                  children: <Widget>[
                    const AssistantAvatar(),
                    ChatBubble(generatedContent: state.response),
                  ],
                ),
              ),
            );
          }
          return const InitialHome();
        },
      ),
      resizeToAvoidBottomInset: true,
      bottomNavigationBar: BottomNavigationWidget(
        homeBloc: context.read<HomeBloc>(),
      ),
    );
  }
}
