#import "../config/acronyms.typ": *
#import "../config/functions.typ": *


= Abstract

Electronic circuit protection devices of the SENTRON #acro("ECPD") series measure current, voltage and active power for each final circuit and can be switched remotely through an associated data transceiver, the SENTRON Powercenter. The object model library supplied with the building management platform Desigo CC does not cover this device series, so every integration has so far been a one-off. The recurring effort of mapping Modbus registers to named data points is labour-intensive and arises anew in every project.

This thesis develops a reusable integration template for that purpose and validates it on a hardware test setup. The procedure follows the V-model. A system and stakeholder analysis yields eleven use cases, from these fifteen requirements and fourteen test cases, so that every decision embodied in the model remains traceable to an activity of a named user group.

The selection of data points forms the core of the work. A fully equipped line consisting of one Powercenter and 24 end devices comprises 5169 data points of the register map, which can neither be displayed meaningfully nor polled at the required rate. Seven selection criteria reduce this scope to 929 registers read and thereby lower the polling load by roughly 82 percent. The result consists of machine-readable type descriptions for both device types, a listing that records register, format and justification for every data point, and a document addressed to installers and operators.

Validation shows nine of the fifteen requirements to be met, three partially met and three not met. Measured values, meter readings, master data and the switch state appear complete and correctly labelled, and switching commands are executed and acknowledged. Alarming remains unresolved, since all messages reside in a single collective register that the tool chain used cannot decompose into individually evaluable states. The tests further confirm properties of the devices and of the platform that no data model can remedy, among them the remote switching release that can only be granted locally, alarm bits disabled by default, and a polling interval that can only be set for all devices at once.

For project business the assessment is therefore divided. As a template, the model removes the recurring mapping work and supports the monitoring and analysis of a distribution board from the control room. As a complete control room integration of a protection device it does not suffice as long as fault handling requires alarming to be engineered by hand for each installation.

/* Claude: Uebersetzung der Kurzfassung aus 002_Kurzfassung.typ, Absatz fuer
   Absatz deckungsgleich. Aendert sich die Kurzfassung, ist dieser Text
   mitzufuehren. Produktnamen (SENTRON Powercenter, Desigo CC, Powerconfig) und
   das Kuerzel ECPD bleiben unuebersetzt. */
