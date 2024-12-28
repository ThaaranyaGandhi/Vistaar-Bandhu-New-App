class LoanActivityModel {
  LoanActivityModel(
      {required this.name, required this.date, required this.status, required this.enabled});

  String name;
  String date;
  String status;
  bool enabled = false;
}
