import 'package:flutter/material.dart';
import 'package:flutter_basis/flutter_basis.dart';

class BasisPopupLoading extends StatelessWidget with ResponsiveSizes {
  final ValueChanged<bool>? onPopInvoked;
  final String? loadingMsg;
  final VoidCallback? onCancel;

  const BasisPopupLoading({
    Key? key, 
    this.onPopInvoked, 
    this.loadingMsg,
    this.onCancel,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return PopScope(
      onPopInvoked: onPopInvoked,
      canPop: false,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Stack(
            clipBehavior: Clip.none,
            alignment: Alignment.topRight,
            children: [
              SizedBox(
                width: screenWidth(context) * .5,
                child: Card(
                  margin: EdgeInsets.zero,
                  elevation: 0,
                  color: Color(0xFF303030).withOpacity(.9),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(dp4(context)),
                  ),
                  child: _content(context),
                ),
              ),

              if (onCancel != null) Positioned(
                child: SizedBox(
                  height: dp30(context),
                  width: dp30(context),
                  child: FloatingActionButton(
                    tooltip: 'Cancelar requisição',
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.only(
                        topRight: Radius.circular(dp4(context)),
                      ),
                    ),
                    elevation: 1,
                    backgroundColor: Color(0xFFFF5252),
                    onPressed: onCancel ?? Navigate.to.pop,
                    child: const Icon(Icons.close, color: Colors.white),
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _content(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(
        vertical: dp15(context),
        horizontal: dp10(context),
      ),
      child: Column(
        mainAxisAlignment:  MainAxisAlignment.spaceEvenly,
        children: [
          BasisLoading(color: Colors.white, size: dp30(context)),

          if (loadingMsg != null && loadingMsg!.isNotEmpty) ...[
            SizedBox(height: dp10(context)),
          
            BasisText(
              loadingMsg!,
              fontSize: dp14(context),
              color: Colors.white,
              alignCenter: true,
              light: true,
            ),
          ],
        ],
      ),
    );
  }

  static show({
    String? loadingMsg, 
    VoidCallback? onCancel,
  }) {
    showDialog(
      barrierDismissible: false,
      context: Navigate.navigatorKey.currentState!.overlay!.context, 
      barrierColor: Colors.transparent,
      builder: (context) => BasisPopupLoading(
        loadingMsg: loadingMsg,
        onCancel: onCancel,
      ),
    );
  }
}
