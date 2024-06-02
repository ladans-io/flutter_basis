import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_basis/flutter_basis.dart';

class BasisAppUpdateDialog extends StatefulWidget {
  final bool forceUpdate;
  final String currentVer, 
               newVer, 
               playStoreUrl, 
               appleStoreUrl, 
               versionNews;
  const BasisAppUpdateDialog({
    Key? key,
    this.forceUpdate = false,
    required this.currentVer,
    required this.newVer,
    required this.versionNews,
    required this.playStoreUrl,
    required this.appleStoreUrl,
  }) : super(key: key);

  @override
  State<BasisAppUpdateDialog> createState() => _DshAlertDialogState();
}

class _DshAlertDialogState extends State<BasisAppUpdateDialog> {
  @override
  Widget build(BuildContext context) {
    return PopScope(
      canPop: false,
      child: SizedBox(
        width: MediaQuery.of(context).size.width * .9,
        child: AlertDialog.adaptive(
          actionsAlignment: MainAxisAlignment.center,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(6)),
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
          width: 40.w,
        ),
        BasisText(
          'Atualizar Odex${widget.forceUpdate ? '!' : '?'}',
          alignCenter: true,
          fontSize: 18,
          bold: true,
          color: Colors.black87,
        ),
      ],
    );
  }

  Widget get _content {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        BasisText(
          'Está disponível uma nova versão deste aplicativo! \nVersão atual ${widget.currentVer} \nNova versão ${widget.newVer}',
          color: Colors.black87,
          fontSize: 16,
        ),
        if (widget.versionNews.isNotEmpty) ...[
          SizedBox(height: 20),
          BasisText(
            'O que há de novo?',
            color: Colors.black87,
            fontSize: 16,
            bold: true,
          ),
          SizedBox(height: 6),
          if (widget.versionNews.contains('fixture')) const Align(
            alignment: Alignment.topLeft,
            child: BasisText(
              'Correções de bugs:',
              color: Colors.black87,
              semiBold: true,
              underline: true,
            ),
          ),
          if (widget.versionNews.contains('feature')) const Align(
            alignment: Alignment.topLeft,
            child: BasisText(
              'Novas funcionalidades:',
              color: Colors.black87,
              semiBold: true,
              underline: true,
            ),
          ),
          SizedBox(height: 5),
          ...List.generate(
              widget.versionNews.split('***').length - 1,
              (index) => Align(
                alignment: Alignment.topLeft,
                child: BasisText(
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
    return BasisButton(
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
    return BasisTextButton(
      onPressed: Navigator.of(context).pop,
      fullWidth: false,
      color: Platform.isAndroid ? const Color(0xff038A5D) : CupertinoColors.black,
      title: 'Não obrigado',
    );
  }
}
