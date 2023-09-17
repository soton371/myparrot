import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:myparrot/blocs/selected_recipient/selected_recipient_bloc.dart';
import 'package:myparrot/models/recipient_mod.dart';
import 'package:myparrot/screens/message/message_screen.dart';

class SelectedAppBar extends StatelessWidget {
  const SelectedAppBar(
      {super.key,
      required this.selectedCount,
      required this.selectRecipientList});
  final int selectedCount;
  final List<RecipientModel> selectRecipientList;

  @override
  Widget build(BuildContext context) {
    return AppBar(
      elevation: 1,
      leading: IconButton(
          onPressed: () {
            context.read<SelectedRecipientBloc>().add(CallUnselectRecipient());
          },
          icon: const Icon(Icons.arrow_back)),
      title: Text("$selectedCount selected"),
      actions: [
        CupertinoButton(
            child: const Icon(CupertinoIcons.paperplane),
            onPressed: () {
              Navigator.push(
                  context,
                  CupertinoPageRoute(
                      builder: (_) =>
                          const MessageScreen(name: "Name List", number: "01518606399")));
            })
        /*
        PopupMenuButton(
          onSelected: (value) {
            switch (value) {
              case 'Mark important':
                context.read<SelectNotificationBloc>().add(ImportantActionEvent(
                    selectedNotifications: selectRecipientList));
                break;
              case 'Mark not important':
                context.read<SelectNotificationBloc>().add(NotImportantActionEvent(
                    selectedNotifications: selectRecipientList));
                break;
              case 'Add favorite':
                context.read<SelectNotificationBloc>().add(AddFavoriteActionEvent(
                    selectedNotifications: selectRecipientList));
                break;
              case 'Remove favorite':
                context.read<SelectNotificationBloc>().add(RemoveFavoriteActionEvent(
                    selectedNotifications: selectRecipientList));
                break;
              case 'Read':
                context.read<SelectNotificationBloc>().add(ReadActionEvent(
                    selectedNotifications: selectRecipientList));
                break;
              case 'Unread':
                context.read<SelectNotificationBloc>().add(UnreadActionEvent(
                    selectedNotifications: selectRecipientList));
                break;
              default:
            }
          },
          itemBuilder: (BuildContext bc) {
            return [
              PopupMenuItem(
                value: importantTxt(selectNotificationList: selectRecipientList),
                child: Row(
                  children: [
                    const Icon(
                      Icons.bookmark_outline,
                      size: 18,
                    ),
                    Text("  ${importantTxt(selectNotificationList: selectRecipientList)}"),
                  ],
                ),
              ),
              PopupMenuItem(
                value: favoriteTxt(selectNotificationList: selectRecipientList),
                child: Row(
                  children: [
                    const Icon(
                      Icons.star_border,
                      size: 18,
                    ),
                    Text("  ${favoriteTxt(selectNotificationList: selectRecipientList)}"),
                  ],
                ),
              ),
              const PopupMenuItem(
                value: 'Read',
                child: Row(
                  children: [
                    Icon(
                      Icons.visibility_outlined,
                      size: 18,
                    ),
                    Text("  Read"),
                  ],
                ),
              ),
              const PopupMenuItem(
                value: 'Unread',
                child: Row(
                  children: [
                    Icon(
                      Icons.visibility_off_outlined,
                      size: 18,
                    ),
                    Text("  Unread"),
                  ],
                ),
              ),
            ];
          },
        )
      */
      ],
      bottom: PreferredSize(
          preferredSize: const Size.fromHeight(2),
          child: Container(
            height: .5,
            width: double.maxFinite,
            color: Colors.grey.shade300,
          )),
    );
  }
}
