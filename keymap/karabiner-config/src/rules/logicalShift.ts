import * as kt from "karabiner.ts"
import { JP } from "./commons"

const VAR_NAME = "isLogicalShift"

export const IS_LOGICAL_SHIFT = kt.ifVar(VAR_NAME, 1, "Is logical shift?")

export const LOGICAL_SHIFT_LAYER = kt
  .layer("japanese_eisuu", VAR_NAME)
  .description("Logical Shift")
  .manipulators([
    kt.withMapper([1, 2, 3, 4, 5, 6, 7, 8, 9, 0, "-", JP["^"]] as const)(
      (k, i) => kt.map(k, "??").to(`f${i + 1}` as kt.ToKeyParam),
    ),

    kt.withMapper<kt.FromKeyParam, kt.ToKeyParam>({
      q: "escape",
      w: "delete_forward",
      e: "home",
      r: "end",
      i: "return_or_enter",

      h: "←",
      j: "↓",
      k: "↑",
      l: "→",

      d: "page_up",
      f: "page_down",
    })((k, v) => kt.map(k, "??").to(v)),

    kt.withMapper(["z", "x", "c", "v", "s"])((k) =>
      kt.map(k, "??").to(k, "left_command"),
    ),

    kt.map("delete_or_backspace", "??").to(JP["]"], "left_command"),

    Array(4)
      .fill(null)
      .reduce((bind) => bind.to("spacebar"), kt.map("tab", "??")),
  ])
