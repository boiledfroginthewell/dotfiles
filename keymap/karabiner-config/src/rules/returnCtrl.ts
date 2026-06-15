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
