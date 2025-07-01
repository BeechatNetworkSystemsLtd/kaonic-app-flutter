package network.beechat.app.kaonic.models

import com.google.gson.annotations.SerializedName

data class ConnectivitySettings(
//    @SerializedName("id")
//    val id: Int = 0,
    @SerializedName("ip")
    val ip: String = "192.168.10.1",
    @SerializedName("port")
    val port: String = "8080",
    @SerializedName("connectivityType")
    val connectivityType: Int = 1
)