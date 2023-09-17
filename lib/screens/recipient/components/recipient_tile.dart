import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:myparrot/blocs/selected_recipient/selected_recipient_bloc.dart';
import 'package:myparrot/configs/my_colors.dart';
import 'package:myparrot/models/recipient_mod.dart';
import 'package:myparrot/screens/message/message_screen.dart';

class RecipientTile extends StatefulWidget {
  const RecipientTile({super.key, required this.recipient});
  final RecipientModel recipient;

  @override
  State<RecipientTile> createState() => _RecipientTileState();
}

class _RecipientTileState extends State<RecipientTile> {
  bool isSelect = false;
  @override
  Widget build(BuildContext context) {
    
    return BlocListener<SelectedRecipientBloc, SelectedRecipientState>(
      listener: (context, state) {
        if (state is UnselectRecipientState) {
          isSelect = false;
          setState(() {
            
          });
        }
      },
      child: InkWell(
        onLongPress: () {
          setState(() {
            isSelect = !isSelect;
          });
          if (isSelect) {
            debugPrint("add recipient");
            context
                .read<SelectedRecipientBloc>()
                .add(CallSelectRecipient(selectedRecipient: widget.recipient));
          } else {
            debugPrint("remove recipient");
            context
                .read<SelectedRecipientBloc>()
                .add(CallUnselectRecipientItem(selectedRecipient: widget.recipient));
          }
        },
        onTap: () => isSelect?null:
        Navigator.push(
            context,
            CupertinoPageRoute(
                builder: (_) => MessageScreen(
                    name: widget.recipient.name, number: widget.recipient.number))),
        child: Card(
          shadowColor: Colors.transparent,
          color:isSelect
                ? Colors.deepPurpleAccent.withOpacity(0.2)
                :  Colors.transparent,
          surfaceTintColor:isSelect ? Colors.deepPurpleAccent: Colors.transparent,
          child: Padding(
            padding: const EdgeInsets.all(8),
            child: Row(
              children: [
                //for icon
                isSelect
                      ? Container(
                          height: 40,
                          width: 40,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(100),
                              color: MyColors.seed),
                          alignment: Alignment.center,
                          child: const Icon(
                            Icons.done,
                            color: Colors.white,
                          ),
                        )
                      :
                ClipOval(
                  child: Container(
                    height: 43,
                    width: 43,
                    color: MyColors.myRandomColor(),
                    alignment: Alignment.center,
                    child: Text(
                      widget.recipient.name.substring(0, 1),
                      style: const TextStyle(fontSize: 21, color: Colors.white),
                    ),
                  ),
                ),
                //end icon
                const SizedBox(
                  width: 10,
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      widget.recipient.name,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: const TextStyle(
                          fontWeight: FontWeight.w500, fontSize: 17),
                    ),
                    Text(
                      widget.recipient.number,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: const TextStyle(color: MyColors.disable),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
