# vnn.vim

vnn scans wrapscan!

![vnn](https://user-images.githubusercontent.com/64692680/97264693-c83c6a00-1868-11eb-9739-21e318a316a2.gif)

## Usage

```vim
nnoremap <silent> n :<C-u>call vnn#begin()<CR>:norm! n<CR>:call vnn#end()<CR>
nnoremap <silent> N :<C-u>call vnn#begin()<CR>:norm! N<CR>:call vnn#end(1)<CR>
nnoremap <silent> * :<C-u>call vnn#begin()<CR>:norm! *<CR>:call vnn#end()<CR>
nnoremap <silent> # :<C-u>call vnn#begin()<CR>:norm! #<CR>:call vnn#end()<CR>
```

## License

MIT License.
