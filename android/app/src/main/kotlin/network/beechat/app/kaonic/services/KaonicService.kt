package network.beechat.app.kaonic.services

import android.util.Log
import androidx.compose.runtime.mutableStateListOf
import com.fasterxml.jackson.databind.ObjectMapper
import io.flutter.plugin.common.EventChannel
import kotlinx.coroutines.CoroutineScope
import kotlinx.coroutines.Dispatchers
import kotlinx.coroutines.flow.MutableSharedFlow
import kotlinx.coroutines.flow.SharedFlow
import kotlinx.coroutines.launch
import network.beechat.kaonic.audio.AudioService
import network.beechat.kaonic.communication.KaonicCommunicationManager
import network.beechat.kaonic.communication.KaonicEventListener
import network.beechat.kaonic.models.KaonicEvent
import network.beechat.kaonic.models.KaonicEventData
import network.beechat.kaonic.models.KaonicEventType
import network.beechat.kaonic.models.calls.CallAudioData
import network.beechat.kaonic.models.connection.Connection
import network.beechat.kaonic.models.connection.ConnectionConfig
import network.beechat.kaonic.models.connection.ConnectionContact
import network.beechat.kaonic.models.connection.ConnectionInfo
import network.beechat.kaonic.models.connection.ConnectionType

object KaonicService : KaonicEventListener {
    private val TAG = "KaonicService"
    private lateinit var kaonicCommunicationHandler: KaonicCommunicationManager
    private lateinit var secureStorageHelper: SecureStorageHelper
    private lateinit var audioService: AudioService
    private val objectMapper: ObjectMapper = ObjectMapper()

    /// list of nodes
    private val _contacts = mutableStateListOf<String>()
    val contacts = _contacts

    /// stream of kaonic events
    private val _events = MutableSharedFlow<KaonicEvent<KaonicEventData>>()
    val events: SharedFlow<KaonicEvent<KaonicEventData>> = _events
    var eventSink: EventChannel.EventSink? = null

    private var _myAddress = ""
    val myAddress: String
        get() = _myAddress

    fun init(
        kaonicCommunicationHandler: KaonicCommunicationManager,
        secureStorageHelper: SecureStorageHelper
    ) {
        this.kaonicCommunicationHandler = kaonicCommunicationHandler
        this.secureStorageHelper = secureStorageHelper
        audioService = AudioService()
        kaonicCommunicationHandler.setEventListener(this)
        _myAddress = kaonicCommunicationHandler.myAddress

        kaonicCommunicationHandler.start(
            loadSecret(),
            ConnectionConfig(
                ConnectionContact("Kaonic"), arrayListOf(
                    Connection(
                        ConnectionType
                            .TcpClient, ConnectionInfo("192.168.1.142:4242")
                    )
                )
            )
        )
        print("")
    }

    fun createChat(address: String, chatId: String) {
        kaonicCommunicationHandler.createChat(address, chatId)
    }

    fun sendTextMessage(message: String, address: String, chatId: String) {
        kaonicCommunicationHandler.sendMessage(address, message, chatId)
    }

    fun sendFileMessage(filePath: String, address: String, chatId: String) {
        kaonicCommunicationHandler.sendFile(filePath, address, chatId)
    }

    fun sendBroadcast(id: String, topic: String, bytes: ByteArray) {
        kaonicCommunicationHandler.sendBroadcast(id, topic, bytes)
    }

    fun sendCallEvent(callEvent: String, callId: String, address: String) {
        kaonicCommunicationHandler.sendCallEvent(callEvent, address, callId)
    }

    fun sendConfig(
        mcs: Int,
        optionNumber: Int,
        module: Int,
        frequency: Int,
        channel: Int,
        channelSpacing: Int,
        txPower: Int
    ) {
        kaonicCommunicationHandler.sendConfig(
            mcs,
            optionNumber,
            module,
            frequency,
            channel,
            channelSpacing,
            txPower
        )
    }

    override fun onEventReceived(event: KaonicEvent<KaonicEventData>) {
        CoroutineScope(Dispatchers.Main).launch {
            val jsonString = objectMapper.writeValueAsString(event)
            if (event.type == KaonicEventType.CALL_AUDIO) {
                val callAudioData = event.data as CallAudioData
                audioService.play(callAudioData.bytes, callAudioData.bytes.size)
            } else {
                eventSink?.success(jsonString)
            }

        }
    }

    private fun loadSecret(): String? {
        var secret: String? = null
        try {
            val SECRET_TAG = "KAONIC_SECRET"
            secret = secureStorageHelper.getSecured(SECRET_TAG)
            if (secret == null) {
                val messengerCreds = kaonicCommunicationHandler.generateSecret()
                secret = messengerCreds?.secret ?: ""
                secureStorageHelper.putSecured(SECRET_TAG, secret)
            }
        } catch (e: Exception) {
            Log.e(TAG, e.message ?: "")
        }
        return secret
    }
}