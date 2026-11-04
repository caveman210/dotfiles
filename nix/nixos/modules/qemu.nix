{ pkgs, ... }: {
	boot.binfmt = {
		emulatedSystems = [ "aarch64-linux" ];
		preferStaticEmulators = true;
	};
	nixpkgs.config.allowUnsupportedSystem = true;
	environment.systemPackages = with pkgs; [ 
		qemu
		qemu-user
		qemu-utils
		virglrenderer
		
		# e2fsprogs
		# dosfstools
		# mtools
	];	
}
