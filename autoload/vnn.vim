" Maintainer: obcat <obcat@icloud.com>
" License:    MIT License

scriptencoding utf-8
let s:save_cpo = &cpo
set cpo&vim


let s:arrow_up = [
  \ '    ━━━━━━    ',
  \ '      ╱╲      ',
  \ '     ╱  ╲     ',
  \ '    ╱    ╲    ',
  \ '    ─┐  ┌─    ',
  \ '     └──┘     ',
  \ ]

let s:arrow_down = [
  \ '     ┌──┐     ',
  \ '    ─┘  └─    ',
  \ '    ╲    ╱    ',
  \ '     ╲  ╱     ',
  \ '      ╲╱      ',
  \ '    ━━━━━━    ',
  \ ]

let s:bot2top_msg = get(g:, 'vnn_bot2top_msg', s:arrow_up)
let s:top2bot_msg = get(g:, 'vnn_top2bot_msg', s:arrow_down)
let s:popup_location = get(g:, 'vnn_popup_location', 'win_center')
let s:popup_time     = get(g:, 'vnn_popup_time', 800)
let s:popup_zindex   = get(g:, 'vnn_popup_zindex', 1000)
let s:popup_close_on_cursormoved = get(g:, 'vnn_popup_close_on_cursormoved', 1)

let s:popup_borderchars = ['─', '│', '─', '│', '┌', '┐', '┘', '└']
let s:popup_border_int = 1
let s:popup_border = repeat([s:popup_border_int], 4)
let s:popup_padding_int = 0
let s:popup_padding = repeat([s:popup_padding_int], 4)
let s:popup_moved = s:popup_close_on_cursormoved ? 'any' : [0, 0, 0]

hi default link VnnPopup WarningMsg


func! s:getcurpos() abort
  return #{line: line('.'), col: col('.')}
endfunc

func! s:searchforward(n) abort
  return a:n ? !v:searchforward : v:searchforward
endfunc

func! s:pos_less_than(pos1, pos2) abort
  return a:pos1.line != a:pos2.line ?
    \ a:pos1.line < a:pos2.line
    \:a:pos1.col < a:pos2.col
endfunc

func! s:get_popup_coord(msg) abort
  let l:coord = {}
  if s:popup_location ==# 'vim_center'
    let l:coord.pos = 'center'
  else " win_center
    let l:coord.pos = 'topleft'
    let [l:coord.line, l:coord.col] = win_screenpos(winnr())
    let l:coord.line += (winheight(0) - len(a:msg)) / 2
    let l:coord.line -= s:popup_border_int + s:popup_padding_int
    let l:coord.col += (winwidth(0) - max(map(copy(a:msg), {_, s -> strwidth(s)}))) / 2
    let l:coord.col -= s:popup_border_int + s:popup_padding_int
  endif
  return l:coord
endfunc

func! s:get_popup_options(msg) abort
  let l:options = #{
    \ borderchars: s:popup_borderchars,
    \ border:  s:popup_border,
    \ padding: s:popup_padding,
    \ time:  s:popup_time,
    \ moved: s:popup_moved,
    \ zindex: s:popup_zindex,
    \ highlight: 'VnnPopup',
    \ wrap: 0,
    \ }
  call extend(l:options, s:get_popup_coord(a:msg))
  return l:options
endfunc

func! s:popup_create(msg) abort
  call popup_create(a:msg, s:get_popup_options(a:msg))
endfunc


func! vnn#begin() abort
  let s:prev_pos = s:getcurpos()
endfunc

func! vnn#end(...) abort
  let s:curr_pos = s:getcurpos()
  if s:searchforward(a:0) && s:pos_less_than(s:curr_pos, s:prev_pos)
    call s:popup_create(s:bot2top_msg)
  elseif !s:searchforward(a:0) && s:pos_less_than(s:prev_pos, s:curr_pos)
    call s:popup_create(s:top2bot_msg)
  endif
endfunc


let &cpo = s:save_cpo
unlet s:save_cpo
