import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class AddSchedulePage extends StatefulWidget {
  const AddSchedulePage({super.key});

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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Tambah Jadwal'),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            DropdownButton<String>(
              value: scheduleType,
              isExpanded: true,
              items: ['Setiap Hari', 'Pilih Tanggal']
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
                          .map((e) =>
                              DropdownMenuItem(value: e, child: Text(e)))
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
              onPressed: () {
              },
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
