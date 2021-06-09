syntax clear javaLangObject

syntax match javaExt_Comma /,/
syntax cluster javaTop add=javaExt_Comma

syntax match javaExt_SemiColon /;/
syntax cluster javaTop add=javaExt_SemiColon

syntax match javaExt_Operator />>=\|<<=\|>>>/
syntax match javaExt_Operator /++\|--\|+=\|-=\|*=\|\/=\|%=\|&=\||=\|^=\|==\|!=\|>=\|<=\|&&\|||\|<<\|>>/
syntax match javaExt_Operator /[+\-*/%=><!&|~^?:.]\ze\%(\<\|\s\|$\)/
syntax cluster javaTop add=javaExt_Operator

syntax region javaExtInt_MethodCall matchgroup=javaExt_MethodCall start=/\k\+(/ end=/)/ contains=@javaTop,javaParenT transparent
syntax cluster javaTop add=javaExtInt_MethodCall

syntax match javaExt_AssignedIdent /\k\+\ze\s*=\s*\%([^=]\|$\)/
syntax cluster javaTop add=javaExt_AssignedIdent

highlight default link javaExt_AssignedIdent Identifier
highlight default link javaExt_Comma         Special
highlight default link javaExt_MethodCall    Function
highlight default link javaExt_Operator      Operator
highlight default link javaExt_SemiColon     Special
