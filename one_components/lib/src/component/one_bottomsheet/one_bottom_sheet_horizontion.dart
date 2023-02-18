/*
 * File: one_bottom_sheet_horizontion.dart
 * File Created: Friday, 14th May 2021 10:10:49 am
 * Author: Tân Hà
 * -----
 * Last Modified: Hà Thanh Tân
 * Modified By: Hà Thanh Tân
 */

part of 'one_bottom_sheet.dart';

class OneBottomSheetHorizontion extends StatefulWidget {
  const OneBottomSheetHorizontion({
    Key? key,
    required this.actions,
    this.label,
    this.onSelected,
  }) : super(key: key);

  final String? label;
  final List<OneBottomSheetAction> actions;
  final ValueChanged<OneBottomSheetAction>? onSelected;

  @override
  _OneBottomSheetStateHorizontion createState() => _OneBottomSheetStateHorizontion();
}

class _OneBottomSheetStateHorizontion extends State<OneBottomSheetHorizontion> {
  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    return Container(
      constraints: BoxConstraints(maxHeight: height * 0.6),
      decoration: const BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.only(topLeft: Radius.circular(20.0), topRight: Radius.circular(20.0)),
      ),
      child: SafeArea(
        top: false,
        child: widget.label == null ? _createListViewNoTitle(context, widget.actions) : _createListView(context, widget.actions),
      ),
    );
  }

  Widget _createListViewNoTitle(BuildContext context, List<OneBottomSheetAction> actions) {
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: MediaQuery.of(context).size.width,
            height: 150,
            child: ListView.builder(
              padding: const EdgeInsets.only(bottom: 15),
              shrinkWrap: true,
              physics: const ClampingScrollPhysics(),
              scrollDirection: Axis.horizontal,
              itemCount: actions.length,
              itemBuilder: (BuildContext context, int index) {
                final action = actions.elementAt(index);
                return Material(
                  child: InkWell(
                    child: Padding(
                      padding: const EdgeInsets.symmetric(vertical: 10.0, horizontal: 20.0),
                      child: Column(
                        children: [
                          Container(
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: const BorderRadius.all(Radius.circular(30.0)),
                              border: Border.all(
                                color: OneColors.dividerGrey,
                                width: 1.0,
                              ),
                            ),
                            child: Padding(
                              padding: const EdgeInsets.all(15),
                              child: SvgPicture.asset(action.imageUrl, color: action.isEnable ? null : Colors.black26),
                            ),
                          ),
                          const SizedBox(height: 10),
                          AutoSizeText(
                            action.name ?? '',
                            style: OneTheme.of(context).body2.copyWith(color: action.isEnable ? null : Colors.black26),
                          ),
                        ],
                      ),
                    ),
                    onTap: !action.isEnable
                        ? null
                        : () {
                            Navigator.of(context).pop();
                            if (action.callback != null) action.callback!();
                            if (widget.onSelected != null) widget.onSelected!(action);
                          },
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget _createListView(BuildContext context, List<OneBottomSheetAction> actions) {
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ListTile(
              title: Text(widget.label!, style: OneTheme.of(context).title1),
              trailing: GestureDetector(
                onTap: () => {Navigator.of(context).pop()},
                child: SvgPicture.asset(OneIcons.ic_cancel),
              )),
          const Divider(height: 1, thickness: 2, indent: 20, endIndent: 20),
          Container(
            width: MediaQuery.of(context).size.width,
            height: 130,
            child: Center(
              child: ListView.builder(
                padding: const EdgeInsets.only(bottom: 15),
                shrinkWrap: true,
                physics: const ClampingScrollPhysics(),
                scrollDirection: Axis.horizontal,
                itemCount: actions.length,
                itemBuilder: (BuildContext context, int index) {
                  final action = actions.elementAt(index);
                  return Container(
                    child: InkWell(
                      child: Padding(
                        padding: const EdgeInsets.symmetric(vertical: 10.0, horizontal: 20.0),
                        child: Column(
                          children: [
                            Container(
                              decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: const BorderRadius.all(Radius.circular(30.0)),
                                border: Border.all(
                                  color: OneColors.dividerGrey,
                                  width: 1.0,
                                ),
                              ),
                              child: Padding(
                                padding: const EdgeInsets.all(15),
                                child: SvgPicture.asset(action.imageUrl),
                              ),
                            ),
                            const SizedBox(height: 10),
                            AutoSizeText(action.name ?? '', style: OneTheme.of(context).body2),
                          ],
                        ),
                      ),
                      onTap: () {
                        Navigator.of(context).pop();
                        if (action.callback != null) action.callback!();
                        if (widget.onSelected != null) widget.onSelected!(action);
                      },
                    ),
                  );
                },
              ),
            ),
          ),
        ],
      ),
    );
  }
}
