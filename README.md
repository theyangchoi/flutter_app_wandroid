使用wanandroid api开发的一个flutter项目

flutter文件的命名规则：小写单词 加上下划线 _ 在接单词小写

### dio 文件夹 ==》网络部分
    使用dart语言自带的dio访问网络数据。
    dio_manager.dart :对网络进行简单的封装,可以根据自己的需要添加请求头等内容
    api.dart : 存放base_url、api以及调用的方法

### ui 文件夹 ==》 ui视图部分
    bottom_nav 底部导航栏

    page文件夹,存放页面
    ---->home_page.dart 首页
    ---->project_page.dart 项目页
    ---->classification_page.dart 分类页
    ---->mine_page.dart 我的页面

### widget 文件夹 ==》子UI部分,大多存放item布局