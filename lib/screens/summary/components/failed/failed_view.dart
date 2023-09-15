import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:myparrot/blocs/failed/failed_bloc.dart';
import 'package:myparrot/blocs/identifier/identifier_bloc.dart';
import 'package:myparrot/configs/my_colors.dart';
import 'package:myparrot/configs/my_sizes.dart';
import 'package:myparrot/screens/summary/components/failed/failed_listview.dart';

class FailedView extends StatelessWidget {
  const FailedView({super.key});

  @override
  Widget build(BuildContext context) {
    final identifierBloc = BlocProvider.of<IdentifierBloc>(context);
    context
        .read<FailedBloc>()
        .add(FetchFailedMsg(deviceId: identifierBloc.identifier));
    return BlocBuilder<FailedBloc, FailedState>(builder: (context, state) {
      if (state is FailedFetchLoading) {
        return const Center(
          child: CupertinoActivityIndicator(),
        );
      } else if (state is FailedFetched) {
        return FailedListView(failedMsgs: state.failedMsgList);
      } else if (state is FailedFetchFailed) {
        return Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image.asset("assets/images/miyaw.png",
                  height: MySizes.emptyIcon, width: MySizes.emptyIcon),
              Text("\n${state.errorMsg}",
                  textAlign: TextAlign.center,
                  style: const TextStyle(color: MyColors.disable)),
            ],
          ),
        );
      } else {
        return const Text('Init');
      }
    });
  }
}
