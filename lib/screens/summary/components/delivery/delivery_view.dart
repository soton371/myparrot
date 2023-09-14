import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:myparrot/blocs/delivery/delivery_bloc.dart';
import 'package:myparrot/blocs/identifier/identifier_bloc.dart';
import 'package:myparrot/configs/my_colors.dart';
import 'package:myparrot/configs/my_sizes.dart';
import 'package:myparrot/screens/summary/components/delivery/delivery_listview.dart';

class DeliveryView extends StatelessWidget {
  const DeliveryView({super.key});

  @override
  Widget build(BuildContext context) {
    final identifierBloc = BlocProvider.of<IdentifierBloc>(context);
    context
        .read<DeliveryBloc>()
        .add(FetchDeliveryMsg(deviceId: identifierBloc.identifier));

    return BlocBuilder<DeliveryBloc, DeliveryState>(builder: (context, state) {
      if (state is DeliveryFetchLoading) {
        return const Center(
          child: CupertinoActivityIndicator(),
        );
      } else if (state is DeliveryFetched) {
        return DeliveryListView(deliveryMsgs: state.deliveryMsgList);
      } else if (state is DeliveryFetchFailed) {
        return Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image.asset("assets/images/miyaw.png",
                  height: MySizes.emptyIcon, width: MySizes.emptyIcon),
              const Text("\nNo Communication History",
                  textAlign: TextAlign.center,
                  style: TextStyle(color: MyColors.disable)),
            ],
          ),
        );
      } else {
        return const Text('Init');
      }
    });
  }
}