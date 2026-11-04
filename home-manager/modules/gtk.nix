{ config, ... }:
{
	# gtk.css is intentionally left unmanaged so matugen can own it.
	# Nautilus (libadwaita) reloads these files directly, which avoids
	# the @import-through-a-Nix-symlink problem the old setup had.
	gtk = {
		enable = true;
		colorScheme = "dark";

		gtk3 = {
			enable = true;
			colorScheme = "dark";
		};

		gtk4 = {
			enable = true;
			colorScheme = "dark";
		};
	};
}
