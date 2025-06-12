package network.beechat.app.kaonic

import android.Manifest
import android.content.pm.PackageManager
import android.media.RingtoneManager
import android.os.Bundle
import android.util.Log
import androidx.core.app.ActivityCompat
import androidx.core.content.ContextCompat
import androidx.core.content.FileProvider
import io.flutter.embedding.android.FlutterActivity
import io.flutter.plugin.common.EventChannel
import io.flutter.plugin.common.MethodChannel
import kotlinx.coroutines.CoroutineScope
import kotlinx.coroutines.Dispatchers
import kotlinx.coroutines.SupervisorJob
import network.beechat.app.kaonic.services.KaonicService
import network.beechat.app.kaonic.services.SecureStorageHelper
import network.beechat.kaonic.communication.KaonicCommunicationManager
import network.beechat.kaonic.impl.KaonicLib
import java.io.File
import network.beechat.kaonic.models.KaonicEventType
import java.util.UUID

class MainActivity : FlutterActivity() {
    companion object {
        private const val REQUEST_RECORD_AUDIO_PERMISSION = 200
        private const val REQUEST_STORAGE_PERMISSION = 201
    }

    lateinit var secureStorageHelper: SecureStorageHelper

    private var serial: AndroidSerial? = null
    private val CHANNEL = "network.beechat.app.kaonic/kaonic"

    private val CHANNEL_EVENT = "network.beechat.app.kaonic/audioStream"
    private val KAONIC_EVENT = "network.beechat.app.kaonic/packetStream"
    private var eventSink: EventChannel.EventSink? = null


    private val KAONIC_SERVICE_EVENT = "network.beechat.app.kaonic.service/kaonicEvents"


    override fun onCreate(savedInstanceState: Bundle?) {
        super.onCreate(savedInstanceState)

        secureStorageHelper = SecureStorageHelper(applicationContext)
        serial = AndroidSerial(this)
        checkAudioPermission()

        MethodChannel(
            flutterEngine!!.dartExecutor.binaryMessenger,
            CHANNEL
        ).setMethodCallHandler { call, result ->
            when (call.method) {
                "generateSecret" -> {
                    result.success(UUID.randomUUID().toString())
                }

                "sendTextMessage" -> {
                    try {
                        val textMessage = call.argument<String>("message") ?: ""
                        val address = call.argument<String>("address") ?: ""
                        val chatId = call.argument<String>("chatId") ?: ""
                        KaonicService.sendTextMessage(textMessage, address, chatId)

                        result.success(0)
                    } catch (ex: Exception) {
                        Log.d("sendTextMessageError", ex.toString())
                        result.error("sendTextMessageError", ex.message, "")
                    }
                }

                "sendFileMessage" -> {
                    try {
                        val filePath = call.argument<String>("filePath") ?: ""
                        val address = call.argument<String>("address") ?: ""
                        val chatId = call.argument<String>("chatId") ?: ""
                        Log.d("filePath", filePath)
                        Log.d("address", address)
                        Log.d("chatId", chatId)
                        val file = File(filePath)
                        val uri = FileProvider.getUriForFile(
                            this,
                            "$packageName.fileprovider",
                            file
                        )
                        KaonicService.sendFileMessage(uri.toString(), address, chatId)

                        result.success(0)
                    } catch (ex: Exception) {
                        Log.d("sendFileMessage", ex.toString())
                        result.error("sendFileMessage", ex.message, "")
                    }
                }

                "sendConfigure" -> {
                    try {
                        val mcs = call.argument<Int>("mcs") ?: 0
                        val optionNumber = call.argument<Int>("optionNumber") ?: 0
                        val module = call.argument<Int>("module") ?: 0
                        val frequency = call.argument<Int>("frequency") ?: 0
                        val channel = call.argument<Int>("channel") ?: 0
                        val channelSpacing = call.argument<Int>("channelSpacing") ?: 0
                        val txPower = call.argument<Int>("txPower") ?: 0

                        KaonicService.sendConfig(
                            mcs,
                            optionNumber,
                            module,
                            frequency,
                            channel,
                            channelSpacing,
                            txPower
                        )

                        result.success(true)
                    } catch (ex: Exception) {
                        Log.d("sendConfigure", ex.toString())
                        result.error("sendConfigure", ex.message, "")
                    }
                }

                "createChat" -> {
                    try {
                        val address = call.argument<String>("address") ?: ""
                        val chatId = call.argument<String>("chatId") ?: ""
                        KaonicService.createChat(address, chatId)

                        result.success(true)
                    } catch (ex: Exception) {
                        Log.d("createChat", ex.toString())
                        result.error("createChat", ex.message, "")
                    }
                }

                "startCall",
                "answerCall",
                "rejectCall" -> {
                    try {
                        val type = when (call.method) {
                            "startCall" -> KaonicEventType.CALL_INVOKE
                            "answerCall" -> KaonicEventType.CALL_ANSWER
                            else -> KaonicEventType.CALL_REJECT
                        }
                        val address = call.argument<String>("address") ?: ""
                        val callId = call.argument<String>("callId") ?: ""
                        KaonicService.sendCallEvent(type, callId, address)

                        result.success(0)
                    } catch (ex: Exception) {
                        Log.d("sendTextMessageError", ex.toString())
                        result.error("sendTextMessageError", ex.message, "")
                    }
                }

            }
        }

        EventChannel(flutterEngine?.dartExecutor?.binaryMessenger, KAONIC_SERVICE_EVENT)
            .setStreamHandler(
                object : EventChannel.StreamHandler {
                    override fun onListen(arguments: Any?, events: EventChannel.EventSink?) {
                        KaonicService.eventSink = events
                    }

                    override fun onCancel(arguments: Any?) {
                        KaonicService.eventSink = null
                    }
                }
            )

        EventChannel(flutterEngine?.dartExecutor?.binaryMessenger, KAONIC_EVENT)
            .setStreamHandler(
                object : EventChannel.StreamHandler {
                    override fun onListen(arguments: Any?, events: EventChannel.EventSink?) {
//                        kaonic.eventSink = events
                    }

                    override fun onCancel(arguments: Any?) {
//                        kaonic.eventSink = null
                    }
                }
            )
    }


