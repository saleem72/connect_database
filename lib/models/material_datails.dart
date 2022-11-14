// ignore_for_file: public_member_api_docs, sort_constructors_first
//

/*
  "select 
  mm.code as code,
  mm.Name as name ,
  mm.enduser a,
  mm.unity as unit1 , 
  mm.unit2 as unit2 , 
  mm.enduser2 as enduser2, 

  bb.barcode as barcode , 
  bb.matunit as unit , 
  st.name as st_name ,
  bm.name as bm_name 
  from mt000 mm inner join MatExBarcode000 bb on mm.guid=bb.Matguid inner join ms000 ms on ms.matguid=mm.guid inner join st000 st on st.guid=ms.StoreGUID left join bm000 bm on bm.guid=mm.PictureGUID where bb.BarCode='1002002'";

*/

import 'dart:convert';

class MaterialDetails {
  final String code;
  final String name;
  final String enduser;
  final String unity;
  final String unit2;
  final String enduser2;
  final String barcode;
  final String matunit;
  final String storeName;
  final String image;
  MaterialDetails({
    required this.code,
    required this.name,
    required this.enduser,
    required this.unity,
    required this.unit2,
    required this.enduser2,
    required this.barcode,
    required this.matunit,
    required this.storeName,
    required this.image,
  });

  Map<String, String> toMap() {
    return <String, String>{
      'code': code,
      'name': name,
      'enduser': enduser,
      'unity': unity,
      'unit2': unit2,
      'enduser2': enduser2,
      'barcode': barcode,
      'matunit': matunit,
      'stName': storeName,
      'bmName': image,
    };
  }

  factory MaterialDetails.fromMap(Map<String, String> map) {
    /*
      mm.code as code,
  mm.Name as name ,
  mm.enduser a,
  mm.unity as unit1 , 
  mm.unit2 as unit2 , 
  mm.enduser2 as enduser2, 

  bb.barcode as barcode , 
  bb.matunit as unit , 
  st.name as st_name ,
  bm.name as bm_name 
    */
    return MaterialDetails(
      code: map['code'] ?? '',
      name: map['name'] ?? '',
      enduser: map['a'] ?? '',
      unity: map['unit1'] ?? '',
      unit2: map['unit2'] ?? '',
      enduser2: map['enduser2'] ?? '',
      barcode: map['barcode'] ?? '',
      matunit: map['matunit'] ?? '',
      storeName: map['st_name'] ?? '',
      image: map['bm_name'] ?? '',
    );
  }

  String toJson() => json.encode(toMap());

  factory MaterialDetails.fromJson(String source) =>
      MaterialDetails.fromMap(json.decode(source) as Map<String, String>);

  @override
  String toString() {
    return 'MaterialDetails(code: $code, name: $name, enduser: $enduser, unity: $unity, unit2: $unit2, enduser2: $enduser2, stName: $storeName, bmName: $image)';
  }
}
