#import "colors.typ": *

// Dictionary with acronyms
#let acronyms = (
  DHBW: "Duale Hochschule Baden-Württemberg",
  SPS: "speicherprogrammierbare Steuerung",
  RTU: "Remote Terminal Unit",
  ASCII: "American Standard Code for Information Interchange",
  TCP: "Transmission Control Protocol",
  IP: "Internet Protocol",
  ECPD: "Electronic Circuit Protection Device",
  JSON: "JavaScript Object Notation",
  MQTT: "Message Queuing Telemetry Transport",
  VPN: "Virtual Private Network",
  HTTP: "Hypertext Transfer Protocol",
  HTTPS: "Hypertext Transfer Protocol Secure",
  API: "Application Programming Interface",
  PDE: "Power Device Engineer",
  BLOB: "Binary Large Object",
  BCD: "Binary Coded Decimal",
  BLE: "Bluetooth Low Energy",
  SNMP: "Simple Network Management Protocol",
  COV: "Change of Value",
  RCD: "Residual Current Device",
  RCM: "Residual Current Monitoring",
  ARD: "Automatic Reclosing Device",
  DGUV: "Deutsche Gesetzliche Unfallversicherung",
  CSV: "Comma-Separated Values",
  DPT: "Data Point Type",
  DPE: "Data Point Element"
)

// Tracking used acronyms
#let usedAcronyms = state("usedDic", (:))

#let acro(body) = {
  if(acronyms.keys().contains(body) == false) {
    return rect(
      fill: sie_red,
      inset: 8pt,
      radius: 4pt,
      [*Warning: #body*],
    )
  }
  context {
    let usedDic = usedAcronyms.get()
    // This may throw off some vs code plugins but it works
    if(usedDic.keys().contains(body)) {
      link(label("acro-" + body))[#body]
    } else {
      usedAcronyms.update(usedDic => {
        usedDic.insert(body, true)
        return usedDic
      })
      link(label("acro-" + body))[#acronyms.at(body) (#body)]
    }
  }
}

// Simplified function to display the list of used acronyms
#let printAcronyms = {
  context {
    let used = usedAcronyms.final()
    for key in acronyms.keys().sorted() {
      if used.keys().contains(key) {
        grid(
          columns: (1fr, 3fr),
          gutter: 1em,
          [#strong(key) #label("acro-" + key)], acronyms.at(key)
        )
        //linebreak()
        v(0.2em)
      }
    }
  }
}
