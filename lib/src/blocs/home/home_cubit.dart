import 'package:bloc/bloc.dart';
import 'package:flutter_fruit_hub/src/blocs/home/home_state.dart';
import 'package:flutter_fruit_hub/src/services/remote_config_service.dart';

class HomeCubit extends Cubit<HomeState> {
  HomeCubit()
      : super(HomeStateInit(AppRemoteConfigService().homeWelcomeMessage,
            AppRemoteConfigService().homeTopCollectionTitle));

  Future getFirebaseConfig() async {
    var config = AppRemoteConfigService();
    await config.fetchAndActive();
    emit(
      HomeStateNewConfig(config.homeWelcomeMessage, config.homeTopCollectionTitle),
    );
  }
}
