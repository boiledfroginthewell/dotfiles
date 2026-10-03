import * as kt from "karabiner.ts"
import { IS_DUMANG } from "./commons"

function mappings(): Array<kt.BasicManipulatorBuilder> {
  return [
    kt.map("s").to$("open -b org.mozilla.firefox"),
    kt.map("d").to$("open -b com.github.wez.wezterm"),
    kt.map("v").to$("open -b com.tinyspeck.slackmacgap"),
    kt.map("m").to$("open -b com.usebruno.app"),
    kt.map("p").to$("open -b com.electron.logseq"),
  ]
}

export const APP_LAYER = kt
  .rule("Change return to control")
  .manipulators([kt.withModifier(["command", "option"])(mappings())])

export const APP_LAYER_DUMMANG = kt
  .layer("application", "isAppLayer")
  .condition(IS_DUMANG)
  .manipulators(mappings())
