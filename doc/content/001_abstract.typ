#import "../config/acronyms.typ": *
#import "../config/functions.typ": *


#set text(lang: "en")

= Abstract

Devices of the SENTRON #acro("ECPD") series measure current, voltage and active power per final circuit and can be switched remotely via the SENTRON Powercenter. The series is absent from the Desigo CC object model library, so every integration has so far been a one-off.

The thesis was written at Siemens AG, which owns both product lines. It develops a reusable integration template and validates it on hardware. Following the V-model, system and stakeholder analysis yields 10 use cases, from these 15 requirements and 14 test cases, keeping every decision traceable to a named user group.

Data point selection forms the core. A line of Powercenter and end device comprises 363 register entries, each further device 152 more. Seven criteria reduce this to 53 registers read, roughly 85 percent fewer register map entries. The result comprises machine-readable type descriptions for both devices, a listing of register, format and justification, and a document for installers and operators.

Validation shows 10 of 15 requirements met, three partially and two not. Measured values, meter readings, master data and switch state are complete and correctly labelled, switching commands are executed and acknowledged. Alarming remains unresolved, since all messages reside in one collective register the tool chain cannot decompose into individual states.

The verdict is divided. As a template the model removes the recurring mapping work and carries control room analysis of a distribution board. As a full control room integration it does not suffice while the messages are unavailable individually.

/* Claude: Uebersetzung der Kurzfassung aus 002_Kurzfassung.typ, Absatz fuer
   Absatz deckungsgleich, hoechstens 250 Woerter. Aendert sich die Kurzfassung,
   ist dieser Text mitzufuehren. Produktnamen (SENTRON Powercenter, Desigo CC,
   Powerconfig) und das Kuerzel ECPD bleiben unuebersetzt.

   Zahlen folgen der technisch-naturwissenschaftlichen Konvention (IEEE, Chicago
   alternative rule): ausgeschrieben bis neun, als Ziffer ab 10. Das laeuft
   parallel zur deutschen Regel in der Kurzfassung, wo die Grenze bei zwoelf
   liegt. "three partially and two not" bleibt deshalb ausgeschrieben, obwohl
   sich die Angabe auf dieselben 15 Anforderungen bezieht. */
