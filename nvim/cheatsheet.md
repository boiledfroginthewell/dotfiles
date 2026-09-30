:Cheat -- Vim Cheat Sheet
==========================
gM -- 行の中心にカーソル移動
<C-o/i> -- ジャンプ履歴
^t/h -- インデント移動
*/g* -- 単語検索／置換
^w{+-<>} -- リサイズ
:'<,'>! -- Shellコマンド置換
@: -- Run last Ex command
,p -- yank history picker

## Programming
<M-f/left/down> -- Accept Windsurf Suggestion
<C-d/n> -- Jump snippet placeholders

## Visual Mode
gv -- Select last visual selection
o -- Swap start and end

## [/] moves
c -- git changes
a -- Aerial
x -- conflicts
q -- quick fixes
p -- paste history

## Operators
[ga{ulsdncp}](https://github.com/johmsalas/text-case.nvim/wiki/String-Case-functions) -- Text Case (UPPER/lower/snake/dash/CONSTANT/camel/pascal)
## Text Objects
<Tab> -- Indent
iw -- word

## LSP
<F2> -- Rename (grr)
<F4> -- Code Actions (gra)
,f -- format
T  -- hover()
,H -- call hierarchy
gri -- implementation()
gs -- Signature Help

## Git
,hs -- stage hunk
,hr -- reset hunk
,hp -- undo staging hunk
gadd -- git add
:GitConflictChoose{Ours,Theirs}
:LineDiff

## Spelunker
Zl -- correct word
Zg -- add word to dict
