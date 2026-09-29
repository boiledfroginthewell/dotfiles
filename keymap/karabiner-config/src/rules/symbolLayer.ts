import * as kt from "karabiner.ts"
import { IS_DUMANG, JP, split } from "./commons"
import * as logicalShift from "./logicalShift"

const VAR_IS_SYMBOL_LAYER = "isSymbolLayer"

export const SYMBOL_LAYER = kt
  .rule("japanese_kana")
  .description("Symbol Layer")
  .condition(IS_DUMANG)
  .manipulators([
    kt
      .map("japanese_kana", "??")
      .toVar(VAR_IS_SYMBOL_LAYER, 1)
      .toAfterKeyUp(kt.toSetVar(VAR_IS_SYMBOL_LAYER, 0))
      .toIfAlone("japanese_kana"),

    kt.withModifier("??")([
      kt.withCondition(kt.ifVar(VAR_IS_SYMBOL_LAYER, 1, "symbol layer"))([
        // w/ logical shift
        kt.map("japanese_eisuu").toVar(logicalShift.LOGICAL_SHIFT_VAR, 1, 0),

        kt.withCondition(logicalShift.IS_LOGICAL_SHIFT)([
          // Function Keys
          kt.withMapper(split("asdfghjkl;io"))((k, i) =>
            kt.map(k).to(`f${i + 1}` as kt.ToKeyParam),
          ),
        ]),

        // only symbol layer
        kt.withMapper({
          r: JP["^"],
          u: JP["\\"],
          i: JP["["],
          o: JP["]"],
          "/": JP["\\"],

          n: JP["_"],
          x: JP["@"],
        } as const)((k, v) => kt.map(k).to(v)),

        // Numbers
        kt.withMapper(split("asdfghjkl"))((k, i) =>
          kt.map(k, "??").to((i + 1) as kt.ToKeyParam),
        ),
        kt.map(";", "shift").to(JP["\\"], "shift"),
        kt.map(";", "any").to(0),
      ]),
    ]),
  ])
