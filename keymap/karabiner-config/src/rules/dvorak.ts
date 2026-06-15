import * as kt from "karabiner.ts"
import { JP, split, toDict } from "./commons"

export const DVORAK_LAYOUT_RULE = kt
  .rule("Dvorak Layout")
  .description(
    "Remap keys to use Dvorak keyboard layout for logical bit pairing",
  )
  .manipulators([
    // 1st row
    kt.map("-", "??").to(JP["@"]),
    kt.map(0, "shift", "any").to(JP["\\"], "shift"),

    // 2nd row
    kt.withMapper<kt.FromKeyParam, kt.ToKeyParam>(
      toDict(split("qwertyuiop["), split(":,.pyfgcrl/")),
    )((k, v) => kt.map(k, "??").to(v)),

    // 3rd row
    kt.withMapper<kt.FromKeyParam, kt.ToKeyParam>(
      toDict(split("asdfghjkl;:"), split("aoeuidhtns-")),
    )((k, v) => kt.map(k, "??").to(v)),

    // 4th row
    kt.withMapper<kt.FromKeyParam, kt.ToKeyParam>(
      toDict(split("zxcvbnm,./"), split(";qjkxbmwvz")),
    )((k, v) => kt.map(k, "??").to(v)),
    kt.map(JP["_"], "??").to(JP["\\"]),
  ])
