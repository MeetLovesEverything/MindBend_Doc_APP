
class MouModel{
  String date;
  String orgName;
  String orgAddress;
  String orgContact;
  String orgPhone;
  String orgEmail;
  List<String> orgPromised;
  List<String> mbPromised;
  String lastValidDate;

  MouModel({
    required this.date,
    required this.orgName,
    required this.orgAddress,
    required this.orgContact,
    required this.orgPhone,
    required this.orgEmail,
    required this.orgPromised,
    required this.mbPromised,
    required this.lastValidDate,
});
}