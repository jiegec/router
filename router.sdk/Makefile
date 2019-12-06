BOOT.bin: output.bif ./fsbl/Debug/fsbl.elf ./design_1_wrapper_hw_platform_0/design_1_wrapper.bit ./router/Debug/router.elf
	bootgen -image output.bif -arch zynq -o BOOT.bin -w on
