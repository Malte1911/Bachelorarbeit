// Dictionary with acronyms
#let acronyms = (
  DHBW: "Duale Hochschule Baden-Württemberg",
  FSG: "Formula Student Germany",
  DVPC: "Driverless Vehicle PC",
  CoG: "Center of Gravity",
  CPU: "Central Processing Unit",
  PC: "Personal Computer",
  SLS: "Selective Laser Sintering",
  W: "Watt",
  V: "Volt",
  mm: "Millimeter",
  A: "Ampere",
  LV: "Low Voltage",
  LIDAR: "Light Detection and Ranging",
  DV: "Driverless Vehicle",
  AS: "Autonomes System",
  CAD: "Computer-Aided Design",
  CFD: "Computational Fluid Dynamics",
  SLM: "Selektives Laserstrahlschmelzen",
  PCB: "Printed Circuit Board",
  EMV: "elektromagnetische Verträglichkeit",
  RCU: "Rear Control Unit",
  GPU: "Graphics Processing Unit",
  TTP: "thermal transfer plate",
  NTC: "negativer Temperaturkoeffizient",
  CNC: "Computer Numverical Control",
  HiL: "Hardware in the Loop",
  RAM: "Random Access Memory",
  HZ: "hochohmig",
  ESD: "Electrostatic Discharge",
  OCP: "Over Current Protection",
  SMD: "Surface Mounted Device",
  LED: "Light Emitting Diode",
  ESR: "Equivalent Series Resistance",
  HV: "High Voltage",
  CAN: "Controller Area Network"
)

// Tracking used acronyms
#let usedAcronyms = state("usedDic", (:))

#let acro(body) = {
  if(acronyms.keys().contains(body) == false) {
    return rect(
      fill: red,
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
