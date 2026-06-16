import * as kt from "karabiner.ts"

export const RETURN_CTRL_RULE = kt
  .rule("Change return to control")
  .description(
    "Change return to control if pressed with other keys, to return if pressed alone",
  )
  .manipulators([
    kt
      .map("return_or_enter", "??")
      .to("right_control")
      .toIfAlone("return_or_enter"),
  ])

export const SANDS_RULE = kt
  .rule("SandS")
  .description(
    "Change spacebar to left_shift if pressed with other keys (Post spacebar when pressed alone)",
  )
  .manipulators([
    kt.map("spacebar", "??").to("left_shift").toIfAlone("spacebar"),
  ])

export const CTRL_KANA_RULE = kt
  .rule("Ctrl KanaS")
  .description(
    "Hold kana to input control",
  )
  .manipulators([
    kt.map("japanese_kana", "??").to("right_control").toIfAlone("japanese_kana"),
  ])
