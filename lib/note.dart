//  FutureBuilder<DSHanhKhachMuaVe>(
//                                   future: DshanhkhachmuaveFuture,
//                                   builder: (context, snapshot) {
//                                     if (snapshot.connectionState ==
//                                         ConnectionState.waiting) {
//                                       return Center(
//                                         child: CircularProgressIndicator(),
//                                       );
//                                     }
//                                     if (snapshot.hasData) {
//                                       DSHanhKhachMuaVe dshanhkhachmuave =
//                                           snapshot.data;
//                                       listCheck = dshanhkhachmuave.data;
//                                       if (listCheck.length == 0) {
//                                         return Center(
//                                           child: Text('Không có dữ liệu'),
//                                         );
//                                       }
//                                       return Expanded(
//                                         child: ListView(
//                                           children: [
//                                             Column(
//                                               children: [
//                                                 Row(
//                                                   children: [
//                                                     Checkbox(
//                                                         value: AllChecked,
//                                                         onChanged:
//                                                             setAllChecked),
//                                                     Text(
//                                                         'Tất cả(${listCheck.length})')
//                                                   ],
//                                                 ),
//                                                 Container(
//                                                     width:
//                                                         MediaQuery.of(context)
//                                                                 .size
//                                                                 .width *
//                                                             0.7,
//                                                     child: Divider(
//                                                       color: Colors.black,
//                                                     ))
//                                               ],
//                                             ),
//                                             ...listCheck
//                                                 .map(itemChuyenDoiLenh)
//                                                 .toList()
//                                           ],
//                                         ),
//                                       );
//                                     }
//                                     if (snapshot.hasError) {
//                                       return Center(
//                                         child: Text('Lỗi'),
//                                       );
//                                     }
//                                     return Center(
//                                       child: Text('Không có dữ liệu'),
//                                     );
//                                   }),