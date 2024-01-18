class SpendingEvent {
  final String merchant;
  final String category;
  final double amount;
  final DateTime date;

  SpendingEvent({required this.merchant, required this.amount, required this.date, required this.category});
}
