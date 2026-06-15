import * as kt from "karabiner.ts"
import { JP, split } from "./commons"
import { IS_LOGICAL_SHIFT } from "./logicalShift"

export const SYMBOL_LAYER = kt
  .layer("japanese_kana", "isNumLayer")
  .description("Logical Shift")
  .condition(kt.ifDevice({ vendor_id: 1155, product_id: 22288 }, "Dumang"))
  .manipulators([
    kt.withMapper({
      r: JP["^"],
      u: JP["\\"],
      i: JP["["],
      o: JP["]"],
      "/": JP["\\"],

      n: JP["_"],
      x: JP["@"],
    } as const)((k, v) => kt.map(k, "??").to(v)),
    kt.map(";", "shift", "any").to(JP["\\"], "shift"),

    // Numbers
    kt.withMapper(split("asdfghjkl"))((k, i) =>
      kt.map(k, "??").to((i + 1) as kt.ToKeyParam),
    ),
    kt.map(";", "any").to(0),

    // Function Keys
    kt.withMapper(split("asdfghjklio"))((k, i) =>
      kt
        .map(k, "??")
        .to(`f${i + 1}` as kt.ToKeyParam)
        .condition(IS_LOGICAL_SHIFT),
    ),
  ])
