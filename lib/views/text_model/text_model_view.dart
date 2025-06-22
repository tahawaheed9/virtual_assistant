import 'package:flutter/material.dart';

import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:virtual_assistant/views/components/app_drawer.dart';
import 'package:virtual_assistant/model/snack_bar/snack_bar_type.dart';
import 'package:virtual_assistant/utils/helpers/helper_functions.dart';
import 'package:virtual_assistant/views/components/custom_app_bar.dart';
import 'package:virtual_assistant/views/components/loading_screen.dart';
import 'package:virtual_assistant/views/components/content_widget.dart';
import 'package:virtual_assistant/views/text_model/bloc/text_model_bloc.dart';
import 'package:virtual_assistant/views/text_model/bloc/text_model_state.dart';
import 'package:virtual_assistant/views/text_model/bloc/text_model_event.dart';
import 'package:virtual_assistant/utils/constants/theme/app_text_strings.dart';
import 'package:virtual_assistant/views/text_model/components/initial_text_model_view.dart';
import 'package:virtual_assistant/views/text_model/components/bottom_navigation_widget.dart';

class TextModelView extends StatefulWidget {
  const TextModelView({super.key});

  @override
  State<TextModelView> createState() => _TextModelViewState();
}

class _TextModelViewState extends State<TextModelView>
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
        final currentState = context.read<TextModelBloc>().state;

        // Only trigger initialization if we're in true initial state
        // (not restored state)
        if (currentState is InitialTextModelState) {
          context.read<TextModelBloc>().add(const InitialTextModelEvent());
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
        title: const Text(AppTextStrings.appTitle),
      ),
      drawer: const AppDrawer(),
      resizeToAvoidBottomInset: true,
      drawerEnableOpenDragGesture: false,
      backgroundColor: Theme.of(context).colorScheme.surface,
      bottomNavigationBar: BlocBuilder<TextModelBloc, TextModelState>(
        builder: (context, state) {
          if (state is! GeneratingResponseTextModelState) {
            return BottomNavigationWidget(
              bloc: context.read<TextModelBloc>(),
              state: state,
            );
          }
          return const SizedBox.shrink();
        },
      ),
      body: BlocConsumer<TextModelBloc, TextModelState>(
        listener: (context, state) {
          if (state is ListeningTextModelState) {
            HelperFunctions.showSnackBar(
              context: context,
              snackBarType: SnackBarType.general,
              message: AppTextStrings.onListening,
            );
            return;
          }
          if (state is ErrorTextModelState) {
            HelperFunctions.showSnackBar(
              context: context,
              snackBarType: SnackBarType.error,
              message: state.error,
            );
            return;
          }
        },
        builder: (context, state) {
          if (state is GeneratingResponseTextModelState) {
            ScaffoldMessenger.of(context).clearSnackBars();
            return const LoadingScreen(
              text: AppTextStrings.onGeneratingResponse,
            );
          }
          if (state is LoadedTextModelState) {
            _lastResponse = state.response;
            return ContentWidget(response: state.response);
          }
          if (state is ListeningTextModelState ||
              state is ErrorTextModelState) {
            if (_lastResponse != null) {
              return ContentWidget(response: _lastResponse!);
            }
          }
          return const InitialTextModelView();
        },
      ),
    );
  }
}
