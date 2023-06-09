import 'package:flutter/material.dart';

import '../screens/screens.dart';
import 'main_appbar.dart';

class TabViewController extends StatelessWidget {
  const TabViewController({super.key});

  @override
  Widget build(BuildContext context) {
    return const DefaultTabController(
      initialIndex: 0,
      length: 3,
      child: Scaffold(
        appBar: MainAppBar(),
        body: TabBarView(
          children: [
            // Column(
            //   children: [
            //     Expanded(
            //       flex: 2,
            //       child: Padding(
            //         padding: EdgeInsets.all(8),
            //         child: Column(
            //           mainAxisAlignment: MainAxisAlignment.end,
            //           crossAxisAlignment: CrossAxisAlignment.end,
            //           children: [
            //             TextField(
            //               // controller: textEditingController,
            //               keyboardType: TextInputType.none,
            //               textAlign: TextAlign.right,
            //               style: TextStyle(),
            //               decoration: InputDecoration(
            //                 border: InputBorder.none,
            //               ),
            //             ),
            //             Text("result"),
            //           ],
            //         ),
            //       ),
            //     ),
            //     Expanded(
            //       flex: 3,
            //       child: Keypad(),
            //     )
            //   ],
            // ),
            CalculatorScreen(),
            ExchangeRateScreen(),
            UnitConverterScreen(),
          ],
        ),
      ),
    );
  }
}
