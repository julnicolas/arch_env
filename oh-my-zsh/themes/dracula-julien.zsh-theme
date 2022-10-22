PROMPT=$'%{$FG[120]%}%n@%m$(k8s_cluster_info) %{$FG[202]%}[%~]%{$reset_color%} $(git_prompt_info)\
%{$FG[104]%}-> %{$reset_color%} '

ZSH_THEME_GIT_PROMPT_PREFIX="%{$FG[120]%}["
ZSH_THEME_GIT_PROMPT_SUFFIX="]%{$reset_color%}"
ZSH_THEME_GIT_PROMPT_DIRTY=" %{$FG[202]%}*%{$FG[120]%}"
ZSH_THEME_GIT_PROMPT_CLEAN=""
