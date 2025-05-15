import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:siram_pintar_mobile/models/schedule_request_model.dart';
import 'package:siram_pintar_mobile/repositories/schedule_repository.dart';

class AddSchedulePage extends StatefulWidget {
  final int plantId;
  final int deviceId;

  const AddSchedulePage({
    super.key,
    required this.plantId,
    required this.deviceId,
  });

  @override
  State<AddSchedulePage> createState() => _AddSchedulePageState();
}

class _AddSchedulePageState extends State<AddSchedulePage> {
  TimeOfDay selectedTime = const TimeOfDay(hour: 13, minute: 5);
  Duration duration = const Duration(seconds: 20);
  bool enableMoistureCondition = false;
  String moistureOperator = 'Lebih Besar';
  int moistureValue = 10;
  String scheduleType = 'Setiap Hari';
  DateTime? selectedDate;
  int selectedWeekday = 7; 

  final ScheduleRepository _repository = ScheduleRepository();

  Future<void> _submitSchedule() async {
    final wateringTime = selectedTime.format(context);
    final String schedule;
    final String frequency;
    int? dayOfMonth;
    int? dayOfWeek;
    String? onceOnDate;

    switch (scheduleType) {
      case 'Setiap Hari':
        schedule = 'daily';
        frequency = 'daily';
        break;
      case 'Setiap Minggu':
        schedule = 'weekly';
        frequency = 'weekly';
        dayOfWeek = selectedWeekday;
        break;
      case 'Setiap Bulan':
        schedule = 'monthly';
        frequency = 'monthly';
        dayOfMonth = selectedDate?.day ?? 1;
        break;
      case 'Pilih Tanggal':
        schedule = 'once';
        frequency = 'once';
        onceOnDate = selectedDate != null
            ? DateFormat('yyyy-MM-dd').format(selectedDate!)
            : null;
        break;
      default:
        schedule = 'daily';
        frequency = 'daily';
    }

    final request = ScheduleRequestModel(
      plantId: widget.plantId,
      deviceId: widget.deviceId,
      wateringTime: wateringTime,
      duration: duration.inSeconds,
      schedule: schedule,
      frequency: frequency,
      dayOfMonth: dayOfMonth,
      dayOfWeek: dayOfWeek,
      onceOnDate: onceOnDate,
      moistureThreshold: enableMoistureCondition ? moistureValue : null,
      active: true,
    );

    final success = await _repository.createSchedule(request);
    if (success) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Jadwal berhasil disimpan')),
      );
      Navigator.pop(context);
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Gagal menyimpan jadwal')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Tambah Jadwal')),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            DropdownButton<String>(
              value: scheduleType,
              isExpanded: true,
              items: ['Setiap Hari', 'Setiap Minggu', 'Setiap Bulan', 'Pilih Tanggal']
                  .map((e) => DropdownMenuItem(value: e, child: Text(e)))
                  .toList(),
              onChanged: (value) {
                setState(() {
                  scheduleType = value!;
                  selectedDate = null;
                });
              },
            ),
            const SizedBox(height: 16),
            if (scheduleType == 'Pilih Tanggal') ...[
              ElevatedButton(
                onPressed: () async {
                  final picked = await showDatePicker(
                    context: context,
                    initialDate: DateTime.now(),
                    firstDate: DateTime(2024),
                    lastDate: DateTime(2030),
                  );
                  if (picked != null) {
                    setState(() => selectedDate = picked);
                  }
                },
                child: Text(selectedDate == null
                    ? 'Pilih Tanggal'
                    : 'Dipilih: ${selectedDate!.toLocal().toString().split(' ')[0]}'),
              ),
              const SizedBox(height: 16),
            ],
            if (scheduleType == 'Setiap Minggu') ...[
              const Text('Pilih Hari Dalam Minggu:'),
              DropdownButton<int>(
                value: selectedWeekday,
                isExpanded: true,
                items: List.generate(7, (index) {
                  final weekday = DateFormat('EEEE').format(DateTime(2024, 1, 1 + index));
                  return DropdownMenuItem(value: index + 1, child: Text(weekday));
                }),
                onChanged: (val) {
                  if (val != null) {
                    setState(() => selectedWeekday = val);
                  }
                },
              ),
              const SizedBox(height: 16),
            ],
            if (scheduleType == 'Setiap Bulan') ...[
              const Text('Pilih Tanggal Dalam Bulan:'),
              DropdownButton<int>(
                value: selectedDate?.day ?? 1,
                isExpanded: true,
                items: List.generate(31, (i) => DropdownMenuItem(value: i + 1, child: Text('${i + 1}'))),
                onChanged: (val) {
                  if (val != null) {
                    setState(() => selectedDate = DateTime(2024, 1, val));
                  }
                },
              ),
              const SizedBox(height: 16),
            ],
            const Text('Pilih Jam:'),
            SizedBox(
              height: 150,
              child: CupertinoTimerPicker(
                mode: CupertinoTimerPickerMode.hm,
                initialTimerDuration: Duration(
                  hours: selectedTime.hour,
                  minutes: selectedTime.minute,
                ),
                onTimerDurationChanged: (Duration newDuration) {
                  setState(() {
                    selectedTime = TimeOfDay(
                      hour: newDuration.inHours,
                      minute: newDuration.inMinutes % 60,
                    );
                  });
                },
              ),
            ),
            const SizedBox(height: 16),
            Row(
              children: [
                Expanded(
                  child: TextField(
                    decoration: const InputDecoration(
                      labelText: 'Berjalan Selama',
                      border: OutlineInputBorder(),
                    ),
                    keyboardType: TextInputType.number,
                    onChanged: (val) {
                      final intSeconds = int.tryParse(val) ?? 0;
                      setState(() {
                        duration = Duration(seconds: intSeconds);
                      });
                    },
                  ),
                ),
                const SizedBox(width: 8),
                const Text('Detik'),
              ],
            ),
            const SizedBox(height: 16),
            Row(
              children: [
                Checkbox(
                  value: enableMoistureCondition,
                  onChanged: (val) {
                    setState(() => enableMoistureCondition = val!);
                  },
                ),
                const Text('Atau Jika Kelembapan'),
              ],
            ),
            if (enableMoistureCondition) ...[
              Row(
                children: [
                  Expanded(
                    child: DropdownButton<String>(
                      value: moistureOperator,
                      isExpanded: true,
                      items: ['Lebih Besar', 'Lebih Kecil']
                          .map((e) => DropdownMenuItem(value: e, child: Text(e)))
                          .toList(),
                      onChanged: (val) {
                        setState(() => moistureOperator = val!);
                      },
                    ),
                  ),
                  const SizedBox(width: 8),
                  Expanded(
                    child: DropdownButton<int>(
                      value: moistureValue,
                      isExpanded: true,
                      items: List.generate(
                        101,
                        (i) => DropdownMenuItem(value: i, child: Text('$i%')),
                      ),
                      onChanged: (val) {
                        setState(() => moistureValue = val!);
                      },
                    ),
                  ),
                ],
              ),
            ],
            const SizedBox(height: 24),
            ElevatedButton(
              onPressed: _submitSchedule,
              style: ElevatedButton.styleFrom(
                minimumSize: const Size(double.infinity, 50),
                backgroundColor: Colors.black,
                foregroundColor: Colors.white,
              ),
              child: const Text('Simpan'),
            ),
          ],
        ),
      ),
    );
  }
}
