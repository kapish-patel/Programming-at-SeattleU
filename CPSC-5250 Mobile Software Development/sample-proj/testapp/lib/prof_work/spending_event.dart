
class SpendingEvent {
  final String merchant;
  final String category;
  final double amount;
  final DateTime date;

  SpendingEvent(this.merchant, this.category, this.amount, this.date);
}