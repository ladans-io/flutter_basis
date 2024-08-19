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
                    borderRadius: BorderRadius.circular(4),
                  ),
                  child: _content(context),
                ),
              ),

              if (onCancel != null) Positioned(
                child: SizedBox(
                  height: 30,
                  width: 30,
                  child: FloatingActionButton(
                    tooltip: 'Cancelar requisição',
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.only(
                        topRight: Radius.circular(4),
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
        vertical: 15,
        horizontal: 10,
      ),
      child: Column(
        mainAxisAlignment:  MainAxisAlignment.spaceEvenly,
        children: [
          BasisLoading(color: Colors.white, size: 30),

          if (loadingMsg != null && loadingMsg!.isNotEmpty) ...[
            SizedBox(height: 10),
          
            BasisText(
              loadingMsg!,
              fontSize: 14,
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
