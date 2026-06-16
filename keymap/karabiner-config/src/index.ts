import * as kt from "karabiner.ts"
import { DVORAK_LAYOUT_RULE } from "./rules/dvorak"
import { LOGICAL_SHIFT_LAYER } from "./rules/logicalShift"
import { SYMBOL_LAYER } from "./rules/symbolLayer"
import {
  CTRL_KANA_RULE,
  RETURN_CTRL_RULE,
  SANDS_RULE,
} from "./rules/multiPurpose"
import { G502_RULE } from "./rules/g502"

const profileName = process.argv[2] || "--dry-run"

;(async () => {
  kt.writeToProfile(profileName, [
    G502_RULE,
    SANDS_RULE,
    RETURN_CTRL_RULE,
    SYMBOL_LAYER,
    CTRL_KANA_RULE,
    LOGICAL_SHIFT_LAYER,
    DVORAK_LAYOUT_RULE,
    // kt.importJson(
    //   await remoteFile(
    //     "https://ke-complex-modifications.pqrs.org/json/swap_yen_and_backslash_jis.json",
    //   ),
    // ),
  ])
})()
