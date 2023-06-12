set keywordprg=:vert\ Man
au filetype *.c,*.h,*.cpp,*.hpp set filetype c.doxygen
au filetype *.c,*.h,*.cpp,*.hpp set tabstop=4
au filetype *.c,*.h,*.cpp,*.hpp set softtabstop=4
au filetype *.c,*.h,*.cpp,*.hpp set shiftwidth=4
au filetype *.c,*.h,*.cpp,*.hpp set noexpandtab=4
"autocmd BufWritePre *.c,*.h ClangFormat
autocmd FileType c setlocal tabstop=4 shiftwidth=4 expandtab
autocmd FileType cpp setlocal tabstop=4 shiftwidth=4 expandtab
