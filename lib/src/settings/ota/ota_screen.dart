import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:kaonic/generated/l10n.dart';
import 'package:kaonic/src/settings/ota/bloc/ota_bloc.dart';
import 'package:kaonic/src/widgets/solid_button.dart';
import 'package:kaonic/theme/theme.dart';

class OtaScreen extends StatefulWidget {
  const OtaScreen({super.key});

  @override
  State<OtaScreen> createState() => _OtaScreenState();
}

class _OtaScreenState extends State<OtaScreen> {
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
        create: (_) => OtaBloc(otaService: context.read()),
        child: Scaffold(
          appBar: AppBar(
            title: Text(S.of(context).otaUpdate),
          ),
          body: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                BlocBuilder<OtaBloc, OtaState>(
                  builder: (context, state) => Card(
                    elevation: 4,
                    color: Colors.grey[850],
                    child: Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                S.of(context).localOTApackage,
                                style: TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.white),
                              ),
                              _buildDownloadIcon(state.remoteFirmwareState, () {
                                context.read<OtaBloc>().add(DownloadFirmware());
                              })
                            ],
                          ),
                          const SizedBox(height: 8),
                          Text(
                            "${S.of(context).otaVersion} [${S.of(context).local}]: ${state.tagNameLocal}",
                            style: const TextStyle(color: Colors.white),
                          ),
                          const SizedBox(height: 8),
                          Text(
                            "${S.of(context).otaVersion} [${S.of(context).remote}]: ${state.tagNameRemote}",
                            style: const TextStyle(color: Colors.white),
                          ),
                          const SizedBox(height: 16),
                        ],
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 16),
                // Upload OTA Package Section
                BlocBuilder<OtaBloc, OtaState>(
                  builder: (context, state) => Card(
                    elevation: 4,
                    color: Colors.grey[850],
                    child: Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            S.of(context).uploadOTApackage,
                            style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                                color: Colors.white),
                          ),
                          const SizedBox(height: 8),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                "${S.of(context).deviceVersion}: ${state.kaonicFwVersion}",
                                style: const TextStyle(color: Colors.white),
                              ),
                              _buildDownloadIcon(state.kaonicFirmwareState, () {
                                context
                                    .read<OtaBloc>()
                                    .add(CheckKaonicFirmware());
                              })
                            ],
                          ),
                          const SizedBox(height: 16),
                          Align(
                            alignment: Alignment.centerRight,
                            child: _buildUploadButton(
                                state.kaonicUploadFirmwareState, () {
                              if (state.kaonicUploadFirmwareState ==
                                  OtaProcessingState.idle) {
                                context.read<OtaBloc>().add(UploadFirmware());
                              }
                            }),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ));
  }

  Widget _buildDownloadIcon(OtaProcessingState state, VoidCallback onDownload) {
    switch (state) {
      case OtaProcessingState.processing:
        return SizedBox(
          width: 20,
          height: 20,
          child: const CircularProgressIndicator(
            color: AppColors.negative,
          ),
        );
      case OtaProcessingState.success:
        return const Icon(
          Icons.check_circle,
          color: Colors.green,
          size: 20,
        );
      case OtaProcessingState.failure:
        return const Icon(
          Icons.error,
          color: Colors.red,
          size: 20,
        );
      case OtaProcessingState.idle:
      default:
        return SizedBox(
          width: 20,
          height: 20,
          child: IconButton(
            padding: EdgeInsets.zero,
            icon: const Icon(Icons.download, color: Colors.white),
            onPressed: onDownload,
          ),
        );
    }
  }

  Widget _buildUploadButton(OtaProcessingState state, VoidCallback onDownload) {
    final size = 25.0;
    switch (state) {
      case OtaProcessingState.processing:
        return SizedBox(
          width: size,
          height: size,
          child: const CircularProgressIndicator(
            color: AppColors.negative,
          ),
        );
      case OtaProcessingState.success:
        return Icon(
          Icons.check_circle,
          color: Colors.green,
          size: size,
        );
      case OtaProcessingState.failure:
        return Icon(
          Icons.error,
          color: Colors.red,
          size: size,
        );
      case OtaProcessingState.idle:
      default:
        return SizedBox(
          height: 40.h,
          width: 200.w,
          child: SolidButton(
            onTap: onDownload,
            padding: EdgeInsets.zero,
            textButton: S.of(context).upload,
            textStyle: const TextStyle(color: Colors.black),
          ),
        );
    }
  }
}
