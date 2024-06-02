import 'package:flutter/material.dart';

class customS extends StatefulWidget {
  const customS({super.key});

  @override
  State<customS> createState() => _customSState();
}

class _customSState extends State<customS> {
  final ScrollController scrollController = ScrollController();
  double _saveScrollPo = 0.0;

  @override
  void initState() {
    super.initState();
    scrollController.addListener(() {
      setState(() {
        _saveScrollPo = scrollController.position.pixels;
      });
    });
  }

  @override
  void dispose() {
    scrollController.dispose();
    super.dispose();
  }

  void _restoreScrollPosition() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (scrollController.hasClients) {
        scrollController.jumpTo(_saveScrollPo);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return CustomScrollView(
      controller: scrollController,
      physics: BouncingScrollPhysics(),
      slivers: <Widget>[
        SliverAppBar(
          expandedHeight: 200.0,
          floating: false,
          pinned: true,
          flexibleSpace: FlexibleSpaceBar(
            background: Image.network(
              "https://img1.daumcdn.net/thumb/R1280x0/?scode=mtistory2&fname=https%3A%2F%2Fblog.kakaocdn.net%2Fdn%2FtEMUl%2FbtrDc6957nj%2FNwJoDw0EOapJNDSNRNZK8K%2Fimg.jpg",
              fit: BoxFit.cover,
            ),
            title: Text("CustomScrollView Example"),
          ),
        ),
        SliverList(
          delegate: SliverChildBuilderDelegate(
                (BuildContext context, int index) {
              return GestureDetector(
                onTap: (){
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => SecondPage()),
                  ).then((_) {
                    _restoreScrollPosition();
                  });
                },
                child: ListTile(
                  title: Text("Item $index"),
                ),
              );
            },
            childCount: 30,
          ),
        ),
        SliverGrid(
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            mainAxisSpacing: 10.0,
            crossAxisSpacing: 10.0,
          ),
          delegate: SliverChildBuilderDelegate(
                (BuildContext context, int index) {
              return Container(
                color: Colors.blue,
                height: 150.0,
                child: Center(
                  child: Text('Grid Item $index'),
                ),
              );
            },
            childCount: 20,
          ),
        ),
      ],
    );
  }
}


class SecondPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Second Page'),
      ),
      body: Center(
        child: ElevatedButton(
          child: Text('Go Back'),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
    );
  }
}