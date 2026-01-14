EXAMPLES := minimal standard

.PHONY: render render-all validate validate-all test e2e clean

render: render-all

render-all:
	@for example in $(EXAMPLES); do \
		echo "Rendering $$example..."; \
		up composition render \
			apis/traefiks/composition.yaml \
			examples/traefiks/$${example}.yaml \
			--include-full-xr; \
	done

validate: validate-all

validate-all:
	@for example in $(EXAMPLES); do \
		echo "Validating $$example..."; \
		up composition render \
			apis/traefiks/composition.yaml \
			examples/traefiks/$${example}.yaml \
			--include-full-xr \
			--xrd=apis/traefiks/definition.yaml; \
	done

test:
	up project generate
	up test run tests/*

e2e:
	up test run tests/e2etest-*

clean:
	rm -rf _output .up .tmp
