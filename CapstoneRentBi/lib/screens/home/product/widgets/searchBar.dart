import 'package:capstone_rent_bi/utilities/spacing.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class SearchBar extends StatefulWidget {
  // bool _isSearching;
  const SearchBar({Key? key}) : super(key: key);

  @override
  _SearchBarState createState() => _SearchBarState();
}

class _SearchBarState extends State<SearchBar> {
  final TextEditingController _searchBarController = TextEditingController();
  final FocusNode _focusNode = FocusNode();
  // bool _isSearching = false;

  @override
  void initState() {
    super.initState();

    // Start listening to changes.
    _searchBarController.addListener(() => setState(() {}));
    _focusNode.addListener(() {
      setState(() {});
    });
  }

/*
  void _issearchfunc() {
    _isSearching = true;
  }
*/

  @override
  void dispose() {
    _searchBarController.dispose();
    _focusNode.dispose();
    super.dispose();
  }

  /*
  @override
  void initState() {
    super.initState();
    widget._isSearching = false;
  }*/

  String regexToRemoveEmoji =
      r'(\u00a9|\u00ae|[\u2000-\u3300]|\ud83c[\ud000-\udfff]|\ud83d[\ud000-\udfff]|\ud83e[\ud000-\udfff])';

  @override
  Widget build(BuildContext context) {
    return Container(
      // color: Colors.indigoAccent,
      height: screenHeightPercentage(context, percentage: 0.05),
      width: screenWidthPercentage(context, percentage: 0.55),
      // margin: const EdgeInsets.fromLTRB(0, 19.25, 0, 0),
      // decoration: kBoxDecorationStyle,
      // padding: const EdgeInsets.fromLTRB(0, 0, 0, 0),
      child: TextFormField(
        inputFormatters: [
          FilteringTextInputFormatter.deny(RegExp(regexToRemoveEmoji))
        ],
        focusNode: _focusNode,
        keyboardType: TextInputType.text,
        controller: _searchBarController,
        cursorColor: Colors.black12,
        textAlign: TextAlign.center,
        textAlignVertical: TextAlignVertical.center,
        // controller: controller,

/*
        onChanged: (value) {
          setState(() {
            debugPrint('onChanged: ' + _isSearching.toString());
            _isSearching = true;
          });
        },*/
/*        onTap: () {
          setState(() {
            debugPrint('onTap: ' + _isSearching.toString());
            _isSearching = true;
            // FocusScope.of(context).requestFocus(FocusNode());
          });
        },*/
        decoration: InputDecoration(
          contentPadding: const EdgeInsets.fromLTRB(5, 0, 5, 0),
          // fillColor: Colors.grey[200],
          fillColor: const Color(0xffebebeb),
          filled: true,
          isDense: true,
          // border: InputBorder.none,
          border: OutlineInputBorder(
            // borderRadius: BorderRadius.all(Radius.circular(7.5)),
            borderRadius: BorderRadius.circular(6),
            borderSide: const BorderSide(width: 0, style: BorderStyle.none),
          ),
          /*border: const OutlineInputBorder(
            borderRadius: BorderRadius.all(Radius.circular(7.5)),
          ),
          focusedBorder: const OutlineInputBorder(
            borderRadius: BorderRadius.all(Radius.circular((7.5))),
            borderSide: BorderSide(color: Colors.black45, width: 1),
          ),*/
          // border:UnderlineInputBorder(borderSide: BorderSide(color: Colors.blueAccent)),
          // disabledBorder: OutlineInputBorder(borderSide: BorderSide(width: 10, color: Colors.transparent)),

          constraints: const BoxConstraints(
            minHeight: 0,
            minWidth: 0,
          ),

          prefixIcon:
              _searchBarController.text.isNotEmpty || _focusNode.hasFocus
                  ? Container(
                      height: 0,
                      width: 0,
                      color: Colors.transparent,
                    )
                  : IconButton(
                      icon: const Icon(
                        Icons.search,
                      ),
                      color: Colors.black45,
                      onPressed: () => print('searched'),
                      tooltip: 'search',
                      splashColor: Colors.transparent,
                      highlightColor: Colors.transparent,
                      hoverColor: Colors.transparent,
                      focusColor: Colors.transparent,
                      // iconSize: widget._isSearching ? 0 : 20,
                    ),

          prefixIconConstraints:
              _searchBarController.text.isNotEmpty || _focusNode.hasFocus
                  ? const BoxConstraints(maxHeight: 0, maxWidth: 0)
                  : const BoxConstraints(),

          suffixIcon: IconButton(
            // onPressed: () => print('closed'),
            onPressed: () => _searchBarController.clear(),
            icon: const Icon(Icons.close),
            tooltip: 'delete',
            color: Colors.black26,
            splashColor: Colors.transparent,
            highlightColor: Colors.transparent,
            hoverColor: Colors.transparent,
            focusColor: Colors.transparent,
          ),
          // hintText: 'Marka, ürün, üye, #etiket ara',
          hintText: _focusNode.hasFocus ? '' : 'RentBi\'de Ara',
          hintStyle: const TextStyle(
            fontFamily: 'OpenSans',
          ),
          // isCollapsed: false,
          // border: OutlineInputBorder(),
        ),
      ),
    );
  }
}
/*TextFormField(
              inputFormatters: [
                FilteringTextInputFormatter.deny(RegExp(regexToRemoveEmoji))
              ],
              keyboardType: TextInputType.text,
              controller: _searchBarController,
              cursorColor: Colors.black12,
              textAlign: TextAlign.left,
              textAlignVertical: TextAlignVertical.center,
              // controller: controller,

              onTap: () {
                setState(() {
                  debugPrint('ifFalse: '+_isSearching.toString());
                  _isSearching = true;
                });
              },

              decoration: InputDecoration(
                contentPadding: const EdgeInsets.fromLTRB(5, 0, 5, 0),
                // fillColor: Colors.indigoAccent,
                filled: true,
                isDense: true,
                // border: InputBorder.none,
                border: OutlineInputBorder(
                  // borderRadius: BorderRadius.all(Radius.circular(7.5)),
                  borderRadius: BorderRadius.circular(10),
                  borderSide:
                      const BorderSide(width: 0, style: BorderStyle.none),
                ),
                    constraints: const BoxConstraints(
                  minHeight: 0,
                  minWidth: 0,
                ),
                prefixIcon: IconButton(
                  icon: const Icon(
                    Icons.search,
                  ),
                  color: Colors.black45,
                  onPressed: () => print('searched'),
                  tooltip: 'search',
                  splashColor: Colors.transparent,
                  highlightColor: Colors.transparent,
                  hoverColor: Colors.transparent,
                  focusColor: Colors.transparent,
                  // iconSize: widget._isSearching ? 0 : 20,
                ),
                suffixIcon: IconButton(
                  // onPressed: () => print('closed'),
                  onPressed: () => _searchBarController.clear(),
                  icon: const Icon(Icons.close),
                  tooltip: 'delete',
                  color: Colors.black26,
                  splashColor: Colors.transparent,
                  highlightColor: Colors.transparent,
                  hoverColor: Colors.transparent,
                  focusColor: Colors.transparent,
                ),
                // hintText: 'Marka, ürün, üye, #etiket ara',
                hintText: 'RentBi\'de Ara',
                hintStyle: const TextStyle(
                  fontFamily: 'OpenSans',
                ),
                // isCollapsed: false,
                // border: OutlineInputBorder(),
              ),
            ),*/
/*
          prefixIcon: IconButton(
            icon: const Icon(
              Icons.search,
            ),
            color: Colors.black45,
            onPressed: () => print('searched'),
            tooltip: 'search',
            splashColor: Colors.transparent,
            highlightColor: Colors.transparent,
            hoverColor: Colors.transparent,
            focusColor: Colors.transparent,
            // iconSize: widget._isSearching ? 0 : 20,
          ),
*/