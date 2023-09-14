import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:myparrot/blocs/identifier/identifier_bloc.dart';
import 'package:myparrot/blocs/pending/pending_bloc.dart';
import 'package:myparrot/configs/my_colors.dart';
import 'package:myparrot/configs/my_sizes.dart';
import 'package:myparrot/screens/summary/components/pending/pending_listview.dart';

class PendingView extends StatelessWidget {
  const PendingView({super.key});

  @override
  Widget build(BuildContext context) {
    final identifierBloc = BlocProvider.of<IdentifierBloc>(context);
    context
        .read<PendingBloc>()
        .add(FetchPendingMsg(deviceId: identifierBloc.identifier));
    return BlocBuilder<PendingBloc, PendingState>(builder: (context, state) {
      if (state is PendingFetchLoading) {
        return const Center(
          child: CupertinoActivityIndicator(),
        );
      } else if (state is PendingFetched) {
        return PendingListView(pendingMsgs: state.pendingMsgList);
      } else if (state is PendingFetchFailed) {
        return Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image.asset("assets/images/parachute.png",
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
