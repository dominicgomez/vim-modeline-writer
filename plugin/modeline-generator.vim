" Generate a modeline for the current file.
function! s:GenerateModeline(prefix, separator, options)
    let l:modeline = a:prefix
    for l:op in a:options
        " The argument to a ':set' command can be empty.
        if l:op
            if !exists(&l:op)
                execute 'let l:opval = &'.l:op
                let l:modeline .= l:op.
            else
                echoerr 'Unknown option: '.l:op
                return l:modeline
            endif
        endif
    endfor
endfunction

" True if the given string is a valid vim modeline.
function! s:IsVimModeline(str)
endfunction

function! s:HasModeline()
endfunction

" Vim supports the following two 'modeline' formats:
"
"
"   [text]{white}{vi:|vim:|ex:}[white]{options}
"
"       [text]                  Any text or empty.
"       {white}                 At least one whitespace character (<Space> or
"                               <Tab>).
"       {vi:|vim:|ex:}          The listed string literals.
"       [white]                 Optional whitespace.
"       {options}               A list of option settings, separated with white
"                               space or ':', where each part between ':' is
"                               the argument for a ':set' command (can be
"                               empty).
"
"
"   [text]{white}{vi:|vim:|Vim:|ex:}[white]se[t] {options}:[text]
"
"       [text]                  Any text or empty.
"       {white}                 At least one whitespace character (<Space> or
"                               <Tab>).
"       {vi:|vim:|Vim:|ex:}     The listed string literals.
"       [white]                 Optional whitespace.
"       se[t]                   The string 'set ' or 'se '. When 'Vim:' is
"                               used, it must be 'set '.
"       {options}               A list of options, separated with white space,
"                               which is the argument for a ':set' command.
"       :                       A colon literal.
"       [text]                  Any text or empty.
"
" There is one exception: 'vi:' and 'vim:' can also be at the start of the
" line.

" let g:_VIM_ML_PFX_FMT = "\S*\(\s\=\(vi\|vim\)\|\(\s\{1}\(Vim\|ex\)\)\):\s\="

" All Vim option names are strings of lowercase letters.
let s:_OP_NAME_FMT = "\l\+"

" String option values can consist of any
let g:_VIM_STR_VALUE_FMT = "\S\+"
let g:_VIM_NUM_VALUE_FMT = "\(0x\x\+\|0\o\+\|\d\+\)"
let g:_VIM_VALUE_FMT = "\(".g:_VIM_STR_VALUE_FMT."\|".g:_VIM_NUM_VALUE_FMT."\)"

" The format of arguments for a ':set' command.
let g:_VIM_SET_ARG_FMT =
    \ g:_VIM_OP_NAME_FMT."\(\s\=\)[\+\^\-]=".g:_VIM_VALUE_FMT







" let g:_VIM_OP_FMT = "\a"

" let vim_ml_fmt = "\S*\s\+\(vi\|vim\|Vim\|ex\):\s\=\(set \)\="
"
" \S is probably better than \p
" let vim_set_op_fmt = "\a\+\(=\=\p*\)\="
" let s:vim_option_fmt = ""

" \S is probably better than \p
" let s:vim_ml_fmt = "\S*\s\+\(vi\|vim\|Vim\|ex\):\s\=\(set \)\=\a\+\(=\=\p\+\)\="
