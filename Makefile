PROJECT_NAME?=Async

test:
	@xctool -scheme ${PROJECT_NAME} test -parallelize

.PHONY: test
