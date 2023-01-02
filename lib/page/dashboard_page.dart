import 'package:flutter/material.dart';
import 'package:train_dashboard/data/mqtt_module.dart';
import 'package:train_dashboard/model/jadwal_kereta.dart';

class DashboardPage extends StatefulWidget {
  const DashboardPage({Key? key}) : super(key: key);

  @override
  State<DashboardPage> createState() => _DashboardPageState();
}

class _DashboardPageState extends State<DashboardPage> {
  late MqttModule _mqttModule;
  List<JadwalKereta> _listJadwal = [];

  @override
  void initState() {
    super.initState();
    _mqttModule = MqttModule();
    _initialize();
  }

  void _initialize() async {
    await _mqttModule.connect();
    _mqttModule.messages.stream.listen((event) {
      if (_listJadwal.any((element) => element.id == event.id)) {
        setState(() {
          var idx = _listJadwal.indexWhere((element) => element.id == event.id);
          _listJadwal[idx] = event;
        });
      } else {
        setState(() {
          _listJadwal.add(event);
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Dashboard Kereta Api"),
        centerTitle: true,
      ),
      body: Column(
        children: [
          const ScheduleHeader(),
          ListView.builder(
            physics: const NeverScrollableScrollPhysics(),
            itemCount: _listJadwal.length,
            shrinkWrap: true,
            itemBuilder: (context, index) => ScheduleListItem(
              jadwal: _listJadwal[index],
            ),
          ),
        ],
      ),
    );
  }
}

class ScheduleHeader extends StatelessWidget {
  const ScheduleHeader({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 70,
      decoration: const BoxDecoration(
        color: Colors.blueAccent,
      ),
      child: Row(
        children: const [
          Expanded(
            flex: 1,
            child: Text(
              "Nama Kereta",
              textAlign: TextAlign.center,
              style: TextStyle(
                  fontWeight: FontWeight.bold, color: Colors.yellowAccent),
            ),
          ),
          Expanded(
            flex: 1,
            child: Text(
              "Destinasi",
              textAlign: TextAlign.center,
              style: TextStyle(
                  fontWeight: FontWeight.bold, color: Colors.yellowAccent),
            ),
          ),
          Expanded(
            flex: 1,
            child: Text(
              "Waktu Keberangkatan",
              textAlign: TextAlign.center,
              style: TextStyle(
                  fontWeight: FontWeight.bold, color: Colors.yellowAccent),
            ),
          ),
          Expanded(
            flex: 1,
            child: Text(
              "Posisi Terakhir",
              textAlign: TextAlign.center,
              style: TextStyle(
                  fontWeight: FontWeight.bold, color: Colors.yellowAccent),
            ),
          ),
          Expanded(
            flex: 1,
            child: Text(
              "Estimasi Kedatangan",
              textAlign: TextAlign.center,
              style: TextStyle(
                  fontWeight: FontWeight.bold, color: Colors.yellowAccent),
            ),
          )
        ],
      ),
    );
  }
}

class ScheduleListItem extends StatelessWidget {
  const ScheduleListItem({
    required this.jadwal,
    Key? key,
  }) : super(key: key);

  final JadwalKereta jadwal;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 70,
      child: Row(
        children: [
          Expanded(
            flex: 1,
            child: Text(
              jadwal.namaKereta,
              textAlign: TextAlign.center,
              style: const TextStyle(
                color: Colors.white,
              ),
            ),
          ),
          Expanded(
            flex: 1,
            child: Text(
              jadwal.destinasi,
              textAlign: TextAlign.center,
              style: const TextStyle(color: Colors.white),
            ),
          ),
          Expanded(
            flex: 1,
            child: Text(
              jadwal.waktuKeberangkatan,
              textAlign: TextAlign.center,
              style: const TextStyle(color: Colors.white),
            ),
          ),
          Expanded(
            flex: 1,
            child: Text(
              jadwal.posisiTerakhir,
              textAlign: TextAlign.center,
              style: const TextStyle(color: Colors.white),
            ),
          ),
          Expanded(
            flex: 1,
            child: Text(
              jadwal.estimasiKedatangan,
              textAlign: TextAlign.center,
              style: const TextStyle(
                color: Colors.white,
              ),
            ),
          )
        ],
      ),
    );
  }
}
