IMAGE := open-fisca-finland

build:
	docker build -t $(IMAGE) .

run: build
	docker run --rm -it $(IMAGE)

query: build
	docker run --rm --entrypoint scasp $(IMAGE) --tree --human src/entrepreneur.pl facts/example.pl

test: build
	@pass=0; fail=0; errors=""; \
	for f in test/t*.pl; do \
		name=$$(basename $$f .pl); \
		if docker run --rm --entrypoint scasp $(IMAGE) -s0 --no_nmr src/entrepreneur.pl $$f 2>/dev/null | grep -q "Answer"; then \
			printf "  PASS  %s\n" "$$name"; \
			pass=$$((pass + 1)); \
		else \
			printf "  FAIL  %s\n" "$$name"; \
			fail=$$((fail + 1)); \
			errors="$$errors $$name"; \
		fi; \
	done; \
	echo ""; \
	echo "$$pass passed, $$fail failed"; \
	if [ $$fail -gt 0 ]; then echo "Failed:$$errors"; exit 1; fi
