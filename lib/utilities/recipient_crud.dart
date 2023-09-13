import 'package:myparrot/db/db_helper.dart';
import 'package:myparrot/models/recipient_mod.dart';

Future<List<RecipientModel>> getRecipients() async {
  List<RecipientModel> recipientList =
      await DatabaseHelper.instance.getRecipients();
  return recipientList;
}

Future<int> addRecipient({required String name, required String number}) async {
  RecipientModel newRecipientModel = RecipientModel(
    name: name,
    number: number,
  );
  int result = await DatabaseHelper.instance.insertRecipient(newRecipientModel);
  return result;
}

Future<int> updateRecipient(
    {required RecipientModel recipient,
    required String newName,
    required String newNumber}) async {
  RecipientModel updatedRecipientModel = RecipientModel(
    id: recipient.id,
    name: newName.isNotEmpty ? newName : recipient.name,
    number: newNumber.isNotEmpty ? newNumber : recipient.number,
  );
  int result =
      await DatabaseHelper.instance.updateRecipient(updatedRecipientModel);

  return result;
}

Future<int> deleteRecipient(RecipientModel recipient) async {
  int result = await DatabaseHelper.instance.deleteRecipient(recipient.id!);
  return result;
}
