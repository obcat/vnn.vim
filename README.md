# vnn.vim

vnn scans wrapscan!

![vnn](https://user-images.githubusercontent.com/64692680/97259228-a38ec500-185d-11eb-98eb-c33c1b20eb51.gif)

## Usage

```vim
nnoremap <silent> n :<C-u>call vnn#begin()<CR>:norm! n<CR>:call vnn#end()<CR>
nnoremap <silent> N :<C-u>call vnn#begin()<CR>:norm! N<CR>:call vnn#end(1)<CR>
nnoremap <silent> * :<C-u>call vnn#begin()<CR>:norm! *<CR>:call vnn#end()<CR>
nnoremap <silent> # :<C-u>call vnn#begin()<CR>:norm! #<CR>:call vnn#end()<CR>
```

## License

MIT License.
