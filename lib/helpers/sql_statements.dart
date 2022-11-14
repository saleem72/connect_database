//

class SQLStatements {
  SQLStatements._();

  static const String barcodeExample =
      "select mm.code as code,mm.Name as name ,mm.enduser a,mm.unity as unit1 , mm.unit2 as unit2 , mm.enduser2 as enduser2, bb.barcode as barcode , bb.matunit as unit , st.name as st_name ,bm.name as bm_name from mt000 mm inner join MatExBarcode000 bb on mm.guid=bb.Matguid inner join ms000 ms on ms.matguid=mm.guid inner join st000 st on st.guid=ms.StoreGUID left join bm000 bm on bm.guid=mm.PictureGUID where bb.BarCode='1002002'";

  static String statementForBarcode(String barcode) =>
      "select mm.code as code,mm.Name as name ,mm.enduser a,mm.unity as unit1 , mm.unit2 as unit2 , mm.enduser2 as enduser2, bb.barcode as barcode , bb.matunit as unit , st.name as st_name ,bm.name as bm_name from mt000 mm inner join MatExBarcode000 bb on mm.guid=bb.Matguid inner join ms000 ms on ms.matguid=mm.guid inner join st000 st on st.guid=ms.StoreGUID left join bm000 bm on bm.guid=mm.PictureGUID where bb.BarCode='$barcode'";
}
