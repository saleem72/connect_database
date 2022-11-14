//

// ignore_for_file: depend_on_referenced_packages

import 'dart:ui';

import 'package:connect_database/connection_manager/connection_manager_bloc/connection_manager_bloc.dart';
import 'package:connect_database/helpers/routing/nav_links.dart';
import 'package:connect_database/helpers/routing/route_generator.dart';
import 'package:connect_database/helpers/styling/pallet.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'connection_manager/connection_manager.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  DartPluginRegistrant.ensureInitialized();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => ConnectionManagerBloc(
        host: 'epsilondemo.dyndns.org',
        port: '1433',
        database: 'amndbtest1',
        username: 'sa',
        password: 'H123456789h',
        query:
            "select mm.code as code,mm.Name as name ,mm.enduser a,mm.unity as unit1 , mm.unit2 as unit2 , mm.enduser2 as enduser2, bb.barcode as barcode , bb.matunit as unit , st.name as st_name ,bm.name as bm_name from mt000 mm inner join MatExBarcode000 bb on mm.guid=bb.Matguid inner join ms000 ms on ms.matguid=mm.guid inner join st000 st on st.guid=ms.StoreGUID left join bm000 bm on bm.guid=mm.PictureGUID where bb.BarCode='1002002'",
        connectionManager: ConnectionManager(),
      ),
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Flutter Demo',
        theme: ThemeData(
            primarySwatch: Pallet.appBarSwatch,
            scaffoldBackgroundColor: Pallet.background // Colors.blue,
            ),
        onGenerateRoute: RouteGenerator.generate,
        initialRoute: Navlinks.initial,
      ),
    );
  }
}
