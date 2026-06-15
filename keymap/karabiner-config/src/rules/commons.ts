import * as kt from "karabiner.ts"
import { promises as fs } from "fs"
import * as path from "path"
import { tmpdir } from "os"

export const JP = {
  colon: "quote",
  ":": "quote",
  hat: "equal_sign",
  "^": "equal_sign",
  open_bracket: "close_bracket",
  "[": "close_bracket",
  close_bracket: "backslash",
  "]": "backslash",
  at: "open_bracket",
  "@": "open_bracket",
  underscore: "international1",
  _: "international1",
  backslash: "international3",
  "\\": "international3",
} as const

export function toDict<T extends string | number, U extends string | number>(
  a: T[],
  b: U[],
): Record<kt.FromKeyParam, kt.ToKeyParam> {
  const result: Partial<Record<T, U>> = {}
  for (let i = 0; i < a.length; i++) {
    result[a[i]] = b[i]
  }
  // @ts-ignore
  return result
}

export function split(value: string): kt.FromKeyParam[] {
  // @ts-ignore
  return value.split("").map((char) => JP[char] || char)
}

export async function remoteFile(url: string): Promise<string> {
  const response = await fetch(url)
  const content = await response.text()

  const tempDir = await fs.mkdtempDisposable(
    path.join(tmpdir(), "karabiner-ts-"),
  )
  const outputPath = path.join(
    tempDir.path,
    url.split("/").at(-1) || "remote.json",
  )
  await fs.writeFile(outputPath, content)
  return outputPath
}
