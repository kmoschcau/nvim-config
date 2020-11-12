syntax match javaExt_SemiColon /;/

syntax match javaExt_Operator />>=\|<<=\|>>>/
syntax match javaExt_Operator /++\|--\|+=\|-=\|*=\|\/=\|%=\|&=\||=\|^=\|==\|!=\|>=\|<=\|&&\|||\|<<\|>>/
syntax match javaExt_Operator /[+\-*/%=><!&|~^?:.]\ze\%(\<\|\s\|$\)/
syntax cluster javaTop add=javaExt_Operator

syntax region javaExtInt_MethodCall matchgroup=javaExt_MethodCall start=/\k\+(/ end=/)/ contains=@javaTop transparent
syntax cluster javaTop add=javaExtInt_MethodCall

syntax match javaExt_AssignedIdent /\k\+\ze\s*=\s*\%([^=]\|$\)/

highlight default link javaExt_AssignedIdent Identifier
highlight default link javaExtInt_MethodCall Function
highlight default link javaExt_Operator      Operator
highlight default link javaExt_SemiColon     Special