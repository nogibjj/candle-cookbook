format:
	cargo fmt --quiet

lint:
	cargo clippy --quiet

install:
	cargo install mdbook

serve:
	mdbook serve -p 8000 -n 127.0.0.1

cookbook:
	mdbook build