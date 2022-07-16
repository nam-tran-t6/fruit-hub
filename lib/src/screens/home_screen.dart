import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_fruit_hub/src/blocs/home/home_cubit.dart';
import 'package:flutter_fruit_hub/src/blocs/home/home_state.dart';
import 'package:flutter_fruit_hub/src/widgets/collection_fruits_widget.dart';
import 'package:flutter_fruit_hub/src/widgets/drawer_widget.dart';
import 'package:flutter_fruit_hub/src/widgets/recommended_combo_widget.dart';
import 'package:flutter_fruit_hub/src/widgets/top_section_widget.dart';

class HomeScreen extends StatelessWidget {
  static const String TAG = 'home_screen';

  @override
  Widget build(BuildContext context) {
    final username = ModalRoute.of(context)!.settings.arguments as String;
    var homeBloc = BlocProvider.of<HomeCubit>(context);
    homeBloc.getFirebaseConfig();

    GlobalKey<ScaffoldState> scaffoldKey = GlobalKey();

    return Scaffold(
      key: scaffoldKey,
      backgroundColor: Colors.white,
      drawer: DrawerWidget(username: username,),
      drawerEnableOpenDragGesture: false,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.only(bottom: 16),
            child: Container(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Flexible(
                    child: BlocBuilder<HomeCubit, HomeState>(
                      builder: (context, state) {
                        var message = '';
                        if (state is HomeStateInit) {
                          message = state.welcomeMessage;
                        } else if (state is HomeStateNewConfig) {
                          message = state.welcomeMessage;
                        }
                        return TopSectionWidget(
                        name: username,
                        welcomeText: message,
                        scaffoldKey: scaffoldKey,
                        );
                      },
                    ),
                  ),
                  Flexible(
                    child: Container(
                      margin: EdgeInsets.only(top: 40, left: 24),
                      child: BlocBuilder<HomeCubit, HomeState>(
                        builder: (context, state) {
                          var title = '';
                          if (state is HomeStateInit) {
                            title = state.topCollectionTitle;
                          } else if (state is HomeStateNewConfig) {
                            title = state.topCollectionTitle;
                          }
                          return RecommendedComboWidget(
                            text: title,
                          );
                        },
                      ),
                    ),
                  ),
                  Flexible(
                    child: Container(
                      alignment: Alignment.center,
                      margin: EdgeInsets.only(top: 48, left: 24),
                      child: CollectionFruitsWidget(),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
