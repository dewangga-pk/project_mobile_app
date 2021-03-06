import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:feis_mobile/bps/layouts/appBar.dart';
import 'package:feis_mobile/bps/layouts/background.dart';
import 'package:feis_mobile/database_services.dart';
import 'package:flutter/material.dart';

class BPSPendudukField extends StatefulWidget {
  final DocumentSnapshot snapshot;
  const BPSPendudukField(this.snapshot);
  @override
  _BPSPendudukFieldState createState() => _BPSPendudukFieldState();
}

class _BPSPendudukFieldState extends State<BPSPendudukField> {
  TextEditingController cityController = new TextEditingController();
  TextEditingController populationController = new TextEditingController();
  TextEditingController yearsController = new TextEditingController();
  @override
  void initState() {
    cityController.text = widget.snapshot['name'];
    populationController.text = widget.snapshot['population'].toString();
    yearsController.text = widget.snapshot['years'].toString();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: BPSAppBar().buildAppBar(context),
      body: Stack(
        children: [
          Background().buildBackground(context),
          Container(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  padding: EdgeInsets.all(10),
                  decoration: BoxDecoration(
                      gradient: LinearGradient(
                    begin: Alignment.bottomCenter,
                    end: Alignment.topCenter,
                    colors: [Color(0xff2196F3), Color(0xff014E6B)],
                  )),
                  width: 145,
                  height: 40,
                  child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: <Widget>[
                        Image(
                          image: AssetImage('images/penduduk.png'),
                          width: 20,
                          height: 20,
                        ),
                        Text(
                          'Penduduk',
                          style: TextStyle(color: Colors.white),
                        )
                      ]),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Container(
                      margin: EdgeInsets.only(top: 10),
                      padding: EdgeInsets.fromLTRB(10, 16, 10, 16),
                      width: 250,
                      height: 48,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        color: Color.fromRGBO(255, 255, 255, 0.65),
                      ),
                      child: Text(
                        "Data Penduduk Jawa Timur",
                        style: TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 16),
                        textAlign: TextAlign.center,
                      ),
                    ),
                  ],
                ),
                Center(
                  child: Container(
                    width: MediaQuery.of(context).size.width / 1.1,
                    height: MediaQuery.of(context).size.height / 2.2,
                    margin: EdgeInsets.only(top: 30),
                    padding: EdgeInsets.only(left: 10, right: 10),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(5),
                      color: Color.fromRGBO(208, 208, 208, 0.9),
                      border: Border.all(color: Colors.grey[100]),
                    ),
                    child: Column(
                      children: [
                        Center(
                          child: Container(
                            margin: EdgeInsets.fromLTRB(0, 10, 0, 5),
                            child: Text("Ubah Data Penduduk",
                                style: TextStyle(fontWeight: FontWeight.bold),
                                textAlign: TextAlign.center),
                          ),
                        ),
                        TextField(
                          readOnly: true,
                          controller: cityController,
                          decoration: InputDecoration(
                            icon: Icon(Icons.location_city),
                            labelText: "Kabupaten / Kota",
                          ),
                        ),
                        TextField(
                          controller: populationController,
                          decoration: InputDecoration(
                            icon: Icon(Icons.people),
                            labelText: "Jumlah Penduduk",
                          ),
                        ),
                        TextField(
                          controller: yearsController,
                          decoration: InputDecoration(
                            icon: Icon(Icons.date_range),
                            labelText: "Tahun",
                          ),
                        ),
                        Container(
                          margin: EdgeInsets.only(top: 20, left: 10, right: 10),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              RaisedButton(
                                onPressed: () {
                                  Navigator.pop(context);
                                },
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(20),
                                ),
                                color: Color(0xffD8544F),
                                child: Text(
                                  "Batal",
                                  style: TextStyle(color: Colors.white),
                                ),
                              ),
                              RaisedButton(
                                onPressed: () async {
                                  await DatabaseServices.createOrUpdateCity(
                                      widget.snapshot.id,
                                      name: widget.snapshot['name'],
                                      population:
                                          int.parse(populationController.text),
                                      years: int.parse(yearsController.text));
                                  Navigator.pop(context);
                                },
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(20),
                                ),
                                color: Color(0xff3F936D),
                                child: Text(
                                  "Simpan",
                                  style: TextStyle(color: Colors.white),
                                ),
                              ),
                            ],
                          ),
                        )
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
