component(name, type, connections) {
  return {
    name: name,
    type: type,
    connections: connections
  };
}

component("ESC", "Electronic Speed Controller", {
  power: "Battery",
  signal: "Flight Controller"
})
