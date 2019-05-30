import 'package:flutter/material.dart';

enum SearchBarType { home, normal, homeLight }

class SearchBar extends StatefulWidget {
  final SearchBarType searchBarType;
  final Function localCallBack;
  final Function inputBoxClick;
  final Function rightButtonClick;
  final Function speakClick;
  final String defaultText;
  final bool hideLeft;
  final String hint;
  final ValueChanged<String> onChanged;

  const SearchBar(
      {Key key,
      this.searchBarType = SearchBarType.normal,
      this.localCallBack,
      this.inputBoxClick,
      this.defaultText = '',
      this.rightButtonClick,
      this.hideLeft = true,
      this.hint = '',
      this.speakClick,
      this.onChanged})
      : super(key: key);

  @override
  _SearchBarState createState() => _SearchBarState();
}

class _SearchBarState extends State<SearchBar> {
  bool showClear = false;
  final TextEditingController _controller = TextEditingController();

  @override
  void initState() {
    if (widget.defaultText != null) {
      setState(() {
        _controller.text = widget.defaultText;
      });
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return widget.searchBarType == SearchBarType.normal
        ? _getSearchBarNormal()
        : _getSearchBarHome();
  }

  _getSearchBarNormal() {
    return Container(
      child: Row(
        children: <Widget>[
          _wrapTap(
              Container(
                padding: EdgeInsets.fromLTRB(6, 5, 10, 5),
                child: widget.hideLeft ?? true
                    ? null
                    : Icon(
                        Icons.arrow_back_ios,
                        color: Colors.grey,
                        size: 26,
                      ),
              ),
              widget.localCallBack),
          Expanded(
            child: _inputBox(),
            flex: 1,
          ),
          _wrapTap(
              Container(
                padding: EdgeInsets.fromLTRB(10, 5, 10, 5),
                child: Text(
                  '搜索',
                  style: TextStyle(color: Colors.blue, fontSize: 17),
                ),
              ),
              widget.rightButtonClick)
        ],
      ),
    );
  }

  _getSearchBarHome() {
    return Row(
      children: <Widget>[
        _wrapTap(
          Container(
            padding: EdgeInsets.fromLTRB(7, 5, 5, 5),
            child: Row(
              children: <Widget>[
                Text(
                  '上海',
                  style: TextStyle(fontSize: 14, color: _homeFontColor()),
                ),
                Icon(
                  Icons.expand_more,
                  color: _homeFontColor(),
                )
              ],
            ),
          ),
          widget.localCallBack,
        ),
        Expanded(flex: 1, child: _inputBox()),
        _wrapTap(
          Container(
            padding: EdgeInsets.fromLTRB(10, 5, 10, 5),
            child: Icon(
              Icons.comment,
              color: _homeFontColor(),
              size: 26,
            ),
          ),
          widget.rightButtonClick,
        )
      ],
    );
  }

  _wrapTap(Widget widget, Function callBack) {
    return GestureDetector(
      onTap: () {
        if (callBack != null) {
          callBack();
        }
      },
      child: widget,
    );
  }

  _homeFontColor() {
    return widget.searchBarType == SearchBarType.homeLight
        ? Colors.black54
        : Colors.white;
  }

  _inputBox() {
    Color inputBoxColor;
    if (widget.searchBarType == SearchBarType.home) {
      inputBoxColor = Colors.white;
    } else {
      inputBoxColor = Color(int.parse('0xffEDEDED'));
    }
    return Container(
      height: 30,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(
            widget.searchBarType == SearchBarType.normal ? 5 : 15),
        color: inputBoxColor,
      ),
      alignment: Alignment.center,
      padding: EdgeInsets.fromLTRB(5, 3, 3, 3),
      child: Row(
        children: <Widget>[
          Icon(
            Icons.search,
            size: 20,
            color: widget.searchBarType == SearchBarType.normal
                ? Color(0xffA9A9A9)
                : Colors.blue,
          ),
          Expanded(
              flex: 1,
              child: SearchBarType.normal == widget.searchBarType
                  ? TextField(
                      autofocus: true,
                      maxLines: 1,
                      controller: _controller,
                      onChanged: _onChanged,
                      style: TextStyle(color: Colors.black54, fontSize: 15),
                      decoration: InputDecoration(
                          hintText: widget.hint ?? '',
                          hintMaxLines: 1,
                          contentPadding: EdgeInsets.fromLTRB(5, 0, 5, 0),
                          border: InputBorder.none,
                          hintStyle:
                              TextStyle(fontSize: 13, color: Colors.grey)),
                    )
                  : _wrapTap(
                      Container(
                        child: Text(
                          widget.defaultText,
                          style: TextStyle(fontSize: 13, color: Colors.grey),
                        ),
                      ),
                      widget.inputBoxClick,
                    )),
          !showClear
              ? _wrapTap(
                  Icon(
                    Icons.mic,
                    size: 22,
                    color: widget.searchBarType == SearchBarType.normal
                        ? Colors.blue
                        : Colors.grey,
                  ),
                  widget.speakClick)
              : _wrapTap(
                  Icon(
                    Icons.clear,
                    size: 22,
                    color: Colors.grey,
                  ), () {
                  setState(() {
                    _controller.clear();
                  });
                  _onChanged('');
                })
        ],
      ),
    );
  }

  _onChanged(String text) {
    if (text != null && text.length > 0) {
      setState(() {
        showClear = true;
      });
    } else {
      setState(() {
        showClear = false;
      });
    }
    if (widget.onChanged != null) {
      widget.onChanged(text);
    }
  }
}
