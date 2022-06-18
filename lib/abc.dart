// Column(
//               children: [
//                 Row(
//                   children: [Text('aaaa')],
//                 ),
//                 Row(
//                   mainAxisSize: MainAxisSize.max,
//                   mainAxisAlignment: MainAxisAlignment.center,
//                   // crossAxisAlignment: CrossAxisAlignment.center,
//                   children: [
//                     Column(
//                       children: [
//                         Container(
//                           height: 50,
//                           width: 6,
//                           decoration: BoxDecoration(
//                               color: Colors.black,
//                               borderRadius: BorderRadius.only(
//                                   topLeft: Radius.circular(8),
//                                   bottomLeft: Radius.circular(8))),
//                         ),
//                         SizedBox(
//                           height: 230,
//                         ),
//                         Container(
//                           height: 50,
//                           width: 6,
//                           decoration: BoxDecoration(
//                               color: Colors.black,
//                               borderRadius: BorderRadius.only(
//                                   topLeft: Radius.circular(8),
//                                   bottomLeft: Radius.circular(8))),
//                         ),
//                       ],
//                     ),
//                     Container(
//                       width: widthScreen - 35,
//                       height: heightScreen * 0.65,
//                       decoration: BoxDecoration(
//                           border:
//                               Border.all(color: Colors.grey[400], width: 3.5),
//                           borderRadius: BorderRadius.circular(20)),
//                       child: Column(
//                         children: [
//                           SizedBox(
//                             height: 2,
//                           ),
//                           Container(
//                             width: widthScreen - 35 - 20,
//                             height: 20,
//                             decoration: BoxDecoration(
//                                 color: Colors.grey[350],
//                                 borderRadius:
//                                     BorderRadius.all(Radius.circular(30))),
//                             child: Row(
//                               children: [
//                                 SizedBox(
//                                   width: 5,
//                                 ),
//                                 Container(
//                                   height: 15,
//                                   width: 15,
//                                   decoration: BoxDecoration(
//                                       color: Colors.white,
//                                       borderRadius: BorderRadius.all(
//                                           Radius.circular(20))),
//                                 ),
//                                 SizedBox(
//                                   width: 5,
//                                 ),
//                                 Container(
//                                     height: 15,
//                                     width: 20,
//                                     decoration: BoxDecoration(
//                                         color: Colors.white,
//                                         borderRadius: BorderRadius.only(
//                                             topLeft: Radius.circular(10),
//                                             topRight: Radius.circular(10)))),
//                                 SizedBox(
//                                   width: 5,
//                                 ),
//                                 Container(
//                                   height: 15,
//                                   width: 15,
//                                   decoration: BoxDecoration(
//                                       color: Colors.white,
//                                       borderRadius: BorderRadius.all(
//                                           Radius.circular(20))),
//                                 ),
//                                 SizedBox(
//                                   width: 20,
//                                 ),
//                                 Container(
//                                     height: 13,
//                                     width: 20,
//                                     decoration: BoxDecoration(
//                                       color: Colors.white,
//                                     )),
//                               ],
//                             ),
//                           ),
//                           SizedBox(
//                             height: 0,
//                           ),
//                           Row(
//                             children: [
//                               SizedBox(
//                                 width: 10,
//                               ),
//                               Stack(
//                                 children: [
//                                   Column(
//                                     children: [
//                                       SizedBox(
//                                         height: 15,
//                                       ),
//                                       seatItem('LX',(){
//                                           setState(() {
//                                             flag== !flag;
//                                           });
//                                       },flag),
//                                     ],
//                                   ),
//                                   Positioned(
//                                       bottom: 35,
//                                       left: 12,
//                                       child: Image.asset(
//                                         'asset/images/volant.png',
//                                         width: 20,
//                                         height: 20,
//                                       ))
//                                 ],
//                               ),
//                               SizedBox(
//                                 width: 150,
//                               ),
//                               seatItem('17',(){
//                                           setState(() {
//                                             flag= !flag;
//                                           });
//                                       },flag),
//                               SizedBox(
//                                 width: spacebetween,
//                               ),
//                               seatItem('23',(){
//                                           setState(() {
//                                             flag== !flag;
//                                           });
//                                       },flag)
//                             ],
//                           ),
//                           SizedBox(
//                             height: spaceRow,
//                           ),
//                           Row(
//                             children: [
//                               SizedBox(
//                                 width: 10,
//                               ),
//                               seatItem('2',(){
//                                           setState(() {
//                                             flag== !flag;
//                                           });
//                                       },flag),
//                               SizedBox(
//                                 width: spacebetween,
//                               ),
//                               seatItem('9',(){
//                                           setState(() {
//                                             flag== !flag;
//                                           });
//                                       },flag),
//                               SizedBox(
//                                 width: 150,
//                               ),
//                               seatItem('24',(){
//                                           setState(() {
//                                             flag== !flag;
//                                           });
//                                       },flag)
//                             ],
//                           ),
//                           SizedBox(
//                             height: spaceRow,
//                           ),
//                           Row(
//                             children: [
//                               SizedBox(
//                                 width: 10,
//                               ),
//                               seatItem('3',(){
//                                           setState(() {
//                                             flag== !flag;
//                                           });
//                                       },flag),
//                               SizedBox(
//                                 width: spacebetween,
//                               ),
//                               seatItem('10',(){
//                                           setState(() {
//                                             flag== !flag;
//                                           });
//                                       },flag),
//                             ],
//                           ),
//                           SizedBox(
//                             height: spaceRow,
//                           ),
//                           Row(
//                             children: [
//                               SizedBox(
//                                 width: 10,
//                               ),
//                               seatItem('4',(){
//                                           setState(() {
//                                             flag== !flag;
//                                           });
//                                       },flag),
//                               SizedBox(
//                                 width: spacebetween,
//                               ),
//                               seatItem('11',(){
//                                           setState(() {
//                                             flag== !flag;
//                                           });
//                                       },flag),
//                               SizedBox(
//                                 width: 85,
//                               ),
//                               seatItem('18',(){
//                                           setState(() {
//                                             flag== !flag;
//                                           });
//                                       },flag),
//                               SizedBox(
//                                 width: spacebetween,
//                               ),
//                               seatItem('25',(){
//                                           setState(() {
//                                             flag== !flag;
//                                           });
//                                       },flag)
//                             ],
//                           ),
//                           SizedBox(
//                             height: spaceRow,
//                           ),
//                           Row(
//                             children: [
//                               SizedBox(
//                                 width: 10,
//                               ),
//                               seatItem('5',(){
//                                           setState(() {
//                                             flag== !flag;
//                                           });
//                                       },flag),
//                               SizedBox(
//                                 width: spacebetween,
//                               ),
//                               seatItem('12',(){
//                                           setState(() {
//                                             flag== !flag;
//                                           });
//                                       },flag),
//                               SizedBox(
//                                 width: 85,
//                               ),
//                               seatItem('19',(){
//                                           setState(() {
//                                             flag== !flag;
//                                           });
//                                       },flag),
//                               SizedBox(
//                                 width: spacebetween,
//                               ),
//                               seatItem('26',(){
//                                           setState(() {
//                                             flag== !flag;
//                                           });
//                                       },flag)
//                             ],
//                           ),
//                           SizedBox(
//                             height: spaceRow,
//                           ),
//                           Row(
//                             children: [
//                               SizedBox(
//                                 width: 10,
//                               ),
//                               seatItem('6',(){
//                                           setState(() {
//                                             flag== !flag;
//                                           });
//                                       },flag),
//                               SizedBox(
//                                 width: spacebetween,
//                               ),
//                               seatItem('13',(){
//                                           setState(() {
//                                             flag== !flag;
//                                           });
//                                       },flag),
//                               SizedBox(
//                                 width: 85,
//                               ),
//                               seatItem('20',(){
//                                           setState(() {
//                                             flag== !flag;
//                                           });
//                                       },flag),
//                               SizedBox(
//                                 width: spacebetween,
//                               ),
//                               seatItem('27',(){
//                                           setState(() {
//                                             flag== !flag;
//                                           });
//                                       },flag)
//                             ],
//                           ),
//                           SizedBox(
//                             height: spaceRow,
//                           ),
//                           Row(
//                             children: [
//                               SizedBox(
//                                 width: 10,
//                               ),
//                               seatItem('7',(){
//                                           setState(() {
//                                             flag== !flag;
//                                           });
//                                       },flag),
//                               SizedBox(
//                                 width: spacebetween,
//                               ),
//                               seatItem('14',(){
//                                           setState(() {
//                                             flag== !flag;
//                                           });
//                                       },flag),
//                               SizedBox(
//                                 width: 85,
//                               ),
//                               seatItem('21',(){
//                                           setState(() {
//                                             flag== !flag;
//                                           });
//                                       },flag),
//                               SizedBox(
//                                 width: spacebetween,
//                               ),
//                               seatItem('28',(){
//                                           setState(() {
//                                             flag== !flag;
//                                           });
//                                       },flag)
//                             ],
//                           ),
//                           SizedBox(
//                             height: spaceRow,
//                           ),
//                           Row(
//                             children: [
//                               SizedBox(
//                                 width: 10,
//                               ),
//                               seatItem('8',(){
//                                           setState(() {
//                                             flag== !flag;
//                                           });
//                                       },flag),
//                               SizedBox(
//                                 width: spacebetween,
//                               ),
//                               seatItem('15',(){
//                                           setState(() {
//                                             flag== !flag;
//                                           });
//                                       },flag),
//                               SizedBox(
//                                 width: spacebetween,
//                               ),
//                               seatItem('16',(){
//                                           setState(() {
//                                             flag== !flag;
//                                           });
//                                       },flag),
//                               SizedBox(
//                                 width: spacebetween,
//                               ),
//                               seatItem('22',(){
//                                           setState(() {
//                                             flag== !flag;
//                                           });
//                                       },flag),
//                               SizedBox(
//                                 width: spacebetween,
//                               ),
//                               seatItem('29',(){
//                                           setState(() {
//                                             flag== !flag;
//                                           });
//                                       },flag)
//                             ],
//                           ),
//                         ],
//                       ),
//                     ),
//                     Column(
//                       children: [
//                         Container(
//                           height: 50,
//                           width: 6,
//                           decoration: BoxDecoration(
//                               color: Colors.black,
//                               borderRadius: BorderRadius.only(
//                                   topRight: Radius.circular(8),
//                                   bottomRight: Radius.circular(8))),
//                         ),
//                         SizedBox(
//                           height: 230,
//                         ),
//                         Container(
//                           height: 50,
//                           width: 6,
//                           decoration: BoxDecoration(
//                               color: Colors.black,
//                               borderRadius: BorderRadius.only(
//                                   topRight: Radius.circular(8),
//                                   bottomRight: Radius.circular(8))),
//                         ),
//                       ],
//                     ),
//                   ],
//                 )
//               ],
//             )