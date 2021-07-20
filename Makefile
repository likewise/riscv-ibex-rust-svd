.ONESHELL:
all:
	set -e
	#cd ../svd2rust/
	#cargo run -- --target=riscv -i ../minimal-riscv-rust/app/super_system.svd
	#../svd2rust/target/debug/svd2rust --target=riscv -i ../minimal-riscv-rust/app/super_system.svd
	rm -rf ibex_supersystem_pac
	cargo new ibex_supersystem_pac --lib --name ibex-supersystem
	cd ibex_supersystem_pac
	rm -rf src
	echo SVD
	svd2rust --target=riscv -i ../ibex_supersystem.svd
	mkdir src
	form -i lib.rs -o src/
	rm lib.rs
	cargo fmt
	echo "bare-metal = \"1.0.0\"" >>Cargo.toml
	echo "riscv = \"0.6.0\"" >>Cargo.toml
	echo "vcell = \"0.1.3\"" >>Cargo.toml
	cargo build --target riscv32imc-unknown-none-elf
clean:
	rm -rf build.rs device.x lib.rs
