authors:
	sh scripts/authors.sh -f

publish:
	sh scripts/publish.sh -f

format:
	sh scripts/format.sh -f

cov:
	sh scripts/cov.sh -f

create:
	sh scripts/create_tag.sh -f

tags:
	sh scripts/check_release_tag.sh -f
