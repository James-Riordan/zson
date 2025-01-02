{
  name: "VR Headset",
  components: {
    controllers: {
      connection: {
        type: "Wireless",
        protocol: "Bluetooth",
        range: "10m"
      }
    },
    headset: {
      display: "4K OLED",
      sensors: ["Accelerometer", "Gyroscope"]
    }
  }
}
