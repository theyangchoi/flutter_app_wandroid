import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app_wandroid/network/base/base_page.dart';
import 'package:flutter_app_wandroid/network/base/base_widget.dart';
import 'package:flutter_app_wandroid/network/common/global.dart';
import 'package:flutter_app_wandroid/network/model/project_list_model.dart';
import 'package:flutter_app_wandroid/network/view_model/project_list_view_model.dart';
import 'package:flutter_app_wandroid/network/view_model/project_tree_view_model.dart';
import 'package:flutter_app_wandroid/ui/widget/easyRefresh_widget.dart';
import 'package:flutter_app_wandroid/utils/place_holder_widget.dart';

class ProjectPage extends StatefulWidget {
  @override
  _ProjectPageState createState() => _ProjectPageState();
}

class _ProjectPageState extends State<ProjectPage>
    with TickerProviderStateMixin {
  TabController tabController;

  ProjectTreeViewModel _projectTreeViewModel = ProjectTreeViewModel();

  @override
  Widget build(BuildContext context) {
    return BasePage<ProjectTreeViewModel>(
      viewModel: _projectTreeViewModel,
      onFirstLoading: (v) {
        v.getProjectTreeData();
      },
      builder: (context, viewModel, child) {
        return BaseWidget(
          reqStatus: viewModel.reqStatus,
          child: DefaultTabController(
            length: viewModel.getProjectTreeList.length,
            child: Scaffold(
              appBar: AppBar(
                title: TabBar(
                  isScrollable: true,
                  indicatorColor: Colors.blue,
                  indicatorPadding: EdgeInsets.only(left: 20, right: 20),
                  tabs: List.generate(viewModel.getProjectTreeList.length,
                      (index) {
                    return Tab(
                      text: '${viewModel.getProjectTreeList[index].name}',
                    );
                  }),
                ),
              ),
              body: TabBarView(
                //点击切换页面重新加载数据
                children:
                    List.generate(viewModel.getProjectTreeList.length, (index) {
                  return ProjectDetailsPage(
                      id: viewModel.getProjectTreeList[index].id);
                }),
              ),
            ),
          ),
        );
      },
    );
  }
}

class ProjectDetailsPage extends StatefulWidget {
  final int id;
  ProjectDetailsPage({this.id});
  @override
  _ProjectDetailsPageState createState() => _ProjectDetailsPageState();
}

class _ProjectDetailsPageState extends State<ProjectDetailsPage>
    with AutomaticKeepAliveClientMixin {
  ProjectListViewModel _projectListViewModel = ProjectListViewModel();
  @override
  Widget build(BuildContext context) {
    super.build(context);
    return BasePage<ProjectListViewModel>(
      viewModel: _projectListViewModel,
      onFirstLoading: (v) {
        v.getProjectListData(cid: widget.id);
      },
      builder: (context, viewModel, child) {
        return BaseWidget(
          reqStatus: viewModel.reqStatus,
          child: RefreshWidget(
            controller: _projectListViewModel.getEasyRefreshController,
            onRefresh: () => _projectListViewModel.onRefresh(cid: widget.id),
            onLoad: () => _projectListViewModel.onLoad(cid: widget.id),
            child: ListView.builder(
                itemCount: viewModel.getProjectList.length,
                itemBuilder: (context, index) {
                  ProjectListModel p = viewModel.getProjectList[index];
                  return Container(
                    width: winWidth,
                    padding: EdgeInsets.symmetric(vertical: 1, horizontal: 10),
                    decoration: BoxDecoration(
                        border:Border(bottom:BorderSide(width: 1,color: Colors.grey))
                    ),
                    child: Column(
                      children: <Widget>[
                        //包裹整个卡片的布局
                        InkWell(
                          child: Card(
                            color: Colors.white,
                            elevation: 2,
                            shape: RoundedRectangleBorder(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(10.0)),//圆角
                            ),
                            //对Widget截取的行为，比如这里 Clip.antiAlias 指抗锯齿
                            // clipBehavior: Clip.antiAlias,
                            child: Padding(
                                padding: EdgeInsets.symmetric(
                                    vertical: 10, horizontal: 10),
                                child: CachedNetworkImage(//加载网络图片
                                  imageUrl: '${p?.envelopePic}',
                                  width: winWidth,
                                  height: 180.px,
                                  fit: BoxFit.cover,
                                  placeholder: (context, url) =>
                                      PlaceHolderWidget(),
                                )),
                          ),
                          onTap: () => viewModel.cardOnTap(
                              url: p?.link, title: p?.title),
                        ),
                        //标题文字描述
                        Container(
                          width: winWidth * 0.8,
                          child: Text(
                            '${p?.title}',
                            textAlign: TextAlign.center,
                            maxLines: 2,
                            style: TextStyle(
                                // fontWeight: FontWeight.bold, //字体加粗
                                fontSize: 16,//字体大小
                                color: Colors.black54),
                          ),
                        ),
                        SizedBox(height: 15.px),
                      ],
                    ),
                  );
                }),
          ),
        );
      },
    );
  }

  @override
  bool get wantKeepAlive => true;
}