    override fun onRequestPermissionsResult(
        requestCode: Int,
        permissions: Array<out String>,
        grantResults: IntArray
    ) {
        super.onRequestPermissionsResult(requestCode, permissions, grantResults)
        if (requestCode == 1 && grantResults.isNotEmpty()) {
            initKaonicService()
            checkStoragePermission()
        }
    }


    private fun checkAudioPermission() {
        if (ContextCompat.checkSelfPermission(
                this,
                Manifest.permission.RECORD_AUDIO
            ) != PackageManager.PERMISSION_GRANTED
        ) {
            ActivityCompat.requestPermissions(
                this,
                arrayOf(Manifest.permission.RECORD_AUDIO),
                REQUEST_RECORD_AUDIO_PERMISSION
            )
        } else {
            initKaonicService()
        }
    }


    private fun initKaonicService() {
        checkStoragePermission()
        val ringtoneUri = RingtoneManager.getDefaultUri(RingtoneManager.TYPE_RINGTONE)
        val ringtone = RingtoneManager.getRingtone(this, ringtoneUri)
        Log.i("KAONIC", "initKaonicService")
        KaonicService.init(
            KaonicCommunicationManager(
                KaonicLib.getInstance(applicationContext),
                contentResolver,
                ringtone
            ),
            secureStorageHelper
        )
    }

    private fun checkStoragePermission() {
        if (ContextCompat.checkSelfPermission(
                this,
                Manifest.permission.WRITE_EXTERNAL_STORAGE
            ) != PackageManager.PERMISSION_GRANTED
        ) {
            ActivityCompat.requestPermissions(
                this,
                arrayOf(Manifest.permission.WRITE_EXTERNAL_STORAGE),
                REQUEST_STORAGE_PERMISSION
            )
        }
    }
}

