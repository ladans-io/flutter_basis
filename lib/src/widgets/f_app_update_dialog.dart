import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_basis/flutter_basis.dart';

import '../utils/url_launcher.dart';

class FAppUpdateDialog extends StatefulWidget {
  final bool forceUpdate;
  final String currentVer, 
               newVer, 
               playStoreUrl, 
               appleStoreUrl, 
               versionNews;
  const FAppUpdateDialog({
    Key? key,
    this.forceUpdate = false,
    required this.currentVer,
    required this.newVer,
    required this.versionNews,
    required this.playStoreUrl,
    required this.appleStoreUrl,
  }) : super(key: key);

  @override
  State<FAppUpdateDialog> createState() => _DshAlertDialogState();
}

class _DshAlertDialogState extends State<FAppUpdateDialog> with ResponsiveSizes {
  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () => Future.value(false),
      child: SizedBox(
        width: MediaQuery.of(context).size.width * .9,
        child: AlertDialog.adaptive(
          actionsAlignment: MainAxisAlignment.center,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(dp6(context))),
          surfaceTintColor: Colors.transparent,
          title: _title,
          content: _content,
          actions: [
            if (!widget.forceUpdate) _onCancelButton,
            _onConfirmButton,
          ],
        ),
      ),
    );
  }

  Widget get _title {
    return Column(
      children: [
        Image.asset(
          Platform.isAndroid 
            ? 'assets/play-store.png' 
            : 'assets/app-store.png',
          width: screenWidth(context) * .4,
        ),
        FText(
          'Atualizar Odex${widget.forceUpdate ? '!' : '?'}',
          alignCenter: true,
          fontSize: dp18(context),
          bold: true,
          color: Colors.black87,
        ),
      ],
    );
  }

  Widget get _content {
    final f16 = dp16(context);

    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        FText(
          'Está disponível uma nova versão deste aplicativo! \nVersão atual ${widget.currentVer} \nNova versão ${widget.newVer}',
          color: Colors.black87,
          fontSize: f16,
        ),
        if (widget.versionNews.isNotEmpty) ...[
          SizedBox(height: dp20(context)),
          FText(
            'O que há de novo?',
            color: Colors.black87,
            fontSize: f16,
            bold: true,
          ),
          SizedBox(height: dp6(context)),
          if (widget.versionNews.contains('fixture')) const Align(
            alignment: Alignment.topLeft,
            child: FText(
              'Correções de bugs:',
              color: Colors.black87,
              semiBold: true,
              underline: true,
            ),
          ),
          if (widget.versionNews.contains('feature')) const Align(
            alignment: Alignment.topLeft,
            child: FText(
              'Novas funcionalidades:',
              color: Colors.black87,
              semiBold: true,
              underline: true,
            ),
          ),
          SizedBox(height: dp5(context)),
          ...List.generate(
              widget.versionNews.split('***').length - 1,
              (index) => Align(
                alignment: Alignment.topLeft,
                child: FText(
                  '• ${widget.versionNews.split('***')[index + 1]}',
                  color: Colors.black87,
                ),
              ),
            ),
        ],
      ],
    );
  }

  Widget get _onConfirmButton {
    return FElevatedButton(
      radius: Platform.isIOS ? 0 : null,
      backgroundColor: Platform.isAndroid
        ? const Color(0xff038A5D)
        : CupertinoColors.black.withOpacity(.7),
      onPressed: () async {
        if (Platform.isAndroid) await UrlLauncher.launchURL(widget.playStoreUrl);
        if (Platform.isIOS) await UrlLauncher.launchURL(widget.appleStoreUrl);
      },
      fullWidth: widget.forceUpdate,
      title: 'Atualizar',
    );
  }

  Widget get _onCancelButton {
    return FTextButton(
      onPressed: Navigator.of(context).pop,
      fullWidth: false,
      color: Platform.isAndroid ? const Color(0xff038A5D) : CupertinoColors.black,
      title: 'Não obrigado',
    );
  }
}
