image:
	docker build --platform linux/amd64 -t dw-cli:2.12.0 .
verify:
	python3 verify.py
# The book does not ask the reader to install Node — it asks for Docker, because
# that is what the engine needs. Node is how the Runner is served, so say that
# here, once, at the only moment it matters.
playground:
	@command -v node >/dev/null 2>&1 || { \
	  echo "The Runner is served by Node, which is not on your PATH."; \
	  echo "Install Node 22.6 or newer from https://nodejs.org, then run make playground again."; \
	  echo "Or run an example straight from the engine:"; \
	  echo "  ./dw.sh run -s -i payload=chapters/language-01/order.json -f chapters/language-01/02_summary.dwl"; \
	  exit 1; }
	@node playground/start.mjs
playground-check:
	node playground/selfcheck.mjs --all
.PHONY: image verify playground playground-check
