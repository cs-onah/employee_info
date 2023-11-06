part of 'date_picker.dart';

enum PickerOption { full, limited }

class CalendarPickerOptions extends StatelessWidget {
  final PickerOption? option;
  final ValueChanged<DateTime?>? onChanged;
  final DateTime? selectedDate;
  const CalendarPickerOptions({
    super.key,
    this.option,
    this.onChanged,
    this.selectedDate,
  });

  DateTime get today => DateTime.now();

  DateTime get nextOneWeek => DateTime.now().add(const Duration(days: 7));

  /// Monday = 1
  /// ...
  /// Sunday = 7
  ///
  /// nextMonday = 1 week (7 days) + 1 day;
  DateTime get nextMonday {
    final daysUntilMonday = 8 - today.weekday;
    final monday = today.add(Duration(days: daysUntilMonday));
    return monday;
  }

  /// next Tuesday = 1 week (8 days) + 2 days
  DateTime get nextTuesday {
    final daysUntilMonday = 9 - today.weekday;
    final tuesday = today.add(Duration(days: daysUntilMonday));
    return tuesday;
  }

  @override
  Widget build(BuildContext context) {
    if (option == PickerOption.full) {
      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Expanded(child: optionTile("Today", today)),
              const SizedBox(width: 16),
              Expanded(child: optionTile("Next Monday", nextMonday)),
            ],
          ),
          const SizedBox(height: 16),
          Row(
            children: [
              Expanded(child: optionTile("Next Tuesday", nextTuesday)),
              const SizedBox(width: 16),
              Expanded(child: optionTile("After 1 week", nextOneWeek)),
            ],
          ),
        ],
      );
    }
    if (option == PickerOption.limited) {
      return Row(
        children: [
          Expanded(child: nullOptionTile("No date")),
          const SizedBox(width: 16),
          Expanded(child: optionTile("Today", today)),
        ],
      );
    }
    return const SizedBox.shrink();
  }

  Widget optionTile(String text, DateTime date) {
    bool isSelected = date.isSameDay(selectedDate);
    return InkWell(
      onTap: () => onChanged?.call(date),
      child: Container(
        padding: const EdgeInsets.all(8),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(4),
          color: isSelected
              ? AppColors.primaryBlueColor
              : AppColors.accentBlueColor,
        ),
        child: Center(
          child: Text(
            text,
            style: TextStyle(
              color: isSelected ? Colors.white : AppColors.primaryBlueColor,
            ),
          ),
        ),
      ),
    );
  }

  Widget nullOptionTile(String text) {
    bool isSelected = selectedDate == null;
    return InkWell(
      onTap: () => onChanged?.call(null),
      child: Container(
        padding: const EdgeInsets.all(8),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(4),
          color: isSelected
              ? AppColors.primaryBlueColor
              : AppColors.accentBlueColor,
        ),
        child: Center(
          child: Text(
            text,
            style: TextStyle(
              color: isSelected ? Colors.white : AppColors.primaryBlueColor,
            ),
          ),
        ),
      ),
    );
  }
}

extension DateUtil on DateTime {
  String get dateReadable {
    return intl.DateFormat('d MMM yyyy').format(this);
  }

  bool isSameDay(DateTime? other) {
    if (other != null) {
      return dateReadable == other.dateReadable;
    }
    return false;
  }
}
