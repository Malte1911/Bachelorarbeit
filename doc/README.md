# DHBW Typst Vorlage

Diese Vorlage ist für die DHBW Stuttgart konzipiert, die Formattierung kann von DH zu DH/Uni zu Uni oder sogar von Studiengang zu Studiengang abweichen. Alle Einstellungen können in config/constants bearbeitet werden und sollten dann automatisch angewendet werden.

## Typst

See [Typst Installation](https://github.com/typst/typst?tab=readme-ov-file#installation)

## Build

```shell
typst compile main.typ
```

```shell
typst watch main.typ
```

## File Structure

### config

- config.typ
- constants.typ
- cover.typ
- functions.typ

### content

- Chapters and imports of sections and subsections
*Note*: The structure is only a proposal another popular approach would be to split the "hauptteil" into concept/analysis and implementation.

### resources

- images
- PDFs
  - https://github.com/frozolotl/muchpdf
  - https://typst.app/universe/package/muchpdf/
