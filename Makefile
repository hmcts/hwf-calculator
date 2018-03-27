.PHONY: zap-passive-scanning zap-passive-scanning-report stop remove clean

define container-id-for
	$(shell docker ps -f 'label=com.docker.compose.project=$(1)' -f 'label=com.docker.compose.service=$(2)' -q)
endef

### Docker housekeeping ###
clean: stop remove
remove:
	docker-compose -f docker/tests/docker-compose.yml -p calculator rm -f
stop:
	docker-compose -f docker/tests/docker-compose.yml -p calculator stop


### Security tests ###
security-tests: zap-passive-scanning zap-passive-scanning-report stop
zap-passive-scanning:
	docker-compose -f docker/tests/docker-compose.yml -p calculator up --build security-tests
zap-passive-scanning-report:
	# Generate the HTML report
	docker exec $(call container-id-for,calculator,zap) zap-cli -p 8095 report -f html -o /tmp/zap-passive-scanning-results.html
	# Get the report
	docker cp $(call container-id-for,calculator,zap):/tmp/zap-passive-scanning-results.html /tmp
	@echo "Open /tmp/zap-passive-scanning-results.html in your browser"
