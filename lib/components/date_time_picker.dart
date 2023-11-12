import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class DateTimePicker extends StatefulWidget {
  final bool? showDate;
  final ValueChanged<DateTime>? onDateTimeChanged;
  const DateTimePicker({super.key, this.showDate, this.onDateTimeChanged});

  @override
  State<DateTimePicker> createState() => _DateTimePickerState();
}

class _DateTimePickerState extends State<DateTimePicker> {
  DateTime datetime = DateTime(2000, 2, 2, 10, 20);

  @override
  Widget build(BuildContext context) {
    return
        // CupertinoPageScaffold(
        //   child:
        Center(
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Container(
          decoration: BoxDecoration(color: Colors.amber),
          child: Row(
            children: [
              SvgPicture.asset(
                "assets/images/ic_calendar.svg",
                height: 40,
                width: 40,
              ),
              CupertinoButton(
                child:
                    Text("${datetime.month}-${datetime.day}-${datetime.year}"),
                onPressed: () {
                  showCupertinoModalPopup(
                    context: context,
                    builder: (BuildContext context) => SizedBox(
                      height: 250,
                      child: CupertinoDatePicker(
                        mode: widget.showDate == false
                            ? CupertinoDatePickerMode.time
                            : CupertinoDatePickerMode.date,
                        backgroundColor: Colors.white,
                        initialDateTime: datetime,
                        use24hFormat: true,
                        onDateTimeChanged: (DateTime value) {
                          setState(() {
                            datetime = value;
                          });
                          widget.onDateTimeChanged?.call(datetime);
                        },
                      ),
                    ),
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
    // );
  }
}
