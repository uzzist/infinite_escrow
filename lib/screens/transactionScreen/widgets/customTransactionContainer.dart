import 'package:infinite_escrow/routes/routes.dart';
import 'package:timeago/timeago.dart' as timeago;

InkWell customTransactionContainer({
  required var price,
  // required Color containerColor,
  // required var containerTitle,
  required var title,
  required var currencyName,
  required id,
  // required DateTime date,
  required var trx,
  required var profit,
  required var trxType,
  required var trxColor,
  required var details,
  required var remainingBalance,
}) {
  return InkWell(
    onTap: () {
      // navigateToPage(EscrowDetailScreen(
      //   id: id,
      // ));
    },
    child: Container(
      height: 100,
      padding: EdgeInsets.all(10),
      decoration: BoxDecoration(color: ColorConstant.white, boxShadow: [
        BoxShadow(
          color: ColorConstant.black.withOpacity(0.1),
          spreadRadius: 0,
          blurRadius: 14,
          offset: Offset(0, 5), // changes position of shadow
        ),
      ]),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [Text(trx,style: TextStyle(
            color: ColorConstant.midNight,
            fontSize: 10,
            fontWeight: FontWeight.w600),),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  Text(
                    price,
                    style: TextStyle(
                        color: ColorConstant.midNight,
                        fontSize: 20,
                        fontWeight: FontWeight.w600),
                  ),
                  SizedBox(
                    width: 5,
                  ),
                  Text(
                    currencyName,
                    style: TextStyle(
                        color: ColorConstant.darkestGrey,
                        fontSize: 12,
                        fontWeight: FontWeight.w600),
                  ),
                ],
              ),
              Row(
                children: [

                  Text(
                    "Current Wallet Balance",
                    style: TextStyle(
                        color: ColorConstant.darkestGrey,
                        fontSize: 12,
                        fontWeight: FontWeight.w600),
                  ),
                ],
              )
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  Text(
                    trxType,
                    style: TextStyle(
                        color: trxColor,
                        fontSize: 12,
                        fontWeight: FontWeight.w600),
                  ),
                  SizedBox(
                    width: 5,
                  ),
                  Text(
                    title,
                    style: TextStyle(
                        color: trxColor,
                        fontSize: 12,
                        fontWeight: FontWeight.w600),
                  ),
                  SizedBox(
                    width: 5,
                  ),
                  Text(
                    '${double.parse(profit).toStringAsFixed(0)}',
                    style: TextStyle(
                        color: trxColor,
                        fontSize: 12,
                        fontWeight: FontWeight.w600),
                  ),
                  // Container(
                  //   padding: EdgeInsets.symmetric(horizontal: 8),
                  //   height: 24,
                  //   color: containerColor,
                  //   child: Center(
                  //     child: Text(
                  //       containerTitle,
                  //       style: TextStyle(
                  //           color: ColorConstant.midNight,
                  //           fontSize: 11,
                  //           fontWeight: FontWeight.w500),
                  //     ),
                  //   ),
                  // )
                ],
              ),
              Row(
                children: [
                  Text(
                details,
                    style: TextStyle(
                        color: ColorConstant.darkestGrey,
                        fontSize: 12,
                        fontWeight: FontWeight.w600),
                  ),
                  SizedBox(
                    width: 5,
                  ),

                ],
              )
            ],
          ),
          Row(children:[
            Text(
              remainingBalance,
              style: TextStyle(
                  color: ColorConstant.darkestGrey,
                  fontSize: 12,
                  fontWeight: FontWeight.w600),
            ),
            Spacer(),
            Text(
              "Remaining Wallet Balance",
              style: TextStyle(
                  color: ColorConstant.darkestGrey,
                  fontSize: 12,
                  fontWeight: FontWeight.w600),
            ),
          ])

        ],
      ),
    ),
  );
}
