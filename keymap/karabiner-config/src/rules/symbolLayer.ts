import * as kt from "karabiner.ts"
import { JP, split } from "./commons"
import { IS_LOGICAL_SHIFT } from "./logicalShift"

const VAR_IS_SYMBOL_LAYER = "isSymbolLayer"

export const SYMBOL_LAYER = kt
  .rule("japanese_kana")
  .description("Symbol Layer")
  .condition(kt.ifDevice({ vendor_id: 1155, product_id: 22288 }, "Dumang"))
  .manipulators([
    kt
      .map("japanese_kana", "??")
      .toVar(VAR_IS_SYMBOL_LAYER, 1)
      .toAfterKeyUp(kt.toSetVar(VAR_IS_SYMBOL_LAYER, 0))
      .toIfAlone("japanese_kana"),

    kt.withModifier("??")([
      kt.withCondition(kt.ifVar(VAR_IS_SYMBOL_LAYER, 1, "symbol layer"))([
        kt.withMapper({
          r: JP["^"],
          u: JP["\\"],
          i: JP["["],
          o: JP["]"],
          "/": JP["\\"],

          n: JP["_"],
          x: JP["@"],
        } as const)((k, v) => kt.map(k).to(v)),

        // Function Keys
        kt.withMapper(split("asdfghjklio"))((k, i) =>
          kt
            .map(k)
            .to(`f${i + 1}` as kt.ToKeyParam)
            .condition(IS_LOGICAL_SHIFT),
        ),

        kt.map("japanese_eisuu").toVar("isLogicalShift", 1, 0),
        // Numbers
        kt.withMapper(split("asdfghjkl"))((k, i) =>
          kt.map(k, "??").to((i + 1) as kt.ToKeyParam),
        ),
        kt.map(";", "shift").to(JP["\\"], "shift"),
        kt.map(";", "any").to(0),
      ]),
    ]),
  ])
