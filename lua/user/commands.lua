vim.opt.termguicolors = true

vim.cmd([[
	autocmd FileType sql setlocal omnifunc=vim_dadbod_completion#omni
	au BufRead,BufNewFile *.jq setfiletype jq
    	colorscheme bluedream    
    	syntax off
    	set number
    	set shiftwidth=0
    	set noswapfile
    	set relativenumber
	set showtabline=0
]])
