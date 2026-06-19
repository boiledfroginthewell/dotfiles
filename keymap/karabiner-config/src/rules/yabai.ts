import * as kt from "karabiner.ts"
import { JP } from "./commons"

const yabaiBin = "/opt/homebrew/bin/yabai"

function yabai(...args: string[]): string {
  return args.map(argset => `${yabaiBin} ${argset}`).join(" || ")
}

function yabaiFocus(direction: "north" | "east" | "south" | "west"): string {
  return yabai(`-m window --focus ${direction} || ${yabaiBin} -m display --focus ${direction}`)
  // return yabai(`-m window --focus ${direction}`)
}

function yabaiSwap(direction: "north" | "east" | "south" | "west"): string {
  return yabai(`-m window --swap ${direction}`)
}

export const YABAI_RULE = kt.rule("Yabai").manipulators([
  kt.withModifier(["option", "command"])([
    // Window management
    kt.map("h").to$(yabaiFocus("west")),
    kt.map("j").to$(yabaiFocus("south")),
    kt.map("k").to$(yabaiFocus("north")),
    kt.map("l").to$(yabaiFocus("east")),

    kt.map("h", "shift").to$(yabaiSwap("west")),
    kt.map("j", "shift").to$(yabaiSwap("south")),
    kt.map("k", "shift").to$(yabaiSwap("north")),
    kt.map("l", "shift").to$(yabaiSwap("east")),

    kt.map("q").to$(yabai("-m window --resize left:-50:0", "-m window --resize right:50:0")),
    kt.map(JP[":"]).to$(yabai("-m window --resize right:-50:0", "-m window --resize left:50:0")),

    kt.map("y").to$(yabai("-m window --toggle zoom-fullscreen")),

    // Space management
    kt.map("d").to$(yabai("-m space --focus prev")),
    kt.map("f").to$(yabai("-m space --focus next")),

    kt.map("i").to$(yabai("-m space --create")),
    kt.map("w").to$(yabai("-m space --destroy")),
  ]),
])
