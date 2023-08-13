# GIT_INFO must evaluated at zsh str expansion time
# If the value is substitued at evaluation time,
# the expansion is degraded and cannot be interpreted
# by zsh.
GIT_INFO='$(git_prompt_info)'


# hostname (green)
# @hostname (green)
# [k8s cluster] if any (cold, hot colour depending on env)
# current path (orange)
# [git branch and state] (green)
# (bold) -> prompt (purple or red depending on previous error)
PROMPT="%F{106}%n@%m$(k8s_cluster_info) %F{197}[%~]%f %B$GIT_INFO%b
%B$(colored_prompt '->')%b %f "


# Git-prompt-related configuration
# 112
ZSH_THEME_GIT_PROMPT_PREFIX="%F{106}["
ZSH_THEME_GIT_PROMPT_SUFFIX="]%f"
ZSH_THEME_GIT_PROMPT_DIRTY=" %F{197}*%F{106}"
ZSH_THEME_GIT_PROMPT_CLEAN=""
