import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app_wandroid/network/base/base_page.dart';
import 'package:flutter_app_wandroid/network/base/base_widget.dart';
import 'package:flutter_app_wandroid/network/common/global.dart';
import 'package:flutter_app_wandroid/network/model/home_list_model.dart';
import 'package:flutter_app_wandroid/network/view_model/banner_view_model.dart';
import 'package:flutter_app_wandroid/network/view_model/home_list_view_model.dart';
import 'package:flutter_app_wandroid/ui/widget/article_widget.dart';
import 'package:flutter_app_wandroid/ui/widget/easyRefresh_widget.dart';
import 'package:flutter_swiper/flutter_swiper.dart';

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

class _HomePageState extends State<HomePage> with AutomaticKeepAliveClientMixin {

  final BannerViewModel _bannerViewModel = BannerViewModel();
  final HomeListViewModel _homeListViewModel = HomeListViewModel();
  SwiperController swiperController;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    swiperController = SwiperController();
    swiperController.startAutoplay();
  }

  @override
  Widget build(BuildContext context) {
    var imageCache = PaintingBinding.instance.imageCache;
    int byte = imageCache.currentSizeBytes;
    return Scaffold(
      body: SafeArea(
          child: RefreshWidget(
            controller: _homeListViewModel.getEasyRefreshController,
            onRefresh: _homeListViewModel.onRefresh,
            onLoad: _homeListViewModel.onLoad,
            child: CustomScrollView(
              slivers: <Widget>[
                SliverAppBar(
                  backgroundColor: Colors.white,
                  expandedHeight: 200,
                  flexibleSpace: FlexibleSpaceBar(
                    background: BannerWidget(viewModel: _bannerViewModel,),
                  ),
                ),
                SliverToBoxAdapter(
                  child: HomeListWidget(viewModel: _homeListViewModel)),
              ],
            )
          )
      ),
    );
  }

  @override
  bool get wantKeepAlive => true;
}

class BannerWidget extends StatelessWidget {

  final BannerViewModel viewModel;
  BannerWidget({this.viewModel});

  @override
  Widget build(BuildContext context) {
    return BasePage<BannerViewModel>(
      viewModel: viewModel,
      onFirstLoading: (v){
        v.getBannerData();
      },
      builder: (context,model,child){
        return BaseWidget(
          reqStatus: model.reqStatus,
          child: ConstrainedBox(
            child: Swiper(
              onTap: (index){
                  model.cardOnTap(
                      url: model?.getBannerList[index].url,
                      title: model?.getBannerList[index].title);
              },
              autoplay: false,
              loop: false,
              outer: false,
              pagination: new SwiperPagination(margin: new EdgeInsets.all(5.0)),
              itemCount: model.getBannerList.length,
              itemBuilder: (context,index){
                  return new CachedNetworkImage(
                    imageUrl: model.getBannerList[index].imagePath,
                    placeholder: (context,url) => new Container(
                      child: new Center(
                        child: new CircularProgressIndicator(),
                      ),
                      width: 160.0,
                      height: 80.0,
                    ),
                    errorWidget: (context,url,error) => Icon(Icons.error),
                    fit: BoxFit.cover,
                  );
              },
            ),
            constraints: new BoxConstraints.loose(new Size(MediaQuery.of(context).size.width, 180.0)),
          ),
        );
      },
    );
  }
}

class HomeListWidget extends StatelessWidget {
  final HomeListViewModel viewModel;

  HomeListWidget({this.viewModel});

  @override
  Widget build(BuildContext context) {
    return BasePage<HomeListViewModel>(
      viewModel: viewModel,
      onFirstLoading: (v){
        v.getHomeArticleData();
      },
      builder: (context,model,child){
          return BaseWidget(
            reqStatus: ReqStatus.success,
            child: ListView.builder(
                itemCount: model.getArticleList.length,
                shrinkWrap: true,
                physics: NeverScrollableScrollPhysics(),
                itemBuilder: (context,index){
                    HomeListModel homeListModel = model.getArticleList[index];
                    return ArticleTileWidget(
                      onTap: ()=> viewModel.cardOnTap(title: homeListModel.title,url: homeListModel.link),
                      title: homeListModel.title,
                      author: homeListModel.author,
                      chapterName: homeListModel.chapterName,
                      niceDate: homeListModel.niceDate,
                      index: index,
                    );
                }),
          );
      },
    );
  }
}
