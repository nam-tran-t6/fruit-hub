import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_fruit_hub/src/blocs/input_card_detail/input_card_detail_cubit.dart';
import 'package:flutter_fruit_hub/src/constants/strings.dart';
import 'package:flutter_fruit_hub/src/helpers/extension/string_extension.dart';
import 'package:flutter_fruit_hub/src/helpers/formatter/payment_card_date_formatter.dart';
import 'package:flutter_fruit_hub/src/helpers/formatter/payment_card_number_formatter.dart';
import 'package:flutter_fruit_hub/src/helpers/styles/app_button_style.dart';
import 'package:flutter_fruit_hub/src/helpers/styles/app_colors.dart';
import 'package:flutter_fruit_hub/src/helpers/styles/app_text_styles.dart';
import 'package:flutter_fruit_hub/src/screens/home_screen.dart';
import 'package:flutter_fruit_hub/src/screens/order_completed_screen.dart';
import 'package:flutter_fruit_hub/src/widgets/bottom_sheet_base_widget.dart';
import 'package:flutter_fruit_hub/src/widgets/textfield_container.dart';

// ignore: must_be_immutable
class InputCardWidget extends StatelessWidget {
  static const _NAME_MESSAGE_POSITION = 0;
  static const _PHONE_MESSAGE_POSITION = 1;
  static const _DATE_MESSAGE_POSITION = 2;
  static const _CCV_MESSAGE_POSITION = 3;

  late var _cardNameErrorWidget;
  late var _cardPhoneErrorWidget;
  late var _cardDateErrorWidget;
  late var _cardCCVErrorWidget;

  InputCardWidget({Key? key}) : super(key: key) {
    _cardNameErrorWidget = Text('');
    _cardPhoneErrorWidget = Text('');
    _cardDateErrorWidget = Text('');
    _cardCCVErrorWidget = Text('');
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<InputCardDetailCubit, InputCardState>(
      listener: (context, state) {
        if (state is InputCardSubmitSuccess) {
          Navigator.popUntil(
            context,
            ModalRoute.withName(HomeScreen.TAG),
          );
          Navigator.pushNamed(context, OrderCompletedScreen.TAG);
        }
      },
      builder: (context, state) {
        if (state is InputCardError) {
          String _cardNameMessage = state.getErrorText[_NAME_MESSAGE_POSITION];
          String _cardPhoneMessage = state.getErrorText[_PHONE_MESSAGE_POSITION];
          String _cardDateMessage = state.getErrorText[_DATE_MESSAGE_POSITION];
          String _cardCCVMessage = state.getErrorText[_CCV_MESSAGE_POSITION];
          if (_cardNameMessage.isNotBlank()) {
            _cardNameErrorWidget = Text(
              _cardNameMessage,
              style: AppTextStyles.kNormalCinnabar14,
            );
          }
          if (_cardPhoneMessage.isNotBlank()) {
            _cardPhoneErrorWidget = Text(
              _cardPhoneMessage,
              style: AppTextStyles.kNormalCinnabar14,
            );
          }
          if (_cardDateMessage.isNotBlank()) {
            _cardDateErrorWidget = Text(
              _cardDateMessage,
              style: AppTextStyles.kNormalCinnabar14,
            );
          }
          if (_cardCCVMessage.isNotBlank()) {
            _cardCCVErrorWidget = Text(
              _cardCCVMessage,
              style: AppTextStyles.kNormalCinnabar14,
            );
          }
        }
        return BottomSheetBaseWidget(
          child: buildContent(context),
        );
      },
    );
  }

