import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:mask/ui/widget/remain_stat_list_tile.dart';
import 'package:mask/viewmodel/store_model.dart';
import 'package:provider/provider.dart';

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  //var isLoading = false;
  //fianl stores = List<Store>();
  //var stores = List<Store>(); 둘다 같은것
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final storeModel = Provider.of<StoreModel>(context);
    return Scaffold(
      appBar: AppBar(
        title: Text('마스크 재고 있는 곳 : ${storeModel.stores.length}곳'),
        actions: <Widget>[
          IconButton(
              icon: Icon(Icons.refresh),
              onPressed: (){
                storeModel.fetch();
              })
        ],
      ),
      body: storeModel.isLoading == false
          ? loadingWidget()
          : ListView(
        children: storeModel.stores.map((e) {
          return RemainStatListTile(e);
        }).toList(),
      ),
      drawer: Drawer(
        child: ListView(
          children: [
            DrawerHeader(child: Text('1`23')),
            ListTile(
              leading: Text('leading'),
              title: Text('title'),
              subtitle: Text('subtitle'),
              trailing: Text('traling'),
            ),

          ],

        ),
      ),
    );
  }



  Widget loadingWidget(){
    return Center(
        child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Text('정보를 가져오는중'),
              CircularProgressIndicator(

              ),

            ]
        )
    );
  }
}