import 'package:flutter/material.dart';
import 'package:siram_pintar_mobile/pages/plant_detail/add_schedule_page.dart';
import 'package:siram_pintar_mobile/repositories/schedule_repository.dart';

class AutomationSchedulePage extends StatefulWidget {
  final String deviceName;
  final int deviceId;
  final int plantId;

  const AutomationSchedulePage({
    super.key,
    required this.deviceName,
    required this.deviceId,
    required this.plantId,
  });

  @override
  State<AutomationSchedulePage> createState() => _AutomationSchedulePageState();
}

class _AutomationSchedulePageState extends State<AutomationSchedulePage> {
  final ScheduleRepository _repository = ScheduleRepository();
  List<Map<String, dynamic>> _schedules = [];
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    _loadSchedules();
  }

  Future<void> _loadSchedules() async {
    try {
      final data = await _repository.getSchedulesByDeviceId(widget.deviceId);
      setState(() {
        _schedules = data;
        _isLoading = false;
      });
    } catch (e) {
      debugPrint('Error fetching schedules: $e');
      setState(() {
        _isLoading = false;
      });
    }
  }

  Future<void> _deleteSchedule(int scheduleId) async {
    final confirmed = await showDialog<bool>(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Konfirmasi'),
        content: const Text('Apakah Anda yakin ingin menghapus jadwal ini?'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context, false),
            child: const Text('Batal'),
          ),
          ElevatedButton(
            onPressed: () => Navigator.pop(context, true),
            child: const Text('Hapus'),
          ),
        ],
      ),
    );

    if (confirmed == true) {
      try {
        await _repository.deleteSchedule(scheduleId);
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Jadwal berhasil dihapus')),
        );
        await _loadSchedules(); // refresh data setelah hapus
      } catch (e) {
        debugPrint('Error deleting schedule: $e');
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Gagal menghapus jadwal')),
        );
      }
    }
  }

  String formatDuration(int seconds) {
    return '$seconds detik';
  }

  String getScheduleDescription(Map<String, dynamic> item) {
    final frequency = item['frequency'];
    final time = item['watering_time'];
    final dayOfWeek = item['day_of_week'];
    final dayOfMonth = item['day_of_month'];
    final onceOnDate = item['once_on_date'];
    final moistureThreshold = item['moisture_threshold'];

    // Format waktu
    final parts = time.split(':');
    final hourMinute = '${parts[0]}:${parts[1]}';

    // Deskripsi hari/frekuensi
    String dayInfo = '';
    if (frequency == 'daily') {
      dayInfo = 'Setiap hari';
    } else if (frequency == 'weekly' && dayOfWeek != null) {
      const days = ['Minggu', 'Senin', 'Selasa', 'Rabu', 'Kamis', 'Jumat', 'Sabtu'];
      final dayNum = int.tryParse(dayOfWeek.toString()) ?? 0;
      final dayName = days[dayNum % 7];
      dayInfo = 'Setiap minggu di hari $dayName';
    } else if (frequency == 'monthly' && dayOfMonth != null) {
      dayInfo = 'Setiap tanggal $dayOfMonth';
    } else if (frequency == 'once' && onceOnDate != null) {
      final date = DateTime.tryParse(onceOnDate);
      if (date != null) {
        dayInfo = 'Sekali pada ${date.day}-${date.month}-${date.year}';
      }
    }

    // Deskripsi kelembapan
    String moistureInfo = '';
    if (moistureThreshold != null) {
      moistureInfo = ' (jika kelembapan < $moistureThreshold%)';
    }

    return '$dayInfo, jam $hourMinute$moistureInfo';
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.deviceName),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            Center(
              child: ElevatedButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => AddSchedulePage(
                        plantId: widget.plantId,
                        deviceId: widget.deviceId,
                      ),
                    ),
                  ).then((_) => _loadSchedules()); 
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.white,
                  foregroundColor: Colors.black,
                  side: const BorderSide(color: Colors.black),
                ),
                child: const Text('Tambah Jadwal'),
              ),
            ),
            const SizedBox(height: 16),
            Expanded(
              child: _isLoading
                  ? const Center(child: CircularProgressIndicator())
                  : _schedules.isEmpty
                      ? const Center(child: Text('Belum ada jadwal'))
                      : Container(
                          decoration: BoxDecoration(
                            border: Border.all(color: Colors.black),
                            borderRadius: BorderRadius.circular(8),
                          ),
                          child: ListView.separated(
                            itemCount: _schedules.length,
                            separatorBuilder: (context, index) => const Divider(height: 1),
                            itemBuilder: (context, index) {
                              final item = _schedules[index];
                              return ListTile(
                                title: Text(
                                  getScheduleDescription(item),
                                  style: const TextStyle(fontWeight: FontWeight.bold),
                                ),
                                subtitle: Text('Durasi: ${formatDuration(item['duration'])}'),
                                leading: const SizedBox(width: 1),
                                trailing: Row(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    IconButton(
                                      icon: const Icon(Icons.close),
                                      onPressed: () {
                                        final scheduleId = item['id'];
                                        _deleteSchedule(scheduleId);
                                      },
                                    ),
                                    IconButton(
                                      icon: const Icon(Icons.chevron_right),
                                      onPressed: () {
                                        // TODO: Navigasi ke detail atau edit jadwal
                                      },
                                    ),
                                  ],
                                ),
                              );
                            },
                          ),
                        ),
            ),
          ],
        ),
      ),
    );
  }
}
