import 'package:flutter/material.dart';

import 'package:animate_do/animate_do.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:virtual_assistant/views/home/bloc/home_bloc.dart';
import 'package:virtual_assistant/views/home/bloc/home_event.dart';
import 'package:virtual_assistant/views/home/bloc/home_state.dart';
import 'package:virtual_assistant/model/snack_bar/snack_bar_type.dart';
import 'package:virtual_assistant/utils/helpers/helper_functions.dart';
import 'package:virtual_assistant/views/components/custom_app_bar.dart';
import 'package:virtual_assistant/utils/constants/theme/app_sizes.dart';
import 'package:virtual_assistant/views/home/components/app_drawer.dart';
import 'package:virtual_assistant/views/home/components/initial_home.dart';
import 'package:virtual_assistant/views/home/components/response_bubble.dart';
import 'package:virtual_assistant/utils/constants/theme/app_text_strings.dart';
import 'package:virtual_assistant/views/home/components/assistant_avatar.dart';
import 'package:virtual_assistant/views/home/components/bottom_navigation_widget.dart';

class HomeView extends StatefulWidget {
  const HomeView({super.key});

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView>
    with AutomaticKeepAliveClientMixin {
  late final GlobalKey<ScaffoldState> _scaffoldKey;
  bool _hasInitialized = false;

  @override
  bool get wantKeepAlive => true;

  @override
  void initState() {
    super.initState();
    _scaffoldKey = GlobalKey<ScaffoldState>();

    // Initialize only once when the app starts
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (!_hasInitialized) {
        final currentState = context.read<HomeBloc>().state;

        // Only trigger initialization if we're in true initial state
        // (not restored state)
        if (currentState is InitialHomeState) {
          context.read<HomeBloc>().add(InitialHomeEvent(context: context));
        }
        _hasInitialized = true;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return KeyedSubtree(
      key: const PageStorageKey(AppTextStrings.homeViewKey),
      child: Scaffold(
        key: _scaffoldKey,
        appBar: CustomAppBar(
          leading: IconButton(
            tooltip: AppTextStrings.menuButtonTooltip,
            onPressed: () {
              if (_scaffoldKey.currentState != null) {
                _scaffoldKey.currentState!.openDrawer();
              }
            },
            icon: Icon(
              Icons.menu_outlined,
              color: Theme.of(context).colorScheme.primary,
            ),
          ),
          title: BounceIn(child: const Text(AppTextStrings.appTitle)),
        ),
        drawer: const AppDrawer(),
        resizeToAvoidBottomInset: true,
        drawerEnableOpenDragGesture: false,
        backgroundColor: Theme.of(context).colorScheme.surface,
        bottomNavigationBar: BlocBuilder<HomeBloc, HomeState>(
          builder: (context, state) {
            if (state is LoadingHomeState) {
              return HelperFunctions.showLoadingScreen(context);
            }
            return const BottomNavigationWidget();
          },
        ),
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
            if (state is InitialHomeState) {
              return const InitialHome();
            }
            if (state is LoadedHomeState) {
              return SingleChildScrollView(
                key: const PageStorageKey(AppTextStrings.homeViewKey),
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
