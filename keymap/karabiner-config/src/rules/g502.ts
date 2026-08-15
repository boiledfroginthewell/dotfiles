import * as kt from "karabiner.ts"

export const G502_RULE = kt
  .rule("G502 Mouse Keys")
  .condition(kt.ifDevice({ vendor_id: 1133, product_id: 49291 }, "G502"))
  .manipulators([
    kt.map("f21", "??").to("left_shift").toIfAlone("mission_control"),
    kt.map("f22", "??").to("left_control"),
    kt.map("return_or_enter", "??").to("left_option").toIfAlone("return_or_enter"),
    kt.map("left_arrow", "option").to("close_bracket", "command"),
    kt.map("right_arrow", "option").to("right_arrow", "command"),
  ])
