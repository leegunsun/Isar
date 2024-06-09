import 'package:flutter/material.dart';

enum DateSelectType {
  start("시작"),
  end("종료");

  const DateSelectType(this.name);

  final String name;
}

class DateTimePicker extends StatefulWidget {
  const DateTimePicker({
    super.key,
    required this.selectDate,
    required this.dateSelectType
  });

  final void Function(DateTime) selectDate;
  final DateSelectType dateSelectType;

  @override
  State<DateTimePicker> createState() => _DateTimePickerState();
}

class _DateTimePickerState extends State<DateTimePicker> {
  DateTime? _selectedDate;

  Future<void> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2000),
      lastDate: DateTime(2101),
    );
    if (picked != null && picked != _selectedDate) {
      setState(() {
        _selectedDate = picked;
      });

      widget.selectDate(_selectedDate!);
    }
  }

  String _showDate () {

    if(_selectedDate == null) {
      if(widget.dateSelectType == DateSelectType.start) return "언제 읽기 시작했나요?";
      if(widget.dateSelectType == DateSelectType.end) return "책을 다 읽은 날짜를 선택해주세요.";

      return "날짜를 선택해 주세요.";
    }

    if(_selectedDate?.toLocal() == null) {
      return "날짜를 가져오는데 오류가 발생했습니다.";
    }

    return _selectedDate!.toLocal().toString().split(' ')[0];
  }

  bool interval = true;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () async {
        if(interval) {
          interval = false;
          Future.delayed(const Duration(milliseconds: 500), () => interval = true);
          _selectDate(context);
        }
      },
      child: Container(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Padding(
              padding: EdgeInsets.only(right: 8.0),
              child: Icon(Icons.date_range_outlined),
            ),
            Text(_showDate(),
            )
          ],
        ),
      ),
    );
  }

}