  Widget buildContent(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Container(
          padding: const EdgeInsets.only(top: 40, bottom: 24, left: 24, right: 24),
          child: _buildInputCardContentWidget(context),
        ),
        Container(
          decoration: BoxDecoration(
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(24),
                topRight: Radius.circular(24),
              ),
              color: AppColors.texas_rose),
          alignment: Alignment.center,
          height: 96,
          child: ElevatedButton(
            onPressed: () {
              BlocProvider.of<InputCardDetailCubit>(context).submit();
            },
            child: Padding(
                padding: EdgeInsets.only(left: 32, right: 32, top: 16, bottom: 16),
                child: Text(
                  Strings.complete_order,
                  style: AppTextStyles.kNormalTexasRose16,
                )),
            style: AppButtonStyles.kWhiteBorder10,
          ),
        )
      ],
    );
  }

  Widget _buildInputCardContentWidget(BuildContext context) {
    var inputCardCubit = BlocProvider.of<InputCardDetailCubit>(context);
    TextEditingController cardNumController = TextEditingController();
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          Strings.card_holders_name,
          style: AppTextStyles.kBoldPortGore20,
        ),
        SizedBox(
          height: 16,
        ),
        TextFieldContainer(
          key: ValueKey('card_holders_name'),
          child: TextField(
            decoration: InputDecoration(
              contentPadding: EdgeInsets.only(
                left: 24,
                top: 13,
                bottom: 14,
              ),
              hintText: Strings.adolphus_chris,
              hintStyle: AppTextStyles.kNormalSilver20,
              border: InputBorder.none,
              isDense: false,
            ),
            onChanged: (data) {
              inputCardCubit.setCardHolderName = data;
            },
            keyboardType: TextInputType.text,
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(top: 1),
          child: _cardNameErrorWidget,
        ),
        SizedBox(
          height: 24,
        ),
        Text(
          Strings.card_number,
          style: AppTextStyles.kBoldPortGore20,
        ),
        SizedBox(
          height: 16,
        ),
        TextFieldContainer(
          key: ValueKey('card_number_detail'),
          child: TextField(
            decoration: InputDecoration(
              contentPadding: EdgeInsets.only(
                left: 24,
                top: 13,
                bottom: 14,
              ),
              hintText: Strings.card_number_detail,
              hintStyle: AppTextStyles.kNormalSilver20,
              border: InputBorder.none,
              isDense: false,
            ),
            controller: cardNumController,
            onChanged: (value) {
              cardNumController.text;
              inputCardCubit.setCardNumber = value;
            },
            inputFormatters: [
              FilteringTextInputFormatter.allow(RegExp(r'[0-9]')),
              LengthLimitingTextInputFormatter(19),
              PaymentCardNumberFormatter()
            ],
            keyboardType: TextInputType.number,
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(top: 1),
          child: _cardPhoneErrorWidget,
        ),
        SizedBox(
          height: 24,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  Strings.date,
                  style: AppTextStyles.kBoldPortGore20,
                ),
                SizedBox(
                  height: 16,
                ),
                Container(
                  height: 56,
                  width: 134,
                  child: TextFieldContainer(
                    key: ValueKey('date_detail'),
                    child: TextField(
                      decoration: InputDecoration(
                        contentPadding: EdgeInsets.only(
                          left: 24,
                          top: 13,
                          bottom: 14,
                        ),
                        hintText: Strings.date_detail,
                        hintStyle: AppTextStyles.kNormalSilver20,
                        border: InputBorder.none,
                        isDense: false,
                      ),
                      onChanged: (data) {
                        inputCardCubit.setCardDate = data;
                      },
                      inputFormatters: [
                        FilteringTextInputFormatter.allow(RegExp(r'[0-9]')),
                        LengthLimitingTextInputFormatter(4),
                        PaymentCardDateFormatter()
                      ],
                      keyboardType: TextInputType.number,
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 1),
                  child: _cardDateErrorWidget,
                )
              ],
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  Strings.ccv,
                  style: AppTextStyles.kBoldPortGore20,
                ),
                SizedBox(
                  height: 16,
                ),
                Container(
                  height: 56,
                  width: 134,
                  child: TextFieldContainer(
                    key: ValueKey('ccv_detail'),
                    child: TextField(
                      decoration: InputDecoration(
                        contentPadding: EdgeInsets.only(
                          left: 24,
                          top: 13,
                          bottom: 14,
                        ),
                        hintText: Strings.ccv_detail,
                        hintStyle: AppTextStyles.kNormalSilver20,
                        border: InputBorder.none,
                        isDense: false,
                      ),
                      onChanged: (data) {
                        inputCardCubit.setCardCcv = data;
                      },
                      inputFormatters: [
                        FilteringTextInputFormatter.allow(RegExp(r'[0-9]')),
                        LengthLimitingTextInputFormatter(3),
                      ],
                      keyboardType: TextInputType.number,
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 1),
                  child: _cardCCVErrorWidget,
                )
              ],
            ),
          ],
        ),
      ],
    );
  }
}
