# Matugen theme for fzf
export FZF_DEFAULT_OPTS="$FZF_DEFAULT_OPTS \
--color=bg+:-1,bg:-1,spinner:{{colors.tertiary.default.hex}},hl:{{colors.primary.default.hex}} \
--color=fg:{{colors.on_surface.default.hex}},header:{{colors.primary.default.hex}},info:{{colors.secondary.default.hex}},pointer:{{colors.primary.default.hex}} \
--color=marker:{{colors.tertiary.default.hex}},fg+:{{colors.on_surface.default.hex}},prompt:{{colors.primary.default.hex}},hl+:{{colors.primary.default.hex}} \
--color=selected-bg:{{colors.surface_container_high.default.hex}},border:{{colors.outline_variant.default.hex}}"
