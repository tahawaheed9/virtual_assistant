import 'package:flutter/material.dart';

import 'package:animate_do/animate_do.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:virtual_assistant/views/home/bloc/home_bloc.dart';
import 'package:virtual_assistant/views/home/bloc/home_event.dart';
import 'package:virtual_assistant/views/home/bloc/home_state.dart';
import 'package:virtual_assistant/model/snack_bar/snack_bar_type.dart';
import 'package:virtual_assistant/utils/helpers/helper_functions.dart';
import 'package:virtual_assistant/views/components/custom_app_bar.dart';
import 'package:virtual_assistant/views/home/components/app_drawer.dart';
import 'package:virtual_assistant/views/home/components/initial_home.dart';
import 'package:virtual_assistant/views/home/components/content_widget.dart';
import 'package:virtual_assistant/utils/constants/theme/app_text_strings.dart';
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
  String? _lastResponse;

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
          context.read<HomeBloc>().add(const InitialHomeEvent());
        }
        _hasInitialized = true;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return Scaffold(
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
          if (state is! LoadingHomeState) {
            return BottomNavigationWidget(
              homeBloc: context.read<HomeBloc>(),
              homeState: state,
            );
          }
          return const SizedBox.shrink();
        },
      ),
      body: BlocConsumer<HomeBloc, HomeState>(
        listener: (context, state) {
          if (state is ListeningHomeState) {
            HelperFunctions.showSnackBar(
              context: context,
              snackBarType: SnackBarType.general,
              message: AppTextStrings.onListening,
            );
            return;
          }
          if (state is ErrorHomeState) {
            HelperFunctions.showSnackBar(
              context: context,
              snackBarType: SnackBarType.error,
              message: state.error,
            );
            return;
          }
        },
        builder: (context, state) {
          if (state is LoadingHomeState) {
            ScaffoldMessenger.of(context).clearSnackBars();
            return HelperFunctions.showGeneratingResponseScreen(context);
          }
          if (state is LoadedHomeState) {
            _lastResponse = state.response;
            return ContentWidget(response: state.response);
          }
          if (state is ListeningHomeState) {
            if (_lastResponse != null) {
              return ContentWidget(response: _lastResponse!);
            } else {
              return const InitialHome();
            }
          }
          return const InitialHome();
        },
      ),
    );
  }
}
