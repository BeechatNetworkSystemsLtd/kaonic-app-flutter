package network.beechat.app.kaonic

import android.Manifest
import android.content.pm.PackageManager
import android.media.RingtoneManager
import android.os.Bundle
import android.util.Log
import androidx.core.app.ActivityCompat
import androidx.core.content.ContextCompat
import androidx.core.content.FileProvider
import com.google.gson.Gson
import io.flutter.embedding.android.FlutterActivity
import io.flutter.plugin.common.EventChannel
import io.flutter.plugin.common.MethodChannel
import kotlinx.coroutines.CoroutineScope
import kotlinx.coroutines.Dispatchers
import kotlinx.coroutines.SupervisorJob
import network.beechat.app.kaonic.models.ConnectivitySettings
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
                
                "myAddress" -> {
                    result.success(KaonicService.myAddress)
                }

                "sendConfig", "sendConfigure" -> {
                    try {
                        val mcs = call.argument<Int>("mcs") ?: 0
                        val optionNumber = call.argument<Int>("optionNumber") ?: 0
                        val module = call.argument<Int>("module") ?: 0
                        val frequency = call.argument<Int>("frequency") ?: 0
                        val channel = call.argument<Int>("channel") ?: 0
                        val channelSpacing = call.argument<Int>("channelSpacing") ?: 0
                        val txPower = call.argument<Int>("txPower") ?: 0
                        val bt = call.argument<Int>("bt") ?: 0
                        val midxs = call.argument<Int>("midxs") ?: 0
                        val midxsBits = call.argument<Int>("midxsBits") ?: 0
                        val mord = call.argument<Int>("mord") ?: 0
                        val srate = call.argument<Int>("srate") ?: 0
                        val pdtm = call.argument<Int>("pdtm") ?: 0
                        val rxo = call.argument<Int>("rxo") ?: 0
                        val rxpto = call.argument<Int>("rxpto") ?: 0
                        val mse = call.argument<Int>("mse") ?: 0
                        val fecs = call.argument<Int>("fecs") ?: 0
                        val fecie = call.argument<Int>("fecie") ?: 0
                        val sfd32 = call.argument<Int>("sfd32") ?: 0
                        val csfd1 = call.argument<Int>("csfd1") ?: 0
                        val csfd0 = call.argument<Int>("csfd0") ?: 0
                        val sfd = call.argument<Int>("sfd") ?: 0
                        val dw = call.argument<Int>("dw") ?: 0

                        KaonicService.sendConfig(
                            mcs,
                            optionNumber,
                            module,
                            frequency,
                            channel,
                            channelSpacing,
                            txPower,
                            bt,
                            midxs,
                            midxsBits,
                            mord,
                            srate,
                            pdtm,
                            rxo,
                            rxpto,
                            mse,
                            fecs,
                            fecie,
                            sfd32,
                            csfd1,
                            csfd0,
                            sfd,
                            dw
                        )

                        result.success(true)
                    } catch (ex: Exception) {
                        Log.d("sendConfig", ex.toString())
                        result.error("sendConfig", ex.message, "")
                    }
                }
                "startService" -> {
                    val json = call.argument<String>("connectivity")

                    val gson = Gson()
                    val connectivitySettings = gson.fromJson(json, ConnectivitySettings::class.java)

                    initKaonicService(connectivitySettings)
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
//            initKaonicService()
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
        }
//        else {
//            initKaonicService()
//        }
    }


    private fun initKaonicService(connectivitySettings: ConnectivitySettings) {
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
            secureStorageHelper,
            connectivitySettings,
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

