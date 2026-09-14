image:
	docker build --platform linux/amd64 -t dw-cli:2.12.0 .
verify:
	python3 verify.py
