import 'package:infinite_escrow/core/http.dart';
import 'package:infinite_escrow/core/models/escrow_category.dart';
import 'package:infinite_escrow/routes/routes.dart';

Future<dynamic> customCurrencyBottomSheetForEscrow(
    BuildContext context, RxString coin, String title, Function onChange) {
  var http = HttpRequest();

  Iterable<EscrowCategoryModel> data = http.getEscrowCatagory();

  return showModalBottomSheet(
      isScrollControlled: true,
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.only(
              topRight: Radius.circular(30), topLeft: Radius.circular(30))),
      context: context,
      builder: (context) {
        var filter = '';
        return StatefulBuilder(
          builder: (context, setState) {
            if(filter != ''){
              data = data.where((element) => element.name.contains(filter));
            }
            return Container(
              height: 540,
              padding: EdgeInsets.all(15),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Center(
                    child: Text(title,
                        style: TextStyle(
                            color: ColorConstant.midNight,
                            fontWeight: FontWeight.w600,
                            fontSize: 15)),
                  ),
                  SizedBox(height: 20),
                  TextField(
                    cursorColor: Colors.green,
                    onChanged: (e){
                      // onfilter(e);
                      setState(()=>filter = e);
                    },
                    decoration:  InputDecoration(
                      hintText: 'Search',
                      enabledBorder: UnderlineInputBorder(
                        borderSide: BorderSide(color: Colors.green)
                      )
                    ),
                  ),
                  SizedBox(height: 10,),
                  Expanded(
                      child: SingleChildScrollView(
                    child: Column(
                      children: [
                        for (var i in data)
                          customRadioButtonForEscrow(
                            change: (e) {
                              onChange(e, i.name);
                            },
                            coin: coin,
                            typeName: i.name,
                            value: i.id.toString(),
                          ),
                      ],
                    ),
                  ))
                ],
              ),
            );
          }
        );
      });
}
