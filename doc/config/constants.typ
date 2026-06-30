// Document variables
#let title = "Entwicklung einer Integrationsvorlage zwischen elektronischen Schaltkreisschutzgeräten und einer Gebäudemanagementplattform"
#let author = "Malte Schröter"
#let date = "26.04.2026"
#let matriculation_number = "9353886"
#let course = "TES23" // Example: TEL01GR1 / ITA23
#let period = "Oktober 2025 bis April 2026"
#let degree = "Bachelor of Engineering"
#let department = "Embedded Systems" // Example: Informatik, Wirtschaftsinformatik, Elektrotechnik, Maschinenbau
#let location_university = "Stuttgart" // Example: Stuttgart, Mannheim, Ravensburg
#let company_name = "Siemens AG" // 
#let company_location = "12345 Ausbildungsfirmaort"
#let release_location = "Ausbildungsfirmaort"
#let tutor = "Frederic Findeis"
#let evaluator = "Frederic Findeis"
#let show_company = false // Show company information in cover page

// Document type
// Uncomment the appropriate document type
//#let document_type = "T3_1000" // Praxisarbeit (Semester 1 & 2)
//#let document_type = "T3_2000" // Praxisarbeit (Semester 3 & 4)
//#let document_type = "T3_2001" // Praxisarbeit, Teil 1 (Semester 3, Teil 1)
// #let document_type = "T3_2002" // Praxisarbeit, Teil 2 (Semester 4, Teil 2)
// #let document_type = "T3_3000" // Praxisarbeit (Semester 5)
// #let document_type = "T3_3100" // Studienarbeit (Semester 5 & 6)
#let document_type = "T3_3300" // Bachelor Arbeit (Semester 6)

// Document type phrases
#let document_type_phrases = (
  "T3_1000": "Projektarbeit T1000",
  "T3_2000": "Projektarbeit T2000",
  "T3_2001": "Projektarbeit T2000, Teil 1",
  "T3_2002": "Projektarbeit T2000, Teil 2",
  "T3_3000": "Projektarbeit T3000",
  "T3_3100": "Studienarbeit",
  "T3_3300": "Bachelorarbeit",
)

// Get document type phrase
#let document_type_phrase = document_type_phrases.at(document_type)
#let study_program = "des Studienganges " + department
#let university = "an der Dualen Hochschule Baden-Württemberg " + location_university

// Function to check document type
#let is_doc_type(type) = {
  document_type == type
}

