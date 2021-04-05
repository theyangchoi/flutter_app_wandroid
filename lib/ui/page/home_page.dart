import 'package:banner_view/banner_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_app_wandroid/dio/api.dart';
import 'file:///D:/flutter/FlutterDemo/app_wandroid/flutter_app_wandroid/lib/ui/widget/article_item.dart';

/**
 * 首页文章列表 以及banner图
 * 1.先在State中声明接受数据的变量
 * 2.在initState方法中请求网络数据并赋值给声明的变量
 * 3.编写布局  注意布局是一个最外层的listview包裹一个bannerview和多个listview item组成的列表
 */
class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  ///滑动控制器 -->用于判断是否拉到屏幕底部进行加载更多的操作
  ScrollController _controller = new ScrollController();
  ///控制正在加载的显示  -->后修改至 easyloading
  bool _isHide = true;
  ///请求到的文章数据集合
  List articlesList = [];
  ///banner列表集合
  List bannersList = [];
  ///总页数
  var totalCount = 0;
  ///分页加载，当前页码
  var currentPage = 0;
  ///访问数据
  @override
  void initState() {
    super.initState();
    _controller.addListener(() {
      ///获得 SrollController 监听控件可以滚动的最大范围
      var maxScroll = _controller.position.maxScrollExtent;
      ///获得当前位置的像素值
      var pixels = _controller.position.pixels;
      ///当前滑动位置到达底部，同时还有更多数据 也就是当前页码小于总页码时，执行加载更多的操作
      if (maxScroll == pixels && currentPage < totalCount) {
        _getArticlelist();
      }
    });
    _pullToRefresh();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }
  ///获取文章列表
  _getArticlelist([bool update = true]) async {
    var data = await Api.getArticleList(currentPage);
    if (data != null) {
      var map = data['data'];
      var datas = map['datas'];
      ///文章总数
      totalCount = map["pageCount"];
      ///如果当前页码是0 证明是执行的下拉刷新或者第一次加载数据，要清空原来的数据集合
      if (currentPage == 0) {
        articlesList.clear();
      }
      currentPage++;
      articlesList.addAll(datas);
      if (update) {
        setState(() {});
      }
    }
  }

  _getBanner([bool update = true]) async {
    var data = await Api.getBanner();
    if (data != null) {
      bannersList.clear();
      bannersList.addAll(data['data']);
      if (update) {
        setState(() {});
      }
    }
  }
  ///下拉刷新
  Future<void> _pullToRefresh() async {
    currentPage = 0;
    ///组合两个异步任务，创建一个都完成后的新的Future
    Iterable<Future> futures = [_getArticlelist(), _getBanner()];
    await Future.wait(futures);
    _isHide = false;
    setState(() {});
    return null;
  }

  ///布局
  @override
  Widget build(BuildContext context) {
    return Stack(
      children: <Widget>[
        ///正在加载
        Offstage(
          offstage: !_isHide, //是否隐藏
          // child: new Center(child: CircularProgressIndicator()),
        ),

        ///内容
        ///一个最外层的下拉刷新组件RefreshIndicator
        ///包裹一层ListView
        ///_buildItem adapter条目item，banner列表也作为一个条目添加到adapter中去
        Offstage(
          offstage: _isHide,
          ///SwipeRefresh 下拉刷新组件
          child: new RefreshIndicator(
              child: ListView.builder(
                //item总条目数 +1代表了banner的条目,比如文章列表的总条数是9，这时候在前面插入了一个banner列表所以整个listview的总条目会变成10，所以要+1
                itemCount: articlesList.length + 1,
                itemBuilder: (context, i) => _buildItem(i),//adapter条目item 视图生成方法
                controller: _controller,
              ),
              onRefresh: _pullToRefresh),
        ),
      ],
    );
  }
  ///添加adapter的item条目
  Widget _buildItem(int i) {
    ///如果当前条目的下表索引是0  也就是第一条，则显示为banner列表，否则显示为文章列表
    if (i == 0) {
      return new Container(
        height: MediaQuery.of(context).size.height*0.3,//高度设置为屏幕总高度(MediaQuery.of(context).size.height) 的 0.3
        child: _bannerView(),
      );
    }
    var itemData = articlesList[i - 1];
    return new ArticleItem(itemData);
  }

  Widget _bannerView() {
    List<Widget> list = bannersList.map((item) {
      return Image.network(item['imagePath'], fit: BoxFit.cover); //fit 图片充满容器
    }).toList();
    ///判断数据不为空
    return list.isNotEmpty ? BannerView(list, //控制轮播时间
      intervalDuration: const Duration(seconds: 3),)
        : null;
  }


}
