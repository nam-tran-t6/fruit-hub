import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_fruit_hub/src/blocs/complete_detail/complete_detail_cubit.dart';
import 'package:flutter_fruit_hub/src/blocs/input_card_detail/input_card_detail_cubit.dart';
import 'package:flutter_fruit_hub/src/constants/strings.dart';
import 'package:flutter_fruit_hub/src/helpers/extension/string_extension.dart';
import 'package:flutter_fruit_hub/src/helpers/styles/app_text_styles.dart';
import 'package:flutter_fruit_hub/src/screens/home_screen.dart';
import 'package:flutter_fruit_hub/src/screens/order_completed_screen.dart';
import 'package:flutter_fruit_hub/src/widgets/app_button.dart';
import 'package:flutter_fruit_hub/src/widgets/bottom_sheet_base_widget.dart';
import 'package:flutter_fruit_hub/src/widgets/textfield_container.dart';

import 'input_card_widget.dart';

class CompleteDetailsWidget extends StatelessWidget {
  static const _ADDRESS_MESSAGE_POSITION = 0;
  static const _PHONE_MESSAGE_POSITION = 1;

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<CompleteDetailCubit, CompleteDetailState>(
      listener: (context, state) {
        if (state is ValidInformationInputState) {
          Navigator.popUntil(context, ModalRoute.withName(HomeScreen.TAG));
          Navigator.pushNamed(context, OrderCompletedScreen.TAG);
        } else if (state is ShouldShowInputCardState) {
          Navigator.of(context).pop();
          _showInputCardWidget(context);
        }
      },
      builder: (context, state) {
        return BottomSheetBaseWidget(
          child: Container(
              padding: const EdgeInsets.only(top: 40, bottom: 47, left: 24, right: 24),
              child: _buildContentWithState(context, state)),
        );
      },
    );
  }

  Widget _buildContentWithState(BuildContext context, CompleteDetailState state) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Text(
          Strings.delivery_address,
          style: AppTextStyles.kBoldPortGore20,
        ),
        SizedBox(
          height: 16,
        ),
        TextFieldContainer(
          child: TextField(
            key: Key('address_field'),
            decoration: InputDecoration(
              contentPadding: EdgeInsets.only(
                left: 24,
                top: 13,
                bottom: 14,
              ),
              hintText: Strings.sample_address,
              hintStyle: AppTextStyles.kNormalSilver20,
              border: InputBorder.none,
              isDense: false,
            ),
            keyboardType: TextInputType.text,
            onChanged: (data) =>
                BlocProvider.of<CompleteDetailCubit>(context).setAddress(data),
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(top: 1),
          child: _getMessageWidgetByState(state)[_ADDRESS_MESSAGE_POSITION],
        ),
        SizedBox(
          height: 24,
        ),
        Text(
          Strings.number_we_can_call,
          style: AppTextStyles.kBoldPortGore20,
        ),
        SizedBox(
          height: 16,
        ),
        TextFieldContainer(
          child: TextField(
            key: Key('phone_field'),
            decoration: InputDecoration(
              contentPadding: EdgeInsets.only(
                left: 24,
                top: 13,
                bottom: 14,
              ),
              hintText: Strings.sample_phone_number,
              hintStyle: AppTextStyles.kNormalSilver20,
              border: InputBorder.none,
              isDense: false,
            ),
            keyboardType: TextInputType.number,
            onChanged: (data) =>
                BlocProvider.of<CompleteDetailCubit>(context).setPhoneNumber(data),
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(top: 1),
          child: _getMessageWidgetByState(state)[_PHONE_MESSAGE_POSITION],
        ),
        SizedBox(
          height: 40,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            AppButton(
              isPrimary: false,
              width: 125,
              height: 56,
              buttonText: Strings.pay_on_delivery,
              onPressed: () {
                BlocProvider.of<CompleteDetailCubit>(context).submit();
              },
            ),
            AppButton(
              isPrimary: false,
              width: 125,
              height: 56,
              buttonText: Strings.pay_with_card,
              onPressed: () {
                BlocProvider.of<CompleteDetailCubit>(context).payWithCard();
              },
            ),
          ],
        ),
      ],
    );
  }

  void _showInputCardWidget(BuildContext context) {
    showModalBottomSheet(
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.only(
              topRight: Radius.circular(24), topLeft: Radius.circular(24))),
      backgroundColor: Colors.transparent,
      isScrollControlled: true,
      isDismissible: false,
      context: context,
      builder: (context) {
        return BlocProvider(
          create: (context) => InputCardDetailCubit(),
          child: Builder(
            builder: (context) {
              return InputCardWidget();
            },
          ),
        );
      },
    );
  }

  List<Widget> _getMessageWidgetByState(CompleteDetailState state) {
    var addressMsgWidget = Text('');
    var phoneMsgWidget = Text('');
    if (state is CompleteDetailErrorInput) {
      String _addressMsg = state.getErrorText[_ADDRESS_MESSAGE_POSITION];
      String _phoneMsg = state.getErrorText[_PHONE_MESSAGE_POSITION];

      if (_addressMsg.isNotBlank()) {
        addressMsgWidget = Text(
          _addressMsg,
          style: AppTextStyles.kNormalCinnabar14,
        );
      }

      if (_phoneMsg.isNotBlank()) {
        phoneMsgWidget = Text(
          _phoneMsg,
          style: AppTextStyles.kNormalCinnabar14,
        );
      }
    }
    return [addressMsgWidget, phoneMsgWidget];
  }
}
