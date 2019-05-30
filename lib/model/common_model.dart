class CommonModel {
  final String icon;
  final String title;
  final String url;
  final String statusBarColor;
  final bool hideAppBar;

  CommonModel(
      {this.statusBarColor, this.hideAppBar, this.icon, this.title, this.url});

  factory CommonModel.fromjson(Map<String, dynamic> json) {
    return CommonModel(
        icon: json['icon'],
        title: json['title'],
        url: json['url'],
        statusBarColor: json['statusBarColor'],
        hideAppBar: json['hideAppBar']);
  }

  Map<String, dynamic> toJson() {
    return {icon: icon, title: title, url: url};
  }
}
