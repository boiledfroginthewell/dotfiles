import * as kt from "karabiner.ts"
import { DVORAK_LAYOUT_RULE } from "./rules/dvorak"
import { LOGICAL_SHIFT_LAYER } from "./rules/logicalShift"
import { SYMBOL_LAYER } from "./rules/symbolLayer"
import { RETURN_CTRL_RULE } from "./rules/returnCtrl"
import { remoteFile } from "./rules/commons"

const profileName = process.argv[2] || "--dry-run"

;(async () => {
  kt.writeToProfile(profileName, [
    DVORAK_LAYOUT_RULE,
    LOGICAL_SHIFT_LAYER,
    SYMBOL_LAYER,
    RETURN_CTRL_RULE,
    kt.importJson(
      await remoteFile(
        "https://ke-complex-modifications.pqrs.org/json/swap_yen_and_backslash_jis.json",
      ),
    ),
  ])
})()